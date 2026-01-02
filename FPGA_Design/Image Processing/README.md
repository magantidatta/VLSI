# Real-Time CLAHE–Canny Edge Detection on Zynq UltraScale+ MPSoC

## Overview
This project implements a **real-time image edge detection system** using
**Contrast Limited Adaptive Histogram Equalization (CLAHE)** followed by
**Canny edge detection**, deployed on the **Zynq UltraScale+ MPSoC (ZCU104) board**.

The primary objective of the project was to demonstrate that **real-time embedded
image processing can be achieved using software optimization alone**, without
relying on dedicated hardware accelerators or programmable logic (PL).

All image processing was executed on the **ARM Cortex-A53 Processing System (PS)**
using **Python and OpenCV**, with live image capture from a USB camera.

---

## Platform and Tools
- **FPGA Board:** Zynq UltraScale+ MPSoC ZCU104
- **Processing Unit:** ARM Cortex-A53 (PS)
- **Operating System:** PYNQ OS (Linux)
- **Programming Language:** Python
- **Libraries:** OpenCV, NumPy, Matplotlib
- **Camera:** See3CAM_CU30 USB Camera

---

## Methodology
The project followed a structured development flow:

1. **Algorithm Study and Selection**
   - Evaluated Sobel, Prewitt, Laplacian, and Canny edge detection methods
   - Selected **CLAHE + Canny** based on sharpness, noise handling, and suitability
     for real-time embedded execution

2. **PC-Based Simulation**
   - Implemented the complete pipeline in Python using OpenCV
   - Tuned CLAHE parameters (clip limit, tile size) and Canny thresholds
   - Benchmarked output quality and execution time using Google Colab

3. **Embedded Deployment**
   - Configured ZCU104 board with PYNQ OS
   - Established USB Ethernet connectivity
   - Integrated USB camera for live image capture
   - Deployed the same software pipeline on the board

4. **Real-Time Processing Pipeline**
   - Grayscale conversion
   - CLAHE-based contrast enhancement
   - Canny edge detection
   - Visualization and result storage

All processing was performed on the **Processing System only**, without using
programmable logic or HLS-based acceleration.

---

## Performance Evaluation
The system was evaluated using the following metrics:
- **Execution Time**
- **Sharpness** (variance of Laplacian)
- **PSNR (Peak Signal-to-Noise Ratio)**
- **SSIM (Structural Similarity Index)**

### FPGA vs PC Comparison

| Metric | ZCU104 (FPGA) | PC (Google Colab) |
|-----|-----|-----|
| Execution Time | 0.0278 s | 0.019 s |
| Sharpness (Original) | 400.0167 | 400.3663 |
| Sharpness (CLAHE Enhanced) | 915.1854 | 916.2435 |
| PSNR (Original vs Enhanced) | 29.10 dB | 20.20 dB |
| SSIM (Original vs Enhanced) | 0.7986 | 0.7985 |

The results show that although the PC executes faster, the FPGA-based system
achieves **comparable real-time performance** with **similar or better image
quality**, particularly in terms of PSNR.

---

## Comparison with Existing Work
The performance of the proposed approach was compared with an existing FPGA-based
edge detection implementation reported in the literature **[7]**.

| Metric | Proposed Work | Previous Work [7] |
|------|---------------|------------------|
| PSNR (dB) | 29.10 | 22.27 |
| SSIM | 0.79 | 0.74 |

The comparison shows that the proposed CLAHE–Canny based approach achieves
**higher PSNR and SSIM**, indicating improved image quality and better structural
preservation compared to the referenced work.

---

## Key Observations
- CLAHE significantly improves local contrast and feature visibility
- Canny edge detection produces clean and well-defined edges
- Software-only execution on FPGA PS is sufficient for real-time performance
- FPGA-based execution preserves image quality effectively
- The approach avoids the complexity of hardware accelerator design

---

## Documentation
📄 **Project Report:**  
Complete details including algorithm comparison, methodology, hardware setup,
code implementation, and performance analysis are available in the project report.

🔗 **Report Link:**  
[Real-Time Image Edge Detection on Zynq UltraScale+ MPSoC (PDF)](https://github.com/magantidatta/VLSI/blob/main/FPGA_Design/Image%20Processing/FPGA%20Project%20Report.pdf)

---

## Conclusion
This project demonstrates that **real-time image edge detection can be efficiently
implemented on embedded FPGA platforms using software optimization alone**.
By combining CLAHE-based contrast enhancement with Canny edge detection and
executing the pipeline on ARM Cortex-A53 cores, the system achieves real-time
performance with high-quality results.

The approach provides a **simpler, resource-efficient, and development-friendly**
solution for embedded vision applications such as surveillance, autonomous systems,
and medical imaging, while leaving scope for future hardware acceleration if needed.
