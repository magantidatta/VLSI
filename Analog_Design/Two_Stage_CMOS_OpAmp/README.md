# Two-Stage CMOS Operational Amplifier Design

## Overview
This project presents the **design and implementation of a two-stage CMOS operational amplifier**
using **180nm CMOS technology**. The design was carried out using **Cadence Virtuoso** with the
objective of achieving **high gain** and **suitable bandwidth** for analog signal amplification.

The operational amplifier operates at a **2.5 V DC supply** with a **30 µA bias current**.
Performance evaluation was performed using **AC and transient response analysis**.

---

## Design Specifications
- **Technology:** 180nm CMOS
- **Supply Voltage:** 2.5 V
- **Bias Current:** 30 µA
- **Architecture:** Two-stage CMOS Operational Amplifier
  - Differential amplifier (input stage)
  - Common-source amplifier (second stage)

---

## Performance Results
- **DC Gain:** 72.2 dB (at 12 kHz)
- **Phase:** −68.68° at 109.648 kHz
- **3-dB Bandwidth:** 44.3 kHz
- **Output Voltage:** 5 V for 5 mV input

The above results were obtained from **AC response analysis** and are verified through simulation.

---

## Design Flow
1. Schematic design of two-stage CMOS Op-Amp
2. Symbol creation and amplification verification
3. AC response analysis
4. Transient response analysis
5. Layout generation
6. GDS II generation

---

## Tools Used
- **Cadence Virtuoso**
- **180nm CMOS Technology**

---

## Documentation
📄 **Project Poster:**  
All design details, schematics, AC response plots, transient response, and layout information
are documented in the academic poster presented for this project.

🔗 **Poster Link:**  
[Poster of Two Stage CMOS OP-AMP](https://github.com/magantidatta/VLSI/blob/main/Analog_Design/Two_Stage_CMOS_OpAmp/Poster%20of%20Two%20Stage%20CMOS%20OP-AMP.png)


---

## Key Learnings
- Two-stage CMOS operational amplifier architecture
- Gain and bandwidth analysis
- AC and transient response interpretation
- Analog CMOS design flow using Cadence Virtuoso

---

## Conclusion
The two-stage CMOS operational amplifier demonstrates **high gain** and **good bandwidth**
as verified through simulation. The project covers the complete analog design process from
schematic design to layout and GDS II generation.
