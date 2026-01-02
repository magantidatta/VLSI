# Leakage Power Optimization in CMOS Inverter

## Overview
This project focuses on the **analysis and optimization of leakage power in a CMOS inverter**
using **low-power design techniques**. The objective was to reduce static (leakage) power
consumption while understanding the impact of optimization techniques on **propagation delay**.

The design and analysis were performed using **SPICE-based simulations** in **180nm CMOS technology**.

---

## Design Details
- **Technology:** 180nm CMOS
- **Circuit:** CMOS Inverter
- **Analysis Type:** Leakage power and delay evaluation

---

## Leakage Reduction Techniques Applied
- **Transistor stacking**
- **Self-biasing**
- **W/L (width-to-length) optimization**

These techniques were applied individually and comparatively to study their effectiveness
in reducing leakage power.

---

## Results
- **Initial Leakage Power:** 50.05 pW  
- **Optimized Leakage Power:** 575.43 fW  

A significant reduction in leakage power was achieved at the cost of **increased propagation delay**,
highlighting the inherent **leakage–delay trade-off** in low-power CMOS design.

---

## Analysis Performed
- Leakage power comparison across techniques
- Delay impact due to leakage reduction
- Trade-off evaluation between power and performance

---

## Tools Used
- **LTSpice**
- **SPICE-based circuit simulation**

---

## Key Learnings
- Understanding of leakage mechanisms in CMOS circuits
- Practical application of low-power design techniques
- Impact of device sizing on leakage and delay
- Power–performance trade-offs in nanoscale CMOS design

---

## Conclusion
The project demonstrates that **leakage power in CMOS inverters can be significantly reduced**
using transistor-level optimization techniques. However, the reduction in leakage comes with
an increase in delay, emphasizing the importance of **balanced low-power design decisions**
in VLSI systems.
