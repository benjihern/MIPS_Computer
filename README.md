# 32-bit MIPS Processor Design (VHDL)
## Overview
This project implements a fully functional 32-bit MIPS-style microprocessor using VHDL, designed to support memory access, R-type, and I-type instructions.
The processor includes custom datapath components, a memory module with memory-mapped I/O, and a multi-stage control unit for instruction execution.
Development, simulation, and synthesis were performed using Intel Quartus Prime.

The design emphasizes modularity, extensibility, and simulation validation through waveform analysis.

## Features
- 32-bit MIPS-compatible CPU architecture
- Support for R-type and I-type instruction sets
- Memory-mapped I/O with two input ports and one output port
- Modular datapath components (ALU, Register File, RAM, Control Unit)
- Fully synthesized RTL-level hardware using VHDL
- Verified functionality through simulation waveforms and memory dumps

## Project Architecture
- ** Datapath Components
  - ALU (Arithmetic Logic Unit) with signed/unsigned multiply, shifting, branching
  - 32x32 Register File with dual read and single write ports
  - Memory module with 256x32 RAM and mapped I/O ports
  - Instruction Register (IR) and Program Counter (PC)
  - Auxiliary registers: HI, LO, ALUOut, RegA, RegB

- ** Control Unit
  - Finite state machine (FSM) controller
  - Handles instruction fetch, decode, execute, memory access, and write-back cycles
  - Supports PCWrite, MemRead, MemWrite, ALUSrc, RegWrite, and branching controls
    
## Development Tools
- VHDL for hardware description
- Intel Quartus Prime for synthesis and simulation
- ModelSim for functional simulation and waveform analysis

  
