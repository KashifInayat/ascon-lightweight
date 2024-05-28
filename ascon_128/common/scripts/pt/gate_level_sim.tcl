#Designer: Kashif Inayat, INU South Korea (www.kashifinayat.github.io)
power $::env(UUT)_tb.uut
run 40ns
power -enable
run 100000ns
power -disable
power -report netlist.saif 1e-9 $::env(UUT)_tb.uut
#.uut
quit
