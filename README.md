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
- **Datapath Components**
  - ALU (Arithmetic Logic Unit) with signed/unsigned multiply, shifting, branching
  - 32x32 Register File with dual read and single write ports
  - Memory module with 256x32 RAM and mapped I/O ports
  - Instruction Register (IR) and Program Counter (PC)
  - Auxiliary registers: HI, LO, ALUOut, RegA, RegB

- **Control Unit**
  - Finite state machine (FSM) controller
  - Handles instruction fetch, decode, execute, memory access, and write-back cycles
  - Supports PCWrite, MemRead, MemWrite, ALUSrc, RegWrite, and branching controls
    
## Development Tools
- VHDL for hardware description
- Intel Quartus Prime for synthesis and simulation
- ModelSim for functional simulation and waveform analysis

## Simulation Results

### Datapath RTL Diagram
![datapath](https://github.com/user-attachments/assets/021df629-747b-455b-b105-b564abfb603a)

### Waveform Validation (No Branch or Jump)
![d4_wave](https://github.com/user-attachments/assets/8b6681e5-7f59-4042-b397-a641baaa1e89)

### Register File Values After Execution (No Branch or Jump)
![d4_reg](https://github.com/user-attachments/assets/f837559a-3092-4b40-a817-3535aed81cd9)

### Memory Module Values After Execution (No Branch or Jump)
![d4_mem](https://github.com/user-attachments/assets/d589f2b6-cb06-4189-8286-4eee037adf37)

### Waveform Validation (Full System)
![d5_waveform](https://github.com/user-attachments/assets/24e34ed8-78ee-40b5-bede-ba1ade24967a)

### RAM Values After Execution (Full System)
![d5_memory](https://github.com/user-attachments/assets/78f0a52b-a9e4-481f-8819-ec55a882fa05)
