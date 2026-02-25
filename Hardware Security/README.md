# 🔐 Scan Chain Insertion in ALU for Hardware Security
### Encrypted Scan Cell Based Secure DFT Architecture  
**Tools Used:** Synopsys Design Compiler (V-2023.12) | SAED 90nm | Verilog HDL  

---

## 📌 Project Overview

This project presents the design and implementation of a **secure 8-bit ALU** integrated with an **Encrypted Scan Chain architecture** to mitigate scan-based hardware attacks.

Traditional scan chains improve testability but expose internal registers to:

- Reverse engineering  
- Key extraction  
- Fault injection  
- Scan-based side-channel attacks  

To address this, a **custom Encrypted Scan Cell** is proposed and integrated into the ALU at both:

- ✅ Input Side  
- ✅ Output Side  

A detailed **area, power, and timing comparison** is performed using Synopsys Design Compiler.

---

# 1. Base 8-bit ALU Architecture

![ALU Design](https://github.com/magantidatta/VLSI/blob/main/Hardware%20Security/ALU%20Design.jpg)

### Inputs
- `A` → 8-bit
- `B` → 8-bit
- `ALU_Sel` → 3-bit
- `clk`

### Outputs
- `ALU_Out` → 8-bit
- `Zero` → 1-bit flag

### Supported Operations

| ALU_Sel | Operation |
|----------|------------|
| 000 | A + B |
| 001 | A - B |
| 010 | A & B |
| 011 | A \| B |
| 100 | A ^ B |
| 101 | ~A |
| 110 | A << 1 |
| 111 | A >> 1 |

The ALU is fully synchronous and synthesized in **SAED 90nm technology**.

---

# 2. Encrypted Scan Cell Architecture

![Encrypted Scan Cell](https://github.com/magantidatta/VLSI/blob/main/Hardware%20Security/Encrypted%20Scan%20Cell%20Design.jpg)

## Architecture Components

### 🔹 1. LFSR Generator (4-bit)
- Generates dynamic encryption key  
- Clock-driven pseudo-random sequence  
- LSB used as encryption value (EV)  

### 🔹 2. XOR Encryption Block
- `Encrypted_SI = SI ⊕ EV`  
- If EV = 1 → Scan bit flips  
- If EV = 0 → No change  

### 🔹 3. Muxed D Flip-Flop
- Dual mode operation:
  - SE = 0 → Functional Mode  
  - SE = 1 → Encrypted Scan Mode  

### 🔒 Security Impact

- Prevents direct scan data extraction  
- Obfuscates internal states  
- Blocks unauthorized scan pattern reconstruction  
- Protects against scan-chain based IP theft  

---

# 3. Scan Chain Inserted at Input Side

![Input Scan](https://github.com/magantidatta/VLSI/blob/main/Hardware%20Security/ALU%20with%20Scan%20Cell%20at%20Input%20Side.jpg)

### Characteristics

- Scan inserted before ALU inputs  
- Operand `A` passes through encrypted scan cells  
- `B` and `ALU_Sel` are registered  
- Scan chain modifies operand values during test mode  

---

# 4. Scan Chain Inserted at Output Side

![Output Scan](https://github.com/magantidatta/VLSI/blob/main/Hardware%20Security/ALU%20with%20Scan%20Cell%20at%20Output%20Side.jpg)

### Characteristics

- Scan inserted after ALU computation  
- `ALU_Out` passes through encrypted scan cells  
- Captures final computation results  

---

# 5. Synopsys Synthesis Results (SAED90nm)

## 🔹 Area Comparison

| Configuration | Total Area |
|---------------|------------|
| Input Scan | 153.585560 |
| Output Scan | 175.669983 |

---

## 🔹 Power Comparison

| Configuration | Dynamic Power |
|---------------|--------------|
| Input Scan | 0.2866 µW |
| Output Scan | 0.2671 µW |

---

## 🔹 Timing Analysis

| Configuration | Slack |
|---------------|--------|
| Input Scan | 3.66 ns |
| Output Scan | 3.66 ns |

- Critical Path Delay: 6.34 ns  
- Required Time: 10.00 ns  
- No timing violations  

---

# 🧠 Engineering Conclusion

📌 Input-side scan is **area-efficient**  
📌 Output-side scan is **power-efficient**  
📌 Both configurations meet timing constraints  

This demonstrates that secure scan insertion can be implemented without degrading performance, while enabling architectural trade-offs between area and power.

---

# 🏆 Final Outcome

This project demonstrates:

- Secure DFT integration in digital design  
- LFSR-based scan encryption for hardware protection  
- Quantitative area–power–timing tradeoff analysis  
- Successful synthesis and validation in SAED 90nm technology  

Suitable for:

- Secure SoC Design  
- Cryptographic Hardware  
- Defense Electronics  
- IP-Protected ASIC Design  

---

# 👨‍💻 Author

**Maganti Shanmukha Sri Datta**  
M.Tech VLSI Design  

---
