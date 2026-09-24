# Simple CPU Design
This is meant to be a simple CPU I make to learn Verilog and apply what
I learn in classes, because just reading the textbook is not working.

## Architectural Decisions
Word Size: 16 bits
Instruction Size: 8 bits
Registers: 8
  - 8 16-bit General Purpose
  - PC
  - SP
Address Size: 8 bits
Memory: 32KiB
Big-Endian

## Compiling & Running Instructions
1. Run `verilator --binary --timing --trace-vcd --top-module tb_<...> rtl/<...>.sv testbench/tb_<...>.sv`
1. `cd obj_dir`
1. Open GTKWave `gtkwave <...>.vcd`
