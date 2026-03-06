# AI-Powered Predictive Maintenance for Aircraft Engines

This project implements a machine learning framework to predict the **Remaining Useful Life (RUL)** of aircraft engines using sensor data.  
The goal is to detect potential failures early and enable **predictive maintenance**, reducing downtime, operational cost, and safety risks.

The project was developed as part of the **Intel AI Hackathon**, where the focus was to demonstrate how **Intel AI optimized libraries** improve machine learning performance compared to standard implementations.

---

# Project Overview

Predictive maintenance uses machine learning techniques to analyze sensor data and estimate the remaining operational life of mechanical systems.

In this project:

- Aircraft engine sensor data is analyzed
- Machine learning models predict **Remaining Useful Life (RUL)**
- Intel AI optimized libraries are used to improve training performance
- Parallel processing is applied for faster computation

The final model achieves **~98.6% binary failure prediction accuracy** while reducing training time using optimized libraries.

---

# Problem Statement

Unexpected failures in aircraft engines can lead to:

- Safety risks
- Increased downtime
- High maintenance costs
- Operational inefficiencies

Predicting **Remaining Useful Life (RUL)** helps schedule maintenance before failure occurs.

---

# Dataset

The dataset used contains **aircraft engine sensor readings** collected over multiple operational cycles.

### Dataset Features

| Feature | Description |
|-------|-------------|
| `id` | Engine identifier |
| `cycle` | Operational cycle of the engine |
| `setting1` | Operational setting |
| `setting2` | Operational setting |
| `setting3` | Operational setting |
| `s1 – s21` | Sensor measurements from engine components |

These sensor readings capture engine health indicators such as temperature, pressure, and vibration.

---

# Project Workflow
```
Sensor Data Collection
│
▼
Data Preprocessing
│
▼
Feature Scaling
│
▼
Model Training (XGBoost)
│
▼
Performance Optimization
│
▼
Failure Prediction

```

---

# Data Preprocessing

Several preprocessing steps were applied before model training:

- Cleaning and formatting dataset
- Handling missing values
- Feature scaling using **StandardScaler**
- Train–test split for model validation
- Parallel data processing using **Modin + Ray**

These steps help improve model performance and training efficiency.

---

# Machine Learning Model

The project uses **XGBoost Regressor** to estimate Remaining Useful Life.

### Model Parameters

- `n_estimators = 200`
- `max_depth = 8`
- `learning_rate = 0.05`
- `subsample = 0.8`
- `tree_method = hist`

XGBoost was selected because it:

- handles tabular sensor data effectively
- provides high predictive performance
- supports optimized training

---

# Performance Optimization

To improve training efficiency, the project integrates **Intel AI optimized libraries**.

Optimizations used:

- Intel Scikit-learn Extension
- Modin for parallel Pandas operations
- Ray for distributed computation
- Histogram-based XGBoost training

These optimizations significantly reduce training time.

---

# Model Evaluation

The regression model predicting RUL was converted into a **binary classification problem**.

### Failure Prediction Rule

```
If Remaining Useful Life ≤ 30 cycles → Failure Risk
If Remaining Useful Life > 30 cycles → Normal Operation

```


### Evaluation Metrics

- Confusion Matrix
- Binary Classification Accuracy
- Feature Importance Analysis (SHAP)

---

# Results

| Implementation | Accuracy | Training Time |
|---------------|---------|---------------|
| Standard ML Libraries | ~95% | 3.30 seconds |
| Intel Optimized Libraries | **98.6%** | **2.65 seconds** |
| Without Optimization | ~99% | 5.31 seconds |

The optimized implementation achieved **significantly faster training time while maintaining high prediction accuracy**.

---

# Model Interpretability

To understand model decisions, **SHAP (SHapley Additive Explanations)** was used.

SHAP helps identify:

- which sensors influence predictions
- important features affecting engine health
- explainable AI insights for predictive maintenance

---

# Technologies Used

- Python
- XGBoost
- Intel Scikit-learn Extension
- Modin
- Ray
- NumPy
- Pandas
- SHAP
- Matplotlib
- Seaborn
- Google Colab
- Jupyter Notebook

---

# Key Learning Outcomes

- Predictive maintenance using machine learning
- Remaining Useful Life (RUL) estimation
- Sensor data analysis for industrial systems
- Model optimization using Intel AI libraries
- Parallel data processing
- Explainable AI using SHAP

---

# Author

**Maganti Shanmukha Sri Datta**

GitHub  
https://github.com/magantidatta

LinkedIn  
https://www.linkedin.com/in/maganti-shanmukha-sri-datta-72a408240/
