# A Lightweight Ensemble Framework for Gate-Level Hardware Trojan Detection

This repository contains the implementation of the work **accepted at IEEE IATMSI 2026**.

This project presents a **machine learning based framework for detecting hardware Trojans at the gate level in VLSI circuits**.  
The proposed method combines **hybrid feature selection and a lightweight ensemble learning approach** to accurately identify malicious modifications in integrated circuits while maintaining low computational overhead.

---

## Project Overview

Hardware Trojans are malicious modifications inserted into integrated circuits during design or manufacturing stages. These Trojans can cause:

- Data leakage
- System malfunction
- Security vulnerabilities
- Reliability issues in critical electronic systems

Detecting hardware Trojans at the **gate level during the pre-silicon design stage** is challenging due to the complexity of modern VLSI circuits.

This project proposes a **lightweight ensemble machine learning framework** that improves Trojan detection accuracy while maintaining computational efficiency.

---

## Problem Statement

Modern semiconductor supply chains involve multiple design and fabrication stages, increasing the risk of malicious hardware modifications.

Traditional detection techniques often rely on:

- Side-channel analysis  
- Functional testing  
- Formal verification  

However, these approaches may fail to detect **stealthy Trojans inserted at the gate level**.

Machine learning provides a scalable solution by learning patterns from circuit features and identifying abnormal behavior.

---

## Proposed Framework

The proposed system follows a **data-driven machine learning approach for hardware Trojan detection**.

```
Gate-Level Netlist
        │
        ▼
Feature Extraction
        │
        ▼
Feature Selection
        │
        ▼
Individual Classifier Evaluation
        │
        ▼
Soft-Weighted Ensemble Model
        │
        ▼
Hardware Trojan Detection
```

---

## Dataset

The framework was evaluated using publicly available benchmark datasets.

| Dataset | Description |
|-------|-------------|
| CAS-Lab | Benchmark dataset containing physical-level circuit features |
| HT-PRED | Dataset containing structural features extracted from Trust-Hub circuits |

### CAS-Lab Dataset

- 907 samples  
- 51 features  
- Physical attributes such as switching power, leakage power, and cell area.

### HT-PRED Dataset

- 479 samples  
- 605 structural features  
- Includes gate-level attributes such as fan-in, fan-out, and netlist topology.

These datasets include **both Trojan-free and Trojan-infected circuits**.

---

## Data Preprocessing

Before model training, several preprocessing steps were applied:

- Label encoding of Trojan and non-Trojan classes  
- Removal of non-numeric features  
- Mean imputation for missing values  
- Removal of low-variance features  
- Outlier handling using **IQR clipping**  
- Removal of highly correlated features  
- Feature normalization  
- Dataset split into training and testing sets  
- **SMOTE applied on training data** to address class imbalance

These preprocessing steps help improve classification performance and generalization.

---

## Hybrid Feature Selection

To identify the most informative circuit features, a **hybrid feature selection strategy** was implemented using three different methods:

### Methods Used

- **ANOVA F-Score**  
  Measures class separability between Trojan and non-Trojan samples.

- **Mutual Information (MI)**  
  Captures both linear and nonlinear dependencies between features and labels.

- **Random Forest Feature Importance**  
  Evaluates impurity reduction across decision tree splits.

### Feature Selection Strategy

Each feature is ranked independently by the three methods.  
A voting mechanism is applied where features receive votes based on their ranking positions.

Features with the highest combined votes are selected as the **final feature subset**.

This hybrid approach ensures:

- better feature relevance
- reduced dimensionality
- improved model performance

---

## Machine Learning Models Evaluated

Several classifiers were evaluated during experimentation:

- Support Vector Machine (SVM)
- K-Nearest Neighbors (KNN)
- Naïve Bayes
- Logistic Regression
- Random Forest
- XGBoost
- LightGBM
- Bagging
- CatBoost
- AdaBoost

After performance comparison across both datasets, the **best performing models** were selected for ensemble construction.

---

## Ensemble Strategy

The final ensemble model combines the following classifiers:

- **K-Nearest Neighbors (KNN)**
- **Random Forest**
- **LightGBM**

These models were selected because they demonstrated **high and stable performance across both datasets**.

The classifiers are combined using a **soft-weighted voting mechanism**.

In soft voting:

- each classifier outputs probability scores
- predictions are combined using weighted averaging
- classifiers with higher performance contribute more to the final prediction

This approach improves:

- classification robustness
- generalization ability
- detection accuracy

while keeping the model **computationally lightweight**.

---

## Results

The proposed ensemble framework achieved high detection accuracy on benchmark datasets.

| Dataset | Accuracy |
|-------|---------|
| CAS-Lab | **99.50%** |
| HT-PRED | **99.80%** |

Additional performance metrics include:

| Metric | CAS-Lab | HT-PRED |
|------|--------|--------|
| Precision | 99.54% | 99.75% |
| Recall | 99.43% | 99.76% |
| F1-Score | 99.48% | 99.76% |

The results demonstrate that the proposed method **outperforms several existing ML-based hardware Trojan detection techniques**.

---

## Key Contributions

- Developed a **lightweight ensemble machine learning framework** for hardware Trojan detection.
- Implemented **hybrid feature selection combining statistical and model-based techniques**.
- Evaluated multiple machine learning classifiers on benchmark datasets.
- Achieved **state-of-the-art detection accuracy** while maintaining low computational complexity.

---

## Applications

The proposed approach can be applied in:

- Secure VLSI design verification
- Hardware security analysis
- Semiconductor supply chain protection
- Detection of malicious circuit modifications

---

## Publication

**A Lightweight Ensemble Framework for Gate-Level Hardware Trojan Detection**

Accepted at:

**IEEE IATMSI 2026**  
International Conference on Advanced Technologies for Smart Infrastructure

---

## Technologies Used

- Python
- Scikit-learn
- LightGBM
- Random Forest
- K-Nearest Neighbors (KNN)
- Pandas
- NumPy
- Jupyter Notebook

---

## Author

**Maganti Shanmukha Sri Datta**

GitHub  
https://github.com/magantidatta

LinkedIn  
https://www.linkedin.com/in/maganti-shanmukha-sri-datta-72a408240/
