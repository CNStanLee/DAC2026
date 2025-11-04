- src/finn/builder/build_dataflow_steps.py
- mod
``` python
708:        max_iters = latency * 1.1 + 100 # 20 to 100
```
- src/finn/transformation/fpgadataflow/set_fifo_depths.py
- mod
``` python
375:               max_iters = latency * 1.1 + 100
```
- src/finn/builder/build_dataflow_config.py
- add
- custom_dataflow_steps

- src/finn/builder/build_dataflow_steps.py
- add
- step_sparsity_analysis
- step_target_fps_parallelization_sparsity
- mod build_dataflow_step_lookup