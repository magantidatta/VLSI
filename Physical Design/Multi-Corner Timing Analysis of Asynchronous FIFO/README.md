# 🚀 Multi-Corner Timing Analysis & CTS Optimization of Asynchronous FIFO

## 📌 Overview
This project demonstrates the complete Physical Design implementation and multi-corner timing analysis of a dual-clock Asynchronous FIFO using Synopsys ASIC flow in SAED 90nm technology.

The FIFO operates across two asynchronous clock domains:
- **Write Clock Domain:** 200 MHz (5 ns)
- **Read Clock Domain:** 100 MHz (10 ns)

The focus of this project is:
> Achieving clean setup and hold timing closure across multiple timing corners while optimizing Clock Tree Synthesis (CTS), skew, and power integrity.

---

## 🎯 Key Highlights
- Achieved timing closure with **zero setup and hold violations**
- Implemented dual-clock **Clock Tree Synthesis (CTS)** for asynchronous domains
- Improved setup slack from **+1.08 ns (Pre-CTS)** → **+1.48 ns (Post-CTS)**
- Achieved final hold slack of **+0.60 ns**
- Implemented robust **Ring + Mesh Power Distribution Network (PDN)**
- Performed timing-driven placement and routing optimization
- Used propagated clocks for accurate post-CTS timing analysis

---

# 🧩 Floorplan & Physical Design

## Floorplan Configuration
- Core Size: **95 µm × 95 µm**
- Core Offset: **10 µm**
- Timing-driven placement enabled

### Physical Design Highlights
✔ Compact floorplan architecture  
✔ Automated I/O pin placement  
✔ Dual-clock physical implementation  
✔ Timing-aware placement optimization  

---

# ⚡ Power Distribution Network (PDN)

Implemented:
- Power Rings
- Mesh-based PDN
- Standard Cell Power Rails

### PDN Highlights
✔ Stable power delivery across both clock domains  
✔ Improved routing robustness and power integrity  
✔ Hybrid Ring + Mesh PDN architecture  

---

# 📊 Multi-Corner Timing Analysis

Two timing scenarios were created for accurate corner-based timing analysis.

| Scenario | Analysis Type | Corner |
|----------|---------------|--------|
| scenario_setup | Setup Analysis | Worst Corner (Cmax) |
| scenario_hold | Hold Analysis | Best Corner (Cmin) |

### Analysis Features
✔ Cmax corner for worst-case setup analysis  
✔ Cmin corner for best-case hold analysis  
✔ TLU+ parasitic models used for RC extraction  
✔ Proper asynchronous clock domain isolation using clock groups  

---

# 📍 Placement Results

## QoR Summary

| Metric | Result |
|--------|--------|
| Worst Setup Slack | +1.08 ns |
| Worst Hold Slack | +0.69 ns |
| Setup Violations | 0 |
| Hold Violations | 0 |
| Total Negative Slack | 0 |
| Cell Count | 473 |
| Sequential Cells | 168 |
| Combinational Cells | 305 |

### Key Achievements
✔ Zero setup violations  
✔ Zero hold violations  
✔ Successful timing closure across timing corners  

---

# 🌲 Clock Tree Synthesis (CTS)

CTS was implemented for both asynchronous clock domains using:
- Dedicated CTS clock buffers/inverters
- NDR (Non-Default Routing Rules)
- CCD (Concurrent Clock and Data Optimization)

### CTS Optimization Highlights
✔ Balanced dual-clock tree synthesis  
✔ Low-skew clock distribution  
✔ Optimized clock transition and capacitance  
✔ Applied skew constraints during CTS optimization  
✔ Improved timing after propagated clock analysis  

---

# 📈 Post-CTS Clock QoR

| Clock | Sinks | Levels | Max Skew |
|-------|--------|--------|----------|
| VCLK_W | 148 | 2 | 0.23 ns |
| VCLK_R | 20 | 1 | 0.00 ns |

### CTS Improvements
- Pre-CTS setup slack: **+1.08 ns**
- Post-CTS setup slack: **+1.48 ns**

✔ Demonstrates timing improvement after CTS optimization  

---

# ⏱️ Timing Analysis

## Pre-CTS Timing
- Worst setup slack: **+1.08 ns**
- Worst hold slack: **+0.69 ns**
- Ideal clock propagation

## Post-CTS Timing
- Worst setup slack: **+1.48 ns**
- Worst hold slack: **+0.60 ns**
- Propagated clock analysis enabled

## Final Sign-off Timing
- Final setup slack after routing: **+1.47 ns**
- Zero setup violations
- Zero hold violations

### Timing Closure Summary

| Analysis | Result |
|----------|--------|
| Final Setup Slack | +1.47 ns |
| Final Hold Slack | +0.60 ns |
| Setup Violations | 0 |
| Hold Violations | 0 |

✔ Successful timing closure achieved  

---

# 🛣️ Routing & Sign-off

Routing flow included:
- Timing-driven routing
- Crosstalk-aware optimization
- Antenna fixing
- Post-route timing optimization

### Sign-off Achievements
✔ Zero setup violations  
✔ Zero hold violations  
✔ Clean routing completion  
✔ Stable post-route timing closure  

---

# 🛠️ Tools Used
- Synopsys Design Compiler  
- Synopsys IC Compiler II  
- Synopsys PrimeTime  
- SAED 90nm Technology  

---

# 🧠 Key Learnings
- Practical understanding of multi-corner timing analysis  
- Dual-clock asynchronous timing closure  
- CTS optimization using NDR and CCD  
- Importance of propagated clock analysis  
- PDN impact on routing and power integrity  
- Setup/Hold optimization across process corners  

---

# 👨‍💻 Author
**Shanmukha Sri Datta**  
M.Tech VLSI Design  
Physical Design | Timing Closure | ASIC Flow
