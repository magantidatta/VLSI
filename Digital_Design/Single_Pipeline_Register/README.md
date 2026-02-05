# Single-Stage Pipeline Register using Valid/Ready Handshake (SystemVerilog)

## Problem Statement

**Task:**  
Implement a single-stage pipeline register in SystemVerilog using a standard valid/ready handshake.

**Logic Requirements:**  
The module sits between an input and output interface and:

- Accepts data when `in_valid && in_ready`
- Presents stored data on the output using `out_valid`
- Correctly handles downstream backpressure
- Prevents data loss and duplication
- Fully synthesizable
- Resets to a clean, empty state

---

## Solution Overview

This project implements a **single-entry pipeline stage (1-deep buffer)** using synthesizable SystemVerilog RTL.

The design acts as a register slice between two blocks and ensures:

- Safe data transfer
- Correct handshake behavior
- Backpressure support
- One-cycle latency
- One-word-per-cycle throughput

The module is verified through simulation and synthesized using **Vivado** to confirm hardware correctness.

---

## Tools & Environment

- SystemVerilog
- Vivado (Simulation + Synthesis)
- GitHub

---

## Repository Structure

```
Single_Pipeline_Register/         main folder
│
├── Code_and_Testbench/           
│     ├── pipeline_register.sv
│     └── pipeline_register_tb.sv
│
├── RTL_Schematic.png
├── Synthesized_schematic_1.png
└── Synthesized_schematic_2.png

```
## RTL Design and Testbench

The complete SystemVerilog implementation and verification environment are available in the following directory:

 **Code Location:**  
https://github.com/magantidatta/VLSI/tree/main/Digital_Design/Single_Pipeline_Register/Code_and_Testbench

Contents:
- `pipeline_register.sv` – Synthesizable RTL design  
- `pipeline_register_tb.sv` – SystemVerilog functional testbench

## RTL & Synthesis Results

### RTL Elaborated Schematic
This shows the single-stage register structure inferred from the RTL.

![RTL Schematic](https://github.com/magantidatta/VLSI/blob/main/Digital_Design/Single_Pipeline_Register/RTL_Schematic.png)

---

### Synthesized Netlist – View 1
Post-synthesis schematic confirming one data register and valid control logic.

![Synthesized Schematic 1](https://github.com/magantidatta/VLSI/blob/main/Digital_Design/Single_Pipeline_Register/Synthesized_schematic_1.png)

---

### Synthesized Netlist – View 2
Alternate view of the same synthesized design.

![Synthesized Schematic 2](https://github.com/magantidatta/VLSI/blob/main/Digital_Design/Single_Pipeline_Register/Synthesized_schematic_2.png)


---

## Simulation Waveform

Functional simulation in Vivado showing:

- Valid/Ready handshake
- Correct data transfer
- Backpressure behavior
- No data loss or duplication

![Waveform](https://github.com/magantidatta/VLSI/blob/main/Digital_Design/Single_Pipeline_Register/Testbench.png)


## Key Features

- Single register stage (1-deep buffer)
- Standard Valid/Ready handshake protocol
- Backpressure safe operation
- No data loss
- No data duplication
- Fully synthesizable RTL
- Clean reset behavior (empty state after reset)
- Supports full throughput (1 word per cycle)
- One-cycle latency


