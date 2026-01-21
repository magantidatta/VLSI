# FPGA-Based Incremental PID–PWM Controller

## 📌 Project Overview
This project implements an **Incremental PID–PWM Controller** on FPGA for closed-loop motor position/speed control.  
The design focuses on **reduced computational complexity**, **efficient hardware utilization**, and **real-time performance** by combining **Vivado HLS**, **RTL design**, and **IP-based PWM generation**.

Unlike conventional PID controllers that compute absolute control outputs, the **incremental PID algorithm computes only the change in control output**, making it well suited for FPGA-based embedded systems.

---
📄 **Detailed Design Report:**  
👉 [ASIC Term Project Report – Incremental PID–PWM Controller (PDF)](https://github.com/magantidatta/VLSI/blob/main/HLS%20Design/Incremental%20PID%20PWM%20Controller/ASIC_Term_Project.pdf)

---

## 🧠 Key Features
- Incremental PID control using **scaled integer arithmetic**
- Hardware-friendly design with **low computational overhead**
- Modular architecture with **HLS + RTL + IP integration**
- Verified using **C simulation, RTL simulation, and FPGA testing**
- Implemented on **Basys 3 FPGA**

---

## 🏗️ System Architecture
The design consists of three major blocks:

### 1️⃣ Incremental PID Controller (Vivado HLS)
- Implemented in **C++** using Vivado HLS  
- Computes PWM duty cycle incrementally based on:
  - Current error  
  - Previous errors  
- Uses **fixed-point arithmetic** for efficient FPGA implementation  
- Outputs updated duty cycle within safe limits (**0–255**)

### 2️⃣ PWM Generator (Vivado IP)
- Generates PWM signal based on duty cycle  
- Adjustable duty cycle resolution  
- Provides `pwm_done` signal at the end of each PWM cycle  

### 3️⃣ Control Block (RTL – Verilog)
- Manages synchronization between PID and PWM blocks  
- Generates enable signals for sequential operation  
- Ensures stable and controlled execution  

---

## 🔁 Incremental PID Equation
The incremental PID control law is given by:

Δu(n) = Kp·(e(n) − e(n−1)) + Ki·e(n) + Kd·(e(n) − 2e(n−1) + e(n−2))


Where:
- `e(n)` is the current error  
- `Kp`, `Ki`, `Kd` are scaled PID gains  
- `Δu(n)` is the change in PWM duty cycle  

---

## 🧪 Verification & Testing
The design was verified at multiple levels:

### ✔ C Simulation (HLS)
- Verified PID logic correctness  
- Tested multiple setpoint and feedback cases  
- Ensured correct incremental behavior  

### ✔ RTL Simulation
- Verified control logic and PWM behavior  
- Observed waveform-level correctness  
- Confirmed enable and handshake signals  

### ✔ FPGA Validation
- Implemented on **Basys 3 FPGA**  
- Observed PWM output behavior on hardware  
- Verified duty cycle response to changing feedback  

---

## 🛠️ Tools & Technologies
- **Languages**: C++, Verilog  
- **HLS**: Vivado HLS  
- **EDA Tools**: Vivado, QuestaSim  
- **Hardware**: Basys 3 FPGA  
- **Design Flow**: HLS → RTL Integration → FPGA Implementation  

---

## 🚀 Applications
- Embedded motor control  
- Robotics and automation  
- Real-time control systems  
- FPGA-based control accelerators  

---

## 📌 Key Learnings
- Hardware implementation of control algorithms  
- HLS to RTL IP integration  
- FPGA-based real-time system design  
- Timing-aware and resource-efficient design practices  

---

## 📄 Author
**Maganti Shanmukha Sri Datta**  
M.Tech – VLSI Design  
📍 Hyderabad, India  
