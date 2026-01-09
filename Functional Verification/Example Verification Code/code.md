# 🧪 Two Bit Adder – SystemVerilog Functional Verification

This repository contains a **complete SystemVerilog functional verification environment** for a **2-bit combinational adder**, implemented using **mailboxes, virtual interfaces, and transaction-level modeling** (non-UVM).

The project follows an **industry-style layered verification architecture** and is intended for **learning, practice, and resume demonstration** purposes.

---

## 📌 Objective

- Verify a 2-bit adder using SystemVerilog
- Implement Generator–Driver–Monitor–Scoreboard architecture
- Use mailboxes for inter-process communication
- Demonstrate parallel execution using fork–join
- Run and validate simulation in QuestaSim

---

## 🧩 DUT Description

**Inputs**
- `a` : 2-bit operand  
- `b` : 2-bit operand  
- `valid` : Indicates valid transaction  

**Output**
- `c` : 4-bit sum (`a + b`)

The DUT is connected to the testbench using a **SystemVerilog interface**.

---

## 🏗️ Verification Architecture

Generator → Driver → DUT → Monitor → Scoreboard

### Generator
- Randomizes inputs `a` and `b`
- Creates transaction objects
- Sends transactions to the driver via mailbox

### Driver
- Drives DUT inputs through virtual interface
- Controls `valid` signal
- Captures DUT output

### Monitor
- Passively samples DUT signals
- Collects input/output when `valid` is asserted
- Sends observed transactions to the scoreboard

### Scoreboard
- Computes expected result (`a + b`)
- Compares with DUT output
- Reports PASS / FAIL

---

## 📁 Directory Structure

Two Bit Adder Verification Codes/
│
├── adder_intf.sv // Interface
├── adder.sv // DUT
├── transaction.sv // Transaction class
├── generator.sv // Generator
├── driver.sv // Driver
├── monitor.sv // Monitor
├── scoreboard.sv // Scoreboard
├── environment.sv // Environment
├── test.sv // Test
└── testbench.sv // Top-level testbench

## [Path for codes](https://github.com/magantidatta/VLSI/tree/main/Functional%20Verification/Example%20Verification%20Code/Two%20Bit%20Adder%20Verification%20Codes)
Each verification component is maintained in a **separate file**, similar to real industry projects.

---

## ⚙️ Simulation Tool

- **Simulator**: QuestaSim / ModelSim  
- **Language**: SystemVerilog  
[ GENERATOR ] : a=1 b=1 valid=1
[ DRIVER ]    : a=1 b=1 c=2 valid=1
[ MONITOR ]   : a=1 b=1 c=2
[ SCOREBOARD ] PASS : 2

[ GENERATOR ] : a=3 b=3 valid=1
[ DRIVER ]    : a=3 b=3 c=6 valid=1
[ MONITOR ]   : a=3 b=3 c=6
[ SCOREBOARD ] PASS : 6

## 🧠 Concepts Demonstrated

- SystemVerilog Interfaces & Virtual Interfaces
- Transaction-Level Modeling (TLM)
- Mailboxes for IPC
- fork–join parallel execution
- Self-checking Scoreboard
- Modular and reusable verification components

