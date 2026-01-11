# STACK PROCESSOR  
**Front End Simulation and FPGA Synthesis Lab**

**Author:** M. Shanmukha Sri Datta  
**Roll No:** CB.EN.P2VLD24007  

---

## Project Report

📄 **Complete Project Report (PDF):**  
🔗 https://github.com/magantidatta/VLSI/blob/main/Digital_Design/Digital%20Project%20Report.pdf

This report contains the detailed explanation of the stack processor design, Verilog implementation, testbench, simulation waveforms, RTL schematic, and result analysis.

---

## Abstract

This project focuses on the design and simulation of a **stack-based processor** using **Verilog HDL**. A stack processor follows the **Last-In First-Out (LIFO)** principle to store and manipulate data. The processor supports basic **arithmetic operations** such as addition, subtraction, multiplication, and division, along with **logical operations** including AND, OR, XOR, and NOT.

The architecture consists of a **16-element, 8-bit stack memory** and a **control unit** that manages stack operations using opcode-based instruction decoding. Functional verification is carried out using a Verilog testbench, and simulation results confirm correct operation of all supported instructions.

---

## Introduction

Stack-based processors are widely used in computing systems for efficient expression evaluation and temporary data storage. Unlike register-based architectures, stack processors perform operations directly on stack elements, resulting in simpler instruction formats.

In this project, an **8-bit stack processor** is designed using Verilog HDL to explore the fundamentals of stack-based processing and verify its functionality through simulation.

---

## Objectives

- Design a stack processor using Verilog HDL  
- Implement a 16 × 8-bit stack memory  
- Support arithmetic and logical operations  
- Verify functionality using simulation  
- Analyze behavioral results  

---

## Architecture Overview

### Stack Memory
- 16 elements deep  
- 8-bit wide per element  
- Operates on LIFO principle  

### Stack Pointer
- 4-bit register  
- Tracks top of the stack  

### Control Logic
- Decodes 4-bit opcode  
- Controls stack and ALU operations  

---

## Instruction Set

| Opcode | Operation | Description |
|------|----------|-------------|
| 0001 | PUSH | Push data onto stack |
| 0010 | POP | Pop data from stack |
| 0011 | ADD | Add top two stack elements |
| 0100 | SUB | Subtract top two stack elements |
| 0101 | MULT | Multiply top two stack elements |
| 0110 | DIV | Divide top two stack elements |
| 0111 | AND | Logical AND |
| 1000 | OR | Logical OR |
| 1001 | XOR | Logical XOR |
| 1010 | NOT | Logical NOT |

---

## Conclusion

The stack processor designed in this project successfully performs stack-based arithmetic and logical operations. Simulation results validate correct functionality, demonstrating the effectiveness of stack-based processor architecture.

---

## Tools Used

- Verilog HDL  
- ModelSim / Vivado Simulator  
- FPGA synthesis tools  

---
