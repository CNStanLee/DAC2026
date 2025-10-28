from data.download_dataset import download_dataset
from data.data_utils import get_preqnt_dataset
from torch.utils.data import DataLoader, Dataset
import torch
from models.models import CybSecMLPForExport, get_model
from models.model_utils import test_unsw
from torch.utils.data import DataLoader, Dataset
from copy import deepcopy
import numpy as np
from models.model_utils import test_unsw_padded_bipolar
import os
#
from brevitas.export import export_qonnx
from qonnx.util.cleanup import cleanup as qonnx_cleanup
from qonnx.core.modelwrapper import ModelWrapper
from qonnx.core.datatype import DataType
from finn.transformation.qonnx.convert_qonnx_to_finn import ConvertQONNXtoFINN
import shutil
import finn.builder.build_dataflow as build
import finn.builder.build_dataflow_config as build_cfg
from models.model_utils import save_padded_unsw_model

device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
print("Target device: " + str(device))

def unsw_nb15_padding_model():
    # Load dataset, model, test original accuracy
    print("Running UNSW-NB15 experiment...")
    download_dataset("unsw_nb15")
    train_quantized_dataset = get_preqnt_dataset("data/unsw", True)
    test_quantized_dataset = get_preqnt_dataset("data/unsw", False)
    print("Samples in each set: train = %d, test = %s" % (len(train_quantized_dataset), len(test_quantized_dataset)))
    print("Shape of one input sample: " +  str(train_quantized_dataset[0][0].shape))
    batch_size = 1000
    train_quantized_loader = DataLoader(train_quantized_dataset, batch_size=batch_size, shuffle=True)
    test_quantized_loader = DataLoader(test_quantized_dataset, batch_size=batch_size, shuffle=False)   
    model = get_model("unsw_nb15", 2, 2)  # Example model instantiation
    model = model.to(device)
    # Load pretrained weights
    trained_state_dict = torch.load("models/checkpoints/unsw_w2a2.pth", weights_only=False)["models_state_dict"][0]
    model.load_state_dict(trained_state_dict, strict=False)
    # Test the model
    test_accuracy = test_unsw(model, test_quantized_loader, device)
    print("Test accuracy: %.2f%%" % (test_accuracy * 100))
    # Pad model
    modified_model = deepcopy(model.cpu())
    W_orig = modified_model[0].weight.data.detach().numpy()
    W_new = np.pad(W_orig, [(0,0), (0,7)])
    modified_model[0].weight.data = torch.from_numpy(W_new)
    save_padded_unsw_model(
        old_ckpt_path="models/checkpoints/unsw_w2a2.pth",
        new_ckpt_path="models/checkpoints/unsw_w2a2_padded.pth"
    )

def unsw_nb15_test_model():
    batch_size = 1000
    test_quantized_dataset = get_preqnt_dataset("data/unsw", False)
    test_quantized_loader = DataLoader(test_quantized_dataset, batch_size=batch_size, shuffle=False)  
    model = get_model("unsw_nb15_padded", 2, 2)
    trained_state_dict = torch.load("models/checkpoints/unsw_w2a2_padded.pth", weights_only=False)["models_state_dict"][0]
    model.load_state_dict(trained_state_dict, strict=False)
    model = model.to(device)
    #
    model_for_export = CybSecMLPForExport(model)
    model_for_export.to(device)
    test_accuracy = test_unsw_padded_bipolar(model_for_export, test_quantized_loader, device)
    print("Test accuracy after padding and bipolar conversion: %.2f%%" % (test_accuracy * 100))
    return model_for_export

def unsw_nb15_export_onnx(model_for_export):
    ready_model_filename = "models/unsw/cybsec-mlp-ready.onnx"

    os.makedirs(os.path.dirname(ready_model_filename), exist_ok=True)
    input_shape = (1, 600)
    # create a QuantTensor instance to mark input as bipolar during export
    input_a = np.random.randint(0, 1, size=input_shape).astype(np.float32)
    input_a = 2 * input_a - 1
    scale = 1.0
    input_t = torch.from_numpy(input_a * scale)
    # Move to CPU before export
    model_for_export.cpu()
    # Export to ONNX
    export_qonnx(
        model_for_export, export_path=ready_model_filename, input_t=input_t
    )
    # clean-up
    qonnx_cleanup(ready_model_filename, out_file=ready_model_filename)
    # ModelWrapper
    model = ModelWrapper(ready_model_filename)
    # Setting the input datatype explicitly because it doesn't get derived from the export function
    model.set_tensor_datatype(model.graph.input[0].name, DataType["BIPOLAR"])
    model = model.transform(ConvertQONNXtoFINN())
    model.save(ready_model_filename)
    print("Model saved to %s" % ready_model_filename)

def unsw_nb15_estimate_ip():
    model_file = "models/unsw/cybsec-mlp-ready.onnx"
    estimates_output_dir = "output/unsw/output_estimates_only"

    #Delete previous run results if exist
    if os.path.exists(estimates_output_dir):
        shutil.rmtree(estimates_output_dir)
        print("Previous run results deleted!")

    cfg_estimates = build.DataflowBuildConfig(
        output_dir          = estimates_output_dir,
        mvau_wwidth_max     = 80,
        target_fps          = 1000000,
        synth_clk_period_ns = 10.0,
        fpga_part           = "xc7z020clg400-1",
        steps               = build_cfg.estimate_only_dataflow_steps,
        generate_outputs=[
            build_cfg.DataflowOutputType.ESTIMATE_REPORTS,
        ]
    )
    build.build_dataflow_cfg(model_file, cfg_estimates)
def unsw_nb15_export_ip():
    model_file = "models/unsw/cybsec-mlp-ready.onnx"
    rtlsim_output_dir = "output/unsw/output_ipstitch_ooc_rtlsim"
    #Delete previous run results if exist
    if os.path.exists(rtlsim_output_dir):
        shutil.rmtree(rtlsim_output_dir)
        print("Previous run results deleted!")

    cfg_stitched_ip = build.DataflowBuildConfig(
        output_dir          = rtlsim_output_dir,
        mvau_wwidth_max     = 80,
        target_fps          = 1000000,
        synth_clk_period_ns = 10.0,
        fpga_part           = "xc7z020clg400-1",
        generate_outputs=[
            build_cfg.DataflowOutputType.STITCHED_IP,
            build_cfg.DataflowOutputType.RTLSIM_PERFORMANCE,
            build_cfg.DataflowOutputType.OOC_SYNTH,
        ]
    )
    build.build_dataflow_cfg(model_file, cfg_stitched_ip)

def unsw_nb15_experiment():
    unsw_nb15_padding_model()
    model_for_export = unsw_nb15_test_model()
    unsw_nb15_export_onnx(model_for_export)
    unsw_nb15_estimate_ip()
    unsw_nb15_export_ip()
    print("finished UNSW-NB15 experiment.")
if __name__ == "__main__":
    # download the dataset
    unsw_nb15_experiment()