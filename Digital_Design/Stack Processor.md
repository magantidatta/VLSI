# STACK PROCESSOR  
**Front End Simulation and FPGA Synthesis Lab**

**Author:** M. Shanmukha Sri Datta  
**Roll No:** CB.EN.P2VLD24007  

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

## Methodology

The stack processor is implemented using synchronous Verilog logic triggered on the positive edge of the clock. A reset signal initializes the stack pointer and output.

- **PUSH:** Stores input data and increments stack pointer  
- **POP:** Retrieves top element and decrements stack pointer  
- **Arithmetic/Logical Operations:**  
  - Operate on top stack elements  
  - Store result back in stack  
  - Reduce stack size accordingly  

A Verilog testbench generates clock and reset signals and applies instruction sequences to verify functionality.

---

## Simulation and Verification

The testbench performs the following:
1. Reset initialization  
2. PUSH operations  
3. Arithmetic operations (ADD, SUB, MULT, DIV)  
4. Logical operations (AND, OR, XOR, NOT)  
5. POP operations to verify LIFO behavior  

Simulation outputs are monitored using waveform analysis.

---

## Results and Discussion

Simulation results confirm correct stack processor behavior:

- PUSH and POP operations follow LIFO principle  
- Arithmetic operations produce accurate results  
- Logical operations function correctly  
- Stack pointer updates as expected  

---

## Outputs

- Behavioral Simulation Waveforms  
- Timing Diagram  
- RTL Schematic  
- Post-Implementation Results  

---

## Conclusion

The stack processor designed in this project successfully performs stack-based arithmetic and logical operations. The simulation validates correct functionality, demonstrating the effectiveness of stack-based processor architecture.

---

## Future Scope

- Increase stack depth and data width  
- Add more instructions  
- Implement instruction memory  
- FPGA hardware implementation  

---

## Tools Used

- Verilog HDL  
- ModelSim / Vivado Simulator  
- FPGA synthesis tools  

---
