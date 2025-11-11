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
from models.cnv_models import letnet5_model
from utils.export_ip import finn_export_onnx, finn_export_ip
#
from utils.pruning import analyze_model_sparsity, global_magnitude_prune_with_min
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
print("Target device: " + str(device))


def lenet5_experiment():
    # load the model
    model = letnet5_model(w=4, a=4)
    model = model.to(device)
    # load pretrained weights
    model.load_state_dict(torch.load("models/checkpoints/lenet5_w4a4.pth"))
    analyze_model_sparsity(model)
    sparse_model = global_magnitude_prune_with_min(model, 0.91)
    analyze_model_sparsity(sparse_model)
    finn_export_onnx(sparse_model.cpu(),
                      output_onnx_path="models/lenet5/lenet5_w4a4_pruned.onnx",
                       input_shape=(1, 1, 32, 32),
                        input_datatype=DataType["INT8"],
                         output_datatype=DataType["INT8"])
    finn_export_ip(brevitas_model="models/lenet5/lenet5_w4a4_pruned.onnx",
                     output_dir="output/lenet5/sparse",
                      mvau_wwidth_max=10000,
                       target_fps=10000,
                        synth_clk_period_ns=10.0,
                         fpga_part="xc7z020clg400-1",
                             steps = build_cfg.custom_dataflow_steps
                            #steps = build_cfg.dense_dataflow_steps
                     )
    # generate the accelerator IP
    print("LeNet-5 experiment finished.")

if __name__ == "__main__":
    # download the dataset
    lenet5_experiment()