# SystemVerilog Data Types & Execution Semantics  
### Phase 2: Language Foundations for Verification

## Overview

With the conceptual foundations established in **Phase 1**, this phase marks the
transition from *why verification works the way it does* to *how SystemVerilog
actually models data and execution*.

Phase 2 focuses on **SystemVerilog language foundations** that form the base of
all RTL and verification code. Rather than building DUTs or testbenches, this
phase isolates and explains **core language constructs** through small,
self-contained examples.

Strong verification environments are built on **strong data modeling and
execution semantics**.

📄 **Detailed Notes (PDF):**  
👉 [SystemVerilog Data Modeling & Execution Semantics – Day 2](https://github.com/magantidatta/VLSI/blob/main/Functional%20Verification/Need%20for%20System%20Verilog/Day2_SystemVerilog_DataTypes.pdf)

---

## What This Document Covers

This phase answers practical and foundational questions such as:

- How SystemVerilog represents data internally
- Why 2-state and 4-state modeling matters in verification
- The difference between variables and nets
- How arrays are modeled for different data behaviors
- How user-defined types improve readability and intent
- How procedural blocks and assignments control execution

This phase builds the **mental model required to write correct SystemVerilog
code**, not just syntactically valid code.

---

## Key Language Concepts Explained

### Data Representation: 2-State vs 4-State
- Why real hardware requires X and Z modeling
- How 2-state types can hide bugs
- Why verification prefers 4-state accuracy

---

### Variables vs Nets
- Variables model **storage**
- Nets model **connectivity**
- When to use `logic`, `wire`, `int`, and `bit`
- Why `logic` is the preferred default

---

### Array Modeling in SystemVerilog
SystemVerilog supports multiple array categories:

- Packed arrays (bit-level vectors)
- Unpacked arrays (element collections)
- Fixed-size arrays
- Dynamic arrays
- Queues
- Associative arrays

Each array type exists to model a **specific verification use case**, such as
memories, FIFOs, scoreboards, and dynamic stimulus.

---

### User-Defined Data Structures
- `typedef` for clean type abstraction
- `struct` for grouping related data
- `enum` for readable and safe state modeling

These constructs allow verification code to model **transactions instead of
signals**.

---

### Procedural Execution & Assignments
- Procedural blocks: `initial`, `always`, `always_comb`, `always_ff`
- Blocking (`=`) vs Non-Blocking (`<=`) assignments
- Correct usage rules to avoid race conditions

Understanding execution semantics is critical for **both RTL correctness and
testbench reliability**.

---


---

## Scope of This Phase

✅ SystemVerilog data modeling  
✅ Language execution semantics  
✅ Verification-relevant constructs  
❌ No UVM  
❌ No interfaces  
❌ No full testbench architecture  

This phase focuses on **how SystemVerilog behaves**, not how to build frameworks.

---

## Relationship to Phase 1

- **Phase 1** explained *why modern verification requires SystemVerilog*
- **Phase 2** explains *how SystemVerilog models data and execution*

Together, they form the **conceptual + technical foundation** required before
moving into structured testbench design.

## What Comes Next?

📌 **PHASE 3: Procedural Blocks, Tasks & Functions**  

Phase 3 moves deeper into **execution control and reusable behavior modeling**
in SystemVerilog. This phase focuses on **how code is structured, executed, and
reused** inside verification environments.

Key concepts include:

- `task` vs `function`
- `void` functions
- Argument passing: `input`, `output`, `ref`, `const ref`
- Automatic vs static variables
- Time literals and delays (e.g. `#10ns`)

This phase builds on Phase 2 by explaining **how SystemVerilog code executes over
time and how behavior is encapsulated**, which is essential before moving into
interfaces, clocking blocks, or UVM.

---

## Intended Audience

- Beginners learning SystemVerilog properly
- Verification engineers building strong fundamentals
- RTL engineers transitioning into verification
- Anyone preparing for verification interviews with depth

---

> **Good verification is not about writing more code —  
it is about writing the *right* code with the *right* understanding.**


