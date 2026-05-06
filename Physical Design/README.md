# 🚀 Physical Design Projects | RTL-to-GDSII Implementation

This repository contains hands-on ASIC Physical Design projects implemented using Synopsys tools in SAED 90nm technology.

The projects cover:
- RTL-to-GDSII Flow
- Floorplanning
- Power Distribution Network (PDN)
- Placement Optimization
- Clock Tree Synthesis (CTS)
- Static Timing Analysis (STA)
- Routing & Sign-off
- Timing Closure

---

# 📂 Projects

## ⏱️ Multi-Corner Timing Analysis of Asynchronous FIFO
Focused on:
- Multi-corner timing analysis
- Dual-clock CTS optimization
- Setup/Hold timing closure
- PDN and routing optimization

### Key Results
✔ Zero setup and hold violations  
✔ Improved setup slack from **+1.08 ns → +1.48 ns**  
✔ Achieved final hold slack of **+0.60 ns**  

🔗 [`View Project`](./Multi-Corner%20Timing%20Analysis%20of%20Asynchronous%20FIFO)

---

## 📡 Clock Tree Optimization of SPI Protocol
Focused on:
- CTS optimization
- Clock skew control
- Timing closure improvement
- QoR and power impact analysis

### Key Results
✔ Achieved timing closure at **200 MHz**  
✔ Improved setup slack from **+1.27 ns → +2.31 ns**  
✔ Implemented optimized clock tree with skew control  

🔗 [`View Project`](./Clock%20Tree%20Optimization%20of%20SPI%20Protocol)

---

## 🚀 RTL-to-GDSII Implementation of RV32I RISC-V Core
Focused on:
- Complete RTL-to-GDSII implementation
- Synthesis and STA
- CTS and routing optimization
- Post-layout timing closure

### Key Results
✔ Achieved timing closure at **100 MHz**  
✔ Post-route setup slack: **+3.27 ns**  
✔ Zero setup and hold violations  
✔ DRC-clean final routed layout  

🔗 [`View Project`](../RTL-to-GDSII)

---

# 🛠️ Tools Used
- Synopsys Design Compiler
- Synopsys IC Compiler II
- Synopsys PrimeTime
- Synopsys VCS
- SAED 90nm Technology

---

# 👨‍💻 Author
**Shanmukha Sri Datta**  
M.Tech VLSI Design  
Physical Design | Timing Closure | RTL-to-GDSII Flow
