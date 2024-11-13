#!/bin/bash

rm -f ex1
rm -f ex1.vcd
clear
iverilog -Wall -s EX1_tb -o ex1 -f tv80_src.cmd mem.v ex1.sv BFM.sv IO.sv timer.sv

if [ $? -eq 1 ]; then
    echo Source compilation failure
    exit 1
fi

vvp ex1

if [ $? -ne 0 ]; then
    echo Running simulation failure
    exit 1
fi

# gtkwave BFM.gtkw
gtkwave BFM_limited.gtkw


if [$? -ne 0]; then
    echo GTKWave failure
    exit 1
fi

