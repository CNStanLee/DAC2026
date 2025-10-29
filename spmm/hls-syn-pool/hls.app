<AutoPilot:project xmlns:AutoPilot="com.autoesl.autopilot.project" projectType="C/C++" name="hls-syn-pool" top="Testbench_pool">
    <files>
        <file name="../../maxpool_tb.cpp" sc="0" tb="1" cflags=" -I/home/changhong/prj/finn_dev_branch/finn/script/DAC2026/spmm/finn_hlslib  -I/home/changhong/prj/finn_dev_branch/finn/script/DAC2026/spmm/finn_hlslib/tb -std=c++14  -Wno-unknown-pragmas" csimflags=" -Wno-unknown-pragmas" blackbox="false"/>
        <file name="pool_top.cpp" sc="0" tb="false" cflags="-std=c++14 -I/home/changhong/prj/finn_dev_branch/finn/script/DAC2026/spmm/finn_hlslib -I/home/changhong/prj/finn_dev_branch/finn/script/DAC2026/spmm/finn_hlslib/tb" csimflags="" blackbox="false"/>
    </files>
    <solutions>
        <solution name="sol1" status=""/>
    </solutions>
    <Simulation argv="">
        <SimFlow name="csim" setup="false" optimizeCompile="false" clean="false" ldflags="" mflags=""/>
    </Simulation>
</AutoPilot:project>

