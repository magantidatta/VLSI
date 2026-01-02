# Smart Parking System using VEGA Processor

## Overview
This project focuses on the **design and implementation of a Smart Car Parking System** using the **VEGA ET1031 RISC-V processor**. The system aims to reduce human intervention and improve parking efficiency by integrating **IoT-based hardware components** and **cloud connectivity**.

The project was carried out as part of an **internship at IIT Guwahati , also as a major project in my btech final semester**, emphasizing real-world system integration, embedded programming, and IoT communication.

---

## Objectives
- Automate vehicle entry and exit using RFID technology
- Display real-time parking slot availability
- Reduce traffic congestion and manual effort
- Enable cloud-based monitoring and mobile notifications

---

## System Architecture
The system consists of three major components:
1. **Parking Unit** – Sensors and actuators controlled by VEGA processor
2. **Cloud Platform** – Data visualization and storage using Adafruit IO
3. **Notification System** – Alerts sent to users via IFTTT

---

## Hardware Components
- **VEGA ARIES V2.0 Board (ET1031 RISC-V Processor)**
- **RFID Reader (MFRC522) and RFID Tags**
- **Infrared (IR) Sensors** for slot detection
- **Servo Motor** for barrier gate control
- **ESP8266 WiFi Module**
- LEDs for slot status indication

---

## Software & Tools
- **Arduino IDE** (VEGA board support)
- **Embedded C programming**
- **Adafruit IO** (cloud data visualization)
- **IFTTT** (mobile SMS notifications)

---

## Working Principle
1. User scans RFID card at entry
2. System verifies the RFID UID
3. IR sensors detect parking slot availability
4. Slot status is indicated using LEDs
5. Barrier gate opens using servo motor
6. Parking data is uploaded to Adafruit IO
7. Notifications are sent via IFTTT

---

## Results
- Successful detection of vehicle entry and exit
- Real-time display of parking slot availability
- Cloud-based monitoring through Adafruit IO
- SMS notifications sent to registered users
- Smooth barrier operation using servo motors

---

## Documentation
📄 **Project Report:**  
Complete system design, block diagrams, hardware connections, code, and results
are documented in the project report.

🔗 **Report Link:**  
[Implementation of Car Parking System using VEGA Processor (PDF)](https://github.com/magantidatta/VLSI/blob/main/Internship%20Project/M.%20Shanmukha%20Sri%20Datta%20Major%20Project%20Report.pdf))

---

## Key Learnings
- RISC-V based embedded system design
- RFID-based access control systems
- IoT cloud integration using ESP8266
- Sensor interfacing and actuator control
- End-to-end system integration

---

## Conclusion
The Smart Parking System using VEGA Processor demonstrates an effective **IoT-based
automation solution** for modern parking challenges. By integrating embedded hardware,
cloud platforms, and notification services, the project showcases a practical and scalable
approach to smart parking management.
