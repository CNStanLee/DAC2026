from utils.cli_logger import Logger
from models.models import single_layer
from utils.pruning import analyze_model_sparsity, global_magnitude_prune_with_min
from utils.export_ip import finn_export_ip, finn_export_onnx
from qonnx.core.datatype import DataType
import finn.builder.build_dataflow_config as build_cfg

# set random seed for reproducibility
import torch
import json
import re
from datetime import datetime
torch.manual_seed(1998)    

FPS_MAX = 10000000000
FPS_MIN = 1

def mvau_ablation_test(ablation_name="a0_mvau_ablation",
                       calculation_size=64,
                        sparsity=0.9,
                         strategy_no=1,
                          target_fps=1,
                          ):
     
    strategy = build_cfg.hybridsp_estimate_steps

    test_name = f"""size{calculation_size}_sp{int(sparsity*100)}_s{strategy_no}_fps{target_fps}"""
    log_dir = f"logs/ablation/{ablation_name}"
    log_name = f"{test_name}.log"
    logger = Logger(filename=log_name, log_dir=log_dir)
    start_time = datetime.now()
    logger.log(f"Starting MVAU ablation test at {start_time.strftime('%Y-%m-%d %H:%M:%S')}...")
    model = single_layer(w=2, a=2, size=calculation_size)
    logger.log(f"Model created: {model}")
    sparsity_info = analyze_model_sparsity(model)
    logger.log(f"Sparsity analysis: {sparsity_info}")
    pruned_model = global_magnitude_prune_with_min(model, target_sparsity=sparsity)
    logger.log(f"Pruned model: {pruned_model}")
    pruned_sparsity_info = analyze_model_sparsity(pruned_model)
    logger.log(f"Pruned model sparsity analysis: {pruned_sparsity_info}")
    # print the weights after pruning

    for name, param in pruned_model.named_parameters():
        if 'weight' in name:
            logger.log(f"Weights of {name} after pruning: {param.data}")

    finn_export_onnx(pruned_model.cpu(),
                      output_onnx_path=f"models/ablation/{ablation_name}/onnx/{test_name}_pruned.onnx",
                       input_shape=(1, calculation_size),
                        input_datatype=DataType["INT2"],
                         output_datatype=DataType["INT2"])
    finn_export_ip(f"models/ablation/{ablation_name}/onnx/{test_name}_pruned.onnx",
                    output_dir=f"models/ablation/{ablation_name}/{test_name}_pruned_ip",
                     mvau_wwidth_max=10000,
                      target_fps=target_fps, # MAX
                        synth_clk_period_ns=10.0,
                            fpga_part="xczu7ev-ffvc1156-2-e", # Target ZCU 104
                             steps = strategy)




if __name__ == "__main__":
    sparsity_list = [0.1, 0.3, 0.5, 0.7, 0.9]
    fps_list = [1, 400000, 800000, 1600000, 25600000]
    strategy = 6
    Matrix_size = 16


    for sparsity in sparsity_list:
        for target_fps in fps_list:
            mvau_ablation_test(ablation_name="a3_tile_sp_estimate_only",
                    calculation_size=Matrix_size,
                    sparsity=sparsity,
                        strategy_no=strategy,
                        target_fps=target_fps)