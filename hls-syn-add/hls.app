<AutoPilot:project xmlns:AutoPilot="com.autoesl.autopilot.project" projectType="C/C++" name="hls-syn-add" top="Testbench_add">
    <Simulation argv="">
        <SimFlow name="csim" setup="false" optimizeCompile="false" clean="false" ldflags="" mflags=""/>
    </Simulation>
    <files>
        <file name="../../add_tb.cpp" sc="0" tb="1" cflags=" -I/home/changhong/prj/finn_dev/finn/script/DAC2026/spmm/finn-hlslib  -I/home/changhong/prj/finn_dev/finn/script/DAC2026/spmm/finn-hlslib/tb -std=c++14  -Wno-unknown-pragmas" csimflags=" -Wno-unknown-pragmas" blackbox="false"/>
        <file name="add_top.cpp" sc="0" tb="false" cflags="-std=c++14 -I/home/changhong/prj/finn_dev/finn/script/DAC2026/spmm/finn-hlslib -I/home/changhong/prj/finn_dev/finn/script/DAC2026/spmm/finn-hlslib/tb" csimflags="" blackbox="false"/>
    </files>
    <solutions>
        <solution name="sol1" status=""/>
    </solutions>
</AutoPilot:project>

