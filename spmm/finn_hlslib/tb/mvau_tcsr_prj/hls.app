<AutoPilot:project xmlns:AutoPilot="com.autoesl.autopilot.project" top="Testbench_mvau_tcsr_stream" name="mvau_tcsr_prj">
    <includePaths/>
    <libraryFlag/>
    <files>
        <file name="../../tcsr_mvau_stream_tb.cpp" sc="0" tb="1" cflags=" -I/home/changhong/prj/finn_cli_fork/scripts/DAC2026/spmm/finn_hlslib  -I/home/changhong/prj/finn_cli_fork/scripts/DAC2026/spmm/finn_hlslib/tb -std=c++14  -Wno-unknown-pragmas" csimflags=" -Wno-unknown-pragmas" blackbox="false"/>
        <file name="mvau_stream_top_masked.cpp" sc="0" tb="false" cflags="-std=c++14 -I/home/changhong/prj/finn_cli_fork/scripts/DAC2026/spmm/finn_hlslib -I/home/changhong/prj/finn_cli_fork/scripts/DAC2026/spmm/finn_hlslib/tb" csimflags="" blackbox="false"/>
        <file name="mvau_stream_top.cpp" sc="0" tb="false" cflags="-std=c++14 -I/home/changhong/prj/finn_cli_fork/scripts/DAC2026/spmm/finn_hlslib -I/home/changhong/prj/finn_cli_fork/scripts/DAC2026/spmm/finn_hlslib/tb" csimflags="" blackbox="false"/>
        <file name="tcsr_mvau_stream_top.cpp" sc="0" tb="false" cflags="-std=c++14 -I/home/changhong/prj/finn_cli_fork/scripts/DAC2026/spmm/finn_hlslib -I/home/changhong/prj/finn_cli_fork/scripts/DAC2026/spmm/finn_hlslib/tb" csimflags="" blackbox="false"/>
    </files>
    <solutions>
        <solution name="solution1" status=""/>
    </solutions>
    <Simulation argv="">
        <SimFlow name="csim" setup="false" optimizeCompile="true" clean="false" ldflags="" mflags=""/>
    </Simulation>
</AutoPilot:project>

