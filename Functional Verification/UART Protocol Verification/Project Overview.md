# UART Transmitter Protocol Verification (SystemVerilog)

This repository contains a complete **functional verification environment for a UART Transmitter (TX)** implemented using **SystemVerilog**.  
The verification is performed using a **layered, self-checking testbench architecture** with constrained-random stimulus and functional coverage.

---

## Overview

UART (Universal Asynchronous Receiver Transmitter) is a widely used serial communication protocol in embedded systems and FPGA-based designs.  
This project focuses on verifying the **correct functionality, baud-rate timing, and data integrity** of a UART Transmitter.

---

## Objectives

- Verify correct UART TX frame generation (1 start bit, 8 data bits LSB-first, 1 stop bit)
- Validate baud-rate–controlled serial transmission based on configurable clock frequency and baud rate
- Ensure end-to-end data correctness using a self-checking verification environment with functional coverage

---

## UART Transmitter Design Summary

- **Clock Frequency:** 100 MHz  
- **Baud Rate:** 9600  
- **Clocks per Bit:** ~10416  

### UART Frame Format
- Idle Line: Logic `1`
- Start Bit: Logic `0`
- Data Bits: 8 bits (LSB first)
- Stop Bit: Logic `1`

The UART transmitter is implemented using an **FSM** with the following states:
- `IDLE` – Waits for `tx_start`
- `START` – Transmits start bit
- `DATA` – Transmits 8 data bits
- `STOP` – Transmits stop bit

---

## Verification Architecture

The verification environment follows a **layered architecture**, separating stimulus generation, driving, monitoring, checking, and coverage.

### Interface (`uart_if`)
- Encapsulates DUT signals
- Provides separate driver and monitor modports
- Ensures clean connectivity between DUT and testbench

---

## Verification Components

### Transaction (`uart_transaction`)
Represents a single UART packet.
- `tx_data` – Transmitted byte (randomized)
- `rx_data` – Received byte (monitored)
- `pass` – Result of comparison
- `txn_id` – Transaction ID

---

### Generator (`uart_generator`)
- Randomizes UART transactions
- Controls number of packets (`num_pkts`)
- Sends transactions to the driver via mailbox
- Introduces controlled spacing between packets based on baud rate

---

### Driver (`uart_driver`)
- Drives transactions onto the DUT interface
- Waits for `tx_busy` deassertion
- Generates a single-cycle `tx_start` pulse
- Sends expected data to scoreboard and coverage collector

---

### Monitor (`uart_monitor`)
- Passively observes UART TX line (`txd`)
- Detects start bit using falling edge
- Samples data bits at the center of each bit period
- Reconstructs received byte and forwards it to the scoreboard

---

### Scoreboard (`uart_scoreboard`)
- Compares expected transmitted data with monitored received data
- Declares PASS or FAIL per transaction
- Maintains pass/fail statistics
- Prints transaction-level results

---

### Functional Coverage (`uart_coverage`)
Functional coverage is collected on transmitted data values:
- `0x00` (zero value)
- `0xFF` (maximum value)
- Intermediate values (`0x01` – `0xFE`)

---

### Environment (`uart_env`)
- Instantiates all verification components
- Connects components using mailboxes
- Calculates bit-time based on baud rate
- Controls test execution and synchronization
- Collects final scoreboard and coverage reports

---

### Testbench (`uart_tb`)

**Test Configuration:**
- Clock: 100 MHz
- Baud Rate: 9600
- Number of Transactions: 512

**Test Flow:**
1. Apply reset
2. Create verification environment
3. Generate randomized transactions
4. Drive data to DUT
5. Monitor serial output
6. Validate data in scoreboard
7. Collect and report coverage

---

## Results

- **Simulator:** QuestaSim  
- **Randomized Transactions:** 512  
- **Total Packets Sent:** 512  
- **Total Packets Received:** 512  
- **Pass Count:** 512  
- **Fail Count:** 0  
- **Functional Coverage Achieved:** ~85.94%

All UART frames were correctly transmitted, monitored, and verified by the self-checking scoreboard.

---

### Sample Simulation Output

```text
[DRIVER] Packet=507 sent
ID=507 TX=8c RX=8c RESULT=PASS
[GENERATOR] Packet=508  TX=75
[DRIVER] Packet=508 sent
ID=508 TX=75 RX=75 RESULT=PASS
[GENERATOR] Packet=509  TX=80
[DRIVER] Packet=509 sent
ID=509 TX=80 RX=80 RESULT=PASS
[GENERATOR] Packet=510  TX=5b
[DRIVER] Packet=510 sent
ID=510 TX=5b RX=5b RESULT=PASS
[GENERATOR] Packet=511  TX=8e
[DRIVER] Packet=511 sent
ID=511 TX=8e RX=8e RESULT=PASS
[GENERATOR] DONE. Total packets generated = 512
========================================
EXPECTED PACKETS = 512
RECEIVED PACKETS = 512
========================================
========================================
TOTAL=512 PASS=512 FAIL=0
========================================
Coverage = 85.94%
