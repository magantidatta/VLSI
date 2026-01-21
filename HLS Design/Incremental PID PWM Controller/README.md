
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
