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
import time
from datetime import datetime
#
from utils.pruning import analyze_model_sparsity, global_magnitude_prune_with_min
from utils.res_download import download_and_extract_model
from finn.util.basic import alveo_default_platform
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
print("Target device: " + str(device))
#
from acc_configs.resnet50.custom_steps import (
    step_resnet50_tidy,
    step_resnet50_streamline,
    step_resnet50_convert_to_hw,
    step_resnet50_slr_floorplan,
)
 
resnet50_default_steps = [
    step_resnet50_tidy,
    step_resnet50_streamline,
    step_resnet50_convert_to_hw,
    "step_create_dataflow_partition",
    "step_specialize_layers",
    "step_apply_folding_config",
    "step_minimize_bit_width",
    "step_generate_estimate_reports",
    "step_hw_codegen",
    "step_hw_ipgen",
    "step_set_fifo_depths",
    step_resnet50_slr_floorplan,
    "step_create_stitched_ip",
    "step_measure_rtlsim_performance",
    "step_out_of_context_synthesis",
]

resnet50_sparse_steps = [
    step_resnet50_tidy,
    step_resnet50_streamline,
    step_resnet50_convert_to_hw,
    "step_create_dataflow_partition",
    "step_specialize_layers",
    "step_mvau_90_pruning", # new step for 90% pruning
    "step_sparsity_analysis", # new step for sparsity analysis
    "step_apply_folding_config",
    "step_analyze_tile_sparsity", # new step for tile sparsity analysis
    "step_set_mvau_sparse_mode_hybrid", # new step to set MVAU sparse mode
    "step_minimize_bit_width",
    "step_generate_estimate_reports",
    "step_hw_codegen",
    "step_hw_ipgen",
    "step_set_fifo_depths",
    step_resnet50_slr_floorplan,
    "step_create_stitched_ip",
    "step_measure_rtlsim_performance",
    "step_out_of_context_synthesis",
]


def resnet50_experiment():
    start_time = time.time()
    start_dt = datetime.now()
    print(f"Running ResNet50 experiment{start_dt.strftime('%Y-%m-%d %H:%M:%S')}")
    cfg = build_cfg.DataflowBuildConfig(
            steps=resnet50_sparse_steps,
            output_dir="output/resnet50/sparse_flow",
            folding_config_file="acc_configs/resnet50/U250_folding_config.json",
            synth_clk_period_ns=4.0,
            board="U250",
            split_large_fifos=True,
            #shell_flow_type=build_cfg.ShellFlowType.VITIS_ALVEO,
            #vitis_platform=alveo_default_platform["U250"],
            auto_fifo_depths=False,
            #vitis_opt_strategy=build_cfg.VitisOptStrategyCfg.PERFORMANCE_BEST,
            specialize_layers_config_file="acc_configs/resnet50/U250_specialize_layers.json",
            generate_outputs=[
                build_cfg.DataflowOutputType.ESTIMATE_REPORTS,
                build_cfg.DataflowOutputType.STITCHED_IP,
                build_cfg.DataflowOutputType.RTLSIM_PERFORMANCE,
                build_cfg.DataflowOutputType.OOC_SYNTH,
            ],

        )
    model_file = "acc_configs/resnet50/resnet50_w1a2.onnx"
    build.build_dataflow_cfg(model_file, cfg)

    end_time = time.time()
    end_dt = datetime.now()
    elapsed_time = end_time - start_time
    print(f"ResNet50 experiment finished at {end_dt.strftime('%Y-%m-%d %H:%M:%S')}, elapsed time: {elapsed_time:.2f} seconds.")

if __name__ == "__main__":
    resnet50_experiment()