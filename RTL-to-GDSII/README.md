# RTL-to-GDSII Implementation of RV32I RISC-V Core (90nm)

Complete ASIC implementation of a 32-bit RV32I RISC-V processor from RTL to tape-out-ready GDSII using industry-standard Synopsys tools.

**Flow:** RTL → Synthesis → STA → Floorplanning → CTS → Routing → Post-Layout Timing  
**Tools:** Synopsys Design Compiler, ICC II, PrimeTime, VCS  
**Technology:** SAED 90nm (1P9M)  
**Target Frequency:** 100 MHz  

---

## Project Overview

This project demonstrates full ownership of an industry-grade ASIC implementation flow for a single-cycle RV32I RISC-V core.

The design was:

- Functionally verified at RTL
- Synthesized with timing constraints
- Analyzed using static timing analysis
- Physically implemented using ICC II
- Closed for timing post-routing
- Generated as DRC-clean GDSII

---

## 1. RTL Architecture

### RTL Schematic (Design Compiler)

![RTL Schematic](https://raw.githubusercontent.com/magantidatta/VLSI/main/RTL-to-GDSII/RTL_Schematic.png)

### Architectural Features

- 32-bit RV32I Base Integer ISA
- Single-cycle datapath architecture
- Load-store model
- 32-entry register file (x0 hardwired to zero)
- ALU supporting arithmetic and logical operations
- Control decoder and immediate generator
- Dedicated ALU output register for observability

Each instruction completes in a single clock cycle: Fetch → Decode → Execute → Write-back.

---

## 2. Functional Verification (Synopsys VCS)

### Simulation Log

![Simulation Output](https://raw.githubusercontent.com/magantidatta/VLSI/main/RTL-to-GDSII/simulation_output.png)

Verified instruction set includes:

- ADD, SUB
- AND, OR, XOR
- SLL, SRL, SRA
- SLT, SLTI
- Immediate-type instructions

All instructions were validated using a self-checking testbench.

### Waveform Verification (Custom WaveView)

![Waveform](https://raw.githubusercontent.com/magantidatta/VLSI/main/RTL-to-GDSII/waveform.png)

Waveform analysis confirms:

- Correct PC increment
- Proper ALU operand selection
- Valid register write-back
- Stable clock and reset behavior

---

## 3. Synthesis Results (Design Compiler)

| Metric | Value |
|--------|--------|
| Target Clock Period | 10 ns (100 MHz) |
| Total Cell Area | 61,217 µm² |
| Dynamic Power | 4.31 mW |
| Leakage Power | 385 µW |
| Setup Slack | +3.58 ns (MET) |
| Worst Arrival Time | 5.65 ns |
| Standard Cell Count | 4,533 |

The design met timing with positive slack.  
Clock network accounted for the majority of dynamic power consumption.

---

## 4. Static Timing Analysis (PrimeTime)

- Setup Slack: +3.96 ns  
- Hold Slack: +1.95 ns  
- Critical Path Depth: 41 logic levels  
- Zero setup violations  
- Zero hold violations  

Timing was clean prior to physical implementation.

---

## 5. Physical Design Flow (ICC II)

### Floorplanning
- 70% core utilization
- 20 µm core-to-die offset
- Rectangular floorplan

### Power Planning
- PG Rings: M7 (horizontal), M6 (vertical)
- Standard cell rails on M1

### Placement
- ~4.5K standard cells
- Timing-driven `place_opt`
- Wirelength and congestion optimization

### Clock Tree Synthesis
- 1,024 sequential elements
- Balanced skew strategy
- Setup and hold clean post-CTS

### Routing
- Multi-layer routing (M1–M7)
- DRC clean
- SPEF extraction for post-route analysis

---

## Final Routed Layout

![Final Layout](https://raw.githubusercontent.com/magantidatta/VLSI/main/RTL-to-GDSII/RISC_V_Layout.png)

Tape-out-ready layout with no DRC violations.

---

## Post-Layout Results

| Category | Parameter | Value |
|----------|-----------|-------|
| Timing | Setup Slack | +3.27 ns |
| Timing | Hold Slack | +1.95 ns |
| Timing | Critical Path Delay | 5.94 ns |
| Area | Total Cell Area | 60,012 µm² |
| Area | Total Chip Area | 112,036 µm² |
| Area | Standard Cells | 4,312 |
| Area | Sequential Cells | 1,024 |
| Power | Total Dynamic Power | 4.10 mW |
| Power | Clock Power Contribution | 82.7% |
| Physical | Total Wire Length | 218,385 µm |
| Physical | Total Vias | 42,431 |

Post-route timing closure achieved at 100 MHz with zero setup/hold violations.

---

## Technical Competencies Demonstrated

- RTL microarchitecture design
- Timing constraint development (SDC)
- Logic synthesis and optimization
- Static timing analysis and timing closure
- Floorplanning and power grid design
- Clock tree synthesis and skew management
- Congestion-aware placement and routing
- Post-layout timing verification

---

## Author

Maganti Shanmukha Sri Datta  
M.Tech – VLSI Design  
