import shutil
import os
import finn.builder.build_dataflow as build
import finn.builder.build_dataflow_config as build_cfg
import torch
from brevitas.export import export_qonnx
from qonnx.util.cleanup import cleanup as qonnx_cleanup
from qonnx.core.modelwrapper import ModelWrapper
from qonnx.core.datatype import DataType
from finn.transformation.qonnx.convert_qonnx_to_finn import ConvertQONNXtoFINN

def finn_export_onnx(model,
                      output_onnx_path,
                        input_shape,
                          input_datatype=DataType["INT8"],
                            output_datatype=DataType["INT8"]):
    '''
    model (torch.nn.Module): trained Brevitas model to be exported to ONNX
    output_onnx_path (str): path to save the exported ONNX model
    input_shape (tuple): shape of the input tensor
    input_datatype (DataType): data type of the input tensor
    output_datatype (DataType): data type of the output tensor
    '''
    # create output directory if it doesn't exist
    os.makedirs(os.path.dirname(output_onnx_path), exist_ok=True)

    # Create a dummy input tensor with the specified shape
    dummy_input = torch.randn(input_shape)
    
    # Export the model to ONNX format
    export_qonnx(
        model, export_path=output_onnx_path, input_t=dummy_input
    )
    qonnx_cleanup(output_onnx_path, out_file=output_onnx_path)
    # set input and output data types
    model = ModelWrapper(output_onnx_path)
    model.set_tensor_datatype(model.graph.input[0].name, input_datatype)
    model.set_tensor_datatype(model.graph.output[0].name, output_datatype)
    model = model.transform(ConvertQONNXtoFINN())
    model.save(output_onnx_path)

def finn_export_ip(brevitas_model,
                    output_dir,
                     mvau_wwidth_max=80,
                      target_fps=10000,
                        synth_clk_period_ns=10.0,
                            fpga_part="xc7z020clg400-1",
                             steps = build_cfg.dense_dataflow_steps
                    ):
    '''
    brevitas_model (onnx): trained Brevitas model to be exported to FINN IP
    output_dir (str): directory to save the exported IP
    '''
    #Delete previous run results if exist
    if os.path.exists(output_dir):
        shutil.rmtree(output_dir)
        print("Previous run results deleted!")

    cfg_stitched_ip = build.DataflowBuildConfig(
        output_dir          = output_dir,
        mvau_wwidth_max     = mvau_wwidth_max,
        target_fps          = target_fps,
        synth_clk_period_ns = synth_clk_period_ns,
        fpga_part           = fpga_part,
        steps               = steps,
        generate_outputs=[
            build_cfg.DataflowOutputType.STITCHED_IP,
            build_cfg.DataflowOutputType.RTLSIM_PERFORMANCE,
            build_cfg.DataflowOutputType.OOC_SYNTH,
        ]
    )
    build.build_dataflow_cfg(brevitas_model, cfg_stitched_ip)