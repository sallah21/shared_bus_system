del -f ex1
del -f ex1.vcd

iverilog -Wall -s EX1_tb -o ex1 -f tv80_src.cmd mem.v ex1.v
if ERRORLEVEL 1 goto ON_ERROR

vvp ex1
if ERRORLEVEL 1 goto ON_ERROR

goto SIM_EXIT

:ON_ERROR
echo Terminating on error.

:SIM_EXIT

