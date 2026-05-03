# 📡 Clock Tree Optimization of SPI Protocol (90nm)

## 🚀 Overview
This project demonstrates **Clock Tree Synthesis (CTS) and Timing Closure** of an SPI Protocol Controller using Synopsys Physical Design flow in **SAED 90nm technology**, targeting **200 MHz**.

The focus of this work is:
> Improving timing through **clock tree optimization** and analyzing its impact on **QoR and power**

---

## 🎯 Key Highlights
- Achieved timing closure at **200 MHz (5 ns)**
- Improved setup slack:
  - **Pre-CTS:** +1.27 ns  
  - **Post-CTS:** +2.31 ns  
- Implemented optimized **clock tree with skew control**
- Observed **~37.8% power contribution from clock network**
- Clean QoR with no setup violations

---

# 🧩 Final Layout

![Final Layout](https://github.com/magantidatta/VLSI/blob/main/Physical%20Design/Clock%20Tree%20Optimization%20of%20SPI%20Protocol/final_layout.png)

✔ Compact floorplan with routed design  
✔ Proper placement, CTS, and routing closure  

---

# ⏱️ Timing Analysis (CTS Impact)

## 📉 Pre-CTS Timing Report
🔗 [View Pre-CTS Setup Report](https://github.com/magantidatta/VLSI/blob/main/Physical%20Design/Clock%20Tree%20Optimization%20of%20SPI%20Protocol/pre_cts_setup.rpt)

- Initial timing before clock tree insertion  
- Ideal clock assumption  
- Setup slack: **+1.27 ns**

---

## 📈 Post-CTS Timing Report
🔗 [View Post-CTS Setup Timing](https://github.com/magantidatta/VLSI/blob/main/Physical%20Design/Clock%20Tree%20Optimization%20of%20SPI%20Protocol/post_cts_setup_timing.rpt)

- Real clock tree with buffers and skew  
- Propagated clock delays included  
- Setup slack improved to: **+2.31 ns**

---

## 📊 Timing Improvement Summary

| Stage     | Setup Slack |
|----------|------------|
| Pre-CTS  | +1.27 ns   |
| Post-CTS | +2.31 ns   |

✔ Significant improvement due to optimized clock tree  
✔ Demonstrates effectiveness of CTS in timing closure  

---

# ⚡ Power Insight
- Total Power: **1.01e+08 pW**
- Clock Network Contribution: **~37.8%**

✔ Highlights impact of clock tree on overall power  

---

# 🛠️ Tools Used
- Synopsys Design Compiler  
- Synopsys IC Compiler II  
- PrimeTime  
- SAED 90nm Technology  

---

# 🧠 Key Learnings
- Clock Tree Synthesis is critical for timing closure  
- Skew optimization directly impacts setup timing  
- Clock network significantly affects power  
- Practical understanding of ASIC Physical Design flow  

---

# 👨‍💻 Author
**Shanmukha Sri Datta**  
M.Tech VLSI Design  
Physical Design | Timing Closure | ASIC Flow  
