# Hands-on with Orange: Data Preprocessing and Model Training

**Herdiantri Sufriyana**
Graduate Institute of Artificial Intelligence and Big Data in Healthcare
National Taiwan University of Nursing and Health Sciences

---

## Table of Contents

1. [Subtopics](#subtopics)
2. [What is Orange?](#what-is-orange)
3. [Step 1: Load and Explore Data (Meeting 04)](#step-1-load-and-explore-data-meeting-04)
4. [Step 2: Split Data (Meeting 03)](#step-2-split-data-meeting-03)
5. [Step 3: Handle Outliers (Meeting 05)](#step-3-handle-outliers-meeting-05)
6. [Step 4: Handle Missing Values (Meeting 05)](#step-4-handle-missing-values-meeting-05)
7. [Step 5: Feature Selection (Meeting 06)](#step-5-feature-selection-meeting-06)
8. [Step 6: Train Models and Cross-Validate (Meeting 09)](#step-6-train-models-and-cross-validate-meeting-09)

---

## Subtopics

- Loading and exploring data
- Data partitioning (test set vs. development set)
- Handling outliers and missing values
- Feature selection using Chi-squared
- Training multiple ML algorithms and cross-validation

[Back to Table of Contents](#table-of-contents)

---

## What is Orange?

- A **visual programming** tool for data mining and machine learning
- Build workflows by connecting **widgets** (drag-and-drop blocks)
- Each widget performs one task (load data, train model, evaluate, etc.)
- Connections between widgets define the data flow

**Install:** https://orangedatamining.com/download/

[Back to Table of Contents](#table-of-contents)

---

## Step 1: Load and Explore Data (Meeting 04)

1. Drag **File** widget onto the canvas → load your dataset (.csv)
2. In the **File** widget:
   - Rename your outcome column to **outcome**
   - Set its role to **Target**
   - Set predictor columns to **Feature**
   - Set ID or irrelevant columns to **Meta**
   - Click **Apply**
3. Connect **File** → **Data Table** (label it "Raw data") → inspect rows, columns, values
4. Connect **Data Table** → **Column Statistics** (label it "Raw data summary") via **Selected Data → Data** connection

**Check these:**
- How many samples (rows) and features (columns)?
- Which column is the outcome?
- Are there missing values?
- What are the variable types (numeric, categorical)?

> **Recall Meeting 04:** Is every variable available at the intended time of prediction? Could any variable cause information leakage?

[Back to Table of Contents](#table-of-contents)

---

## Step 2: Split Data (Meeting 03)

**Widget:** Data Sampler (label it "Data partition")

1. Connect **File** → **Data Sampler** (label it "Data partition") — set 20%, check **Stratify**
2. Connect **Data Sample → Data** output → **Data Table** (label it "Test set") — set aside, do not touch until final evaluation
3. Connect **Remaining Data → Data** output → **Data Table** (label it "Development set")

| Partition | % of total | Use |
|-----------|-----------|-----|
| Test | 20% | Final evaluation only |
| Development | 80% | Preprocessing + cross-validation |

> **Recall Meeting 03:** Test set is set aside first and never touched. The development set is used for both preprocessing and model evaluation via cross-validation.

[Back to Table of Contents](#table-of-contents)

---

## Step 3: Handle Outliers (Meeting 05)

**Widget:** Outliers (label it "Outlier detection")

1. Connect **Development set** (Data Table) → **Outlier detection** (via **Selected Data → Data**)
2. Select **Covariance Estimator**, set **Contamination to 5%**, leave **Support fraction** unchecked
3. Connect **Inliers → Data** output → **Data Table** (label it "Inliers")

[Back to Table of Contents](#table-of-contents)

---

## Step 4: Handle Missing Values (Meeting 05)

**Widget:** Preprocess (label it "Single imputation model")

1. Connect **Inliers** (Data Table) → **Preprocess** via **Selected Data → Data**
2. In Preprocess, add: **Impute Missing Values → Average/Most frequent**

> **Recall Meeting 05:** In Meeting 05 we used MICE (model-based imputation). Orange's Preprocess only supports Average/Most frequent — a heuristic to fit Orange's available features.

[Back to Table of Contents](#table-of-contents)

---

## Step 5: Feature Selection (Meeting 06)

**Widget:** Same Preprocess widget from Step 4

1. Open the same **Preprocess** widget from Step 4
2. Add a second step: **Select Relevant Features → Chi-squared (χ²), Fixed, top 5**
3. Rename the widget to **"Single imputation & Chi-squared feature selection"**

> **Recall Meeting 06:** In Meeting 06 we used regression-based feature selection. Here we use Chi-squared (χ²) which tests the association between each predictor and the outcome. Selecting the top 5 reduces candidate predictors and increases EPV (Meeting 10).

[Back to Table of Contents](#table-of-contents)

---

## Step 6: Train Models and Cross-Validate (Meeting 09)

**Widgets:** Learner widgets + Test and Score

1. Drag these **learner widgets** onto the canvas and set hyperparameters:

   - **Ridge Regression** (Logistic Regression widget) — Regularization: Ridge (L2), C=0.010
   - **Tree** — Induce binary tree, Min. instances in leaves: 20, Limit max depth: 3
   - **Random Forest** — 30 trees, Limit depth: 3, Do not split subsets smaller than: 20
   - **Gradient Boosting** — scikit-learn, 30 trees, Learning rate: 0.330, Replicable training, Limit depth: 3, Do not split subsets smaller than: 20
   - **SVM** — SVM type, Cost C=1.00, RBF kernel, g=auto, Iteration limit: 100
   - **kNN** — 3 neighbors, Euclidean, Uniform weight
   - **Neural Network** — 100 neurons, ReLu, Adam, α=0.01, 200 iterations, Replicable training

2. Connect **Preprocess** (from Step 5) to each learner via two connections:
   - **Preprocessed Data → Data**
   - **Preprocessor → Preprocessor**

3. Connect **Development set** (Data Table) → **Test and Score** (label it "5-fold cross-validation") via **Selected Data → Data**

4. Connect each **learner → Test and Score** (Learner input)

5. In Test and Score, set to **Cross-validation, 5 folds**

6. View metrics: **AUC**, **CA**, **F1**, **Precision**, **Recall**

> **Recall Meeting 09:** Statistical ML (LR) needs EPV 10–50. Computational ML (RF, GBM, SVM, NN) needs EPV 100–200.

[Back to Table of Contents](#table-of-contents)
