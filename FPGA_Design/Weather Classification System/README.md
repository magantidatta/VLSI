# Real-Time Weather Classification System using Basys3 FPGA

## Problem Statement
Many regions lack reliable internet connectivity and consistent power supply, making it difficult to deploy
conventional weather monitoring systems that depend on processors, cloud services, or complex embedded
software. To overcome this limitation, this project presents a **fully offline, hardware-based weather
classification system implemented on FPGA**.

---

## Objectives
- Implement a **real-time weather classification system** that operates completely offline
- Train a machine learning classifier and extract decision thresholds for **hardware realization**
- Utilize a **low-cost DHT11 temperature and humidity sensor** for efficient weather classification

---

## Methodology

### 📌 Fig.1 Methodology Flow
![Methodology Flow](https://github.com/magantidatta/VLSI/blob/main/FPGA_Design/Weather%20Classification%20System/Fig1.png)

The overall methodology begins with dataset collection and decision tree training in Python.
Decision thresholds extracted from the trained model are manually encoded in Verilog.
The design is simulated, verified, and finally deployed on FPGA for real-time weather classification.

---

## RTL Architecture

### 📌 Fig.2 RTL Schematic
![RTL Schematic](https://github.com/magantidatta/VLSI/blob/main/FPGA_Design/Weather%20Classification%20System/Fig2.png)

The RTL design consists of four main Verilog modules:

- **dht11_interface** – Reads the 40-bit data frame from the DHT11 sensor and extracts temperature and humidity values  
- **weather_classifier** – Determines the weather condition using embedded decision logic  
- **lcd_display** – Displays temperature, humidity, and classified weather on an LCD  
- **uart_display** – Transmits data to a PC through UART for real-time monitoring  

This architecture enables **fully offline, hardware-based weather classification** without reliance on
external processors or cloud services.

---

## System Operation

### 📌 Fig.3 Block Diagram – Basys3 FPGA Integration
![Block Diagram](https://github.com/magantidatta/VLSI/blob/main/FPGA_Design/Weather%20Classification%20System/Fig3.png)

The DHT11 sensor captures real-time temperature and humidity data, which is processed by the
**Basys3 FPGA** using Verilog-based classification logic.
The classified weather is displayed on an LCD via a level shifter and simultaneously sent to a PC
through the **PuTTY terminal** using UART.

---

## Simulation Results

### 📌 Fig.4 RTL Simulation Waveform
![RTL Simulation](https://github.com/magantidatta/VLSI/blob/main/FPGA_Design/Weather%20Classification%20System/Fig4.png)

Simulation verifies the Verilog-based weather classification logic using multiple input test frames.
At the first clock edge, temperature and humidity values are extracted, and at the next clock edge,
the corresponding weather classification result is generated.
Weather conditions are encoded to ensure clear visualization in the waveform.

---

## Hardware Results

### 📌 Fig.5 Hardware Output on LCD Display
![LCD Output](https://github.com/magantidatta/VLSI/blob/main/FPGA_Design/Weather%20Classification%20System/Fig5.jpeg)

The LCD displays real-time temperature, humidity, and classified weather condition directly from
the FPGA, confirming correct sensor interfacing and hardware operation.

---

### 📌 Fig.6 PuTTY Terminal Output (UART)
![PuTTY Output](https://github.com/magantidatta/VLSI/blob/main/FPGA_Design/Weather%20Classification%20System/Fig6.jpeg)

The same information is transmitted to a PC through UART and displayed on the PuTTY terminal,
enabling real-time monitoring without internet connectivity.

---

## Design Considerations and Engineering Challenges
Although the project appears conceptually simple, **interfacing standard IoT sensors with the Basys3 FPGA
board presents practical challenges**. Unlike microcontroller platforms such as Arduino or ESP32, the
Basys3 FPGA does not provide prebuilt libraries or high-level driver support for sensor interfacing.

A key objective of this project was to demonstrate that **low-cost, commonly available IoT sensors can be
directly integrated with an FPGA**, without relying on proprietary or expensive PMOD sensor modules.
This approach reduces system cost and improves accessibility for real-world deployments.

As the primary focus was on **hardware integration and RTL-based system design**, the classification
accuracy of the decision tree model was not prioritized in this phase. Instead, emphasis was placed on
successful real-time operation, reliable sensor interfacing, and fully offline execution.

---

## Tools and Technologies
- **FPGA Board:** Basys3
- **HDL:** Verilog
- **Sensor:** DHT11 (Temperature and Humidity)
- **Simulation Tool:**  Vivado
- **Interfaces:** UART, LCD
- **Machine Learning:** Decision Tree (Python)

---

## Future Scope
Future work will focus on  **classification accuracy** by exploring more machine
learning models and optimized threshold extraction techniques. With the hardware integration already
validated, the system can be extended to support models achieving **near 99% accuracy**, while
maintaining offline operation and FPGA-based deployment.

Additional enhancements may include:
- Improved decision logic optimization
- Scalability to multi-parameter environmental monitoring

---

## Conclusion
This project demonstrates an effective **offline, FPGA-based weather classification system** by
combining machine learning concepts with hardware design. By extracting decision logic from a trained
model and implementing it directly in Verilog, the system eliminates the need for processors, cloud
connectivity, and complex software, making it suitable for deployment in resource-constrained environments.
