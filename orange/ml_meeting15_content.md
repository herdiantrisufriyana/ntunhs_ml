# Deployment and Post-Deployment for ML Prediction Models

**Herdiantri Sufriyana**
Graduate Institute of Artificial Intelligence and Big Data in Healthcare
National Taiwan University of Nursing and Health Sciences

---

## Subtopics

- Deployment planning and nomogram
- Post-deployment monitoring

---

## Session 1: Lecture — Deployment (10 mins)

---

## What is Deployment?

**Deployment** means integrating the prediction model into a real-world clinical workflow so that it can be used for actual patient care decisions.

**Key deployment questions:**

| Question | Example |
|----------|---------|
| **Who** uses the model? | Primary care physicians, nurses, screening programs |
| **When** is the prediction made? | At admission, during triage, at annual checkup |
| **How** is the prediction delivered? | Nomogram, EHR alert, mobile app, risk score card |
| **What action** follows the prediction? | Referral, additional testing, closer monitoring |

**Nomogram:**
- A visual tool that allows clinicians to compute a patient's predicted probability by hand, without software
- Traditional nomograms only work with logistic regression (linear coefficients map directly to points)
- **rmlnomogram** (Sufriyana & Su, MEDINFO 2025) extends nomograms to **any ML algorithm** by using all possible predictor combinations and optionally incorporating SHAP values for explainability

**rmlnomogram creates 5 types of nomograms:**

| Type | Predictors | Outcome | Probability | Max predictors |
|------|-----------|---------|-------------|----------------|
| 1 | Categorical only | Binary | No | 15 |
| 2 | Categorical only | Binary | Yes | 5 |
| 3 | Categorical only | Continuous | — | 5 |
| 4 | Categorical + 1 numerical | Binary | Yes | 5 |
| 5 | Categorical + 1 numerical | Continuous | — | 5 |

**How it works:**
1. Generate all possible combinations of predictor values (cross-product of all levels)
2. Predict the model output for each combination
3. Optionally compute SHAP values for each predictor per combination
4. The nomogram visualizes predictions and explainability across all combinations

**Web application:** [https://rmlnomogram.predme.app/](https://rmlnomogram.predme.app/) — upload CSV files and generate nomograms without coding

> Sufriyana H, Su EC. Development of Rmlnomogram: An R Package to Construct an Explainable Nomogram for Any Machine Learning Algorithms. Stud Health Technol Inform. 2025;329:500-504. doi:10.3233/SHTI250890

**Deployment considerations:**
- **Clinical workflow integration:** The model must fit into existing processes — if it requires extra data entry, it will not be used
- **Threshold communication:** Clinicians need to understand what the threshold means and what actions to take above/below it
- **Documentation:** Model card describing intended population, predictors, performance, and limitations

> **Can you guess:**
>
> - Why might a highly accurate model fail in deployment?
> - *(Hint: if the model requires predictors not routinely collected, or if clinicians do not trust or understand it, it will not be used)*

---

## Session 2: Hands-on — Nomogram Using rmlnomogram (10 mins)

**Task:** Create a nomogram using the rmlnomogram web app with example files.

**Steps:**
1. Go to [https://rmlnomogram.predme.app/](https://rmlnomogram.predme.app/)
2. Download the example files from the web app:
   - **Sample features** — all possible combinations of predictor values
   - **Feature categories** — two-column CSV listing features and their categories (prevents categorical predictors from being misidentified as numerical)
   - **Sample output** — single-column CSV with model predictions (header: "output")
   - **Feature explainability** (optional) — SHAP values per predictor
3. Open the example CSVs to understand the required format for each file
4. Upload the example files:
   - Browse and upload **Sample features**
   - Browse and upload **Feature categories**
   - Browse and upload **Sample output**
   - Select **Outcome type**: "Binary or class-wise multinomial"
   - Optionally upload **Feature explainability**
5. View the generated nomogram — note how each predictor value maps to the prediction and how SHAP values show explainability
6. Discuss: how would a clinician use this nomogram at the bedside without software?

**Orange environment** — No Orange widgets needed; nomogram created via rmlnomogram web app

---

## Session 3: Lecture — Post-Deployment Monitoring (10 mins)

---

## What is Post-Deployment Monitoring?

After deployment, model performance can **degrade over time** — this is called **model drift**.

**Types of drift:**

| Type | What changes | Example |
|------|-------------|---------|
| **Data drift** | Distribution of input features changes | New patient demographics, different lab equipment |
| **Concept drift** | Relationship between features and outcome changes | New treatment guidelines change who becomes inpatient |
| **Label drift** | Distribution of outcomes changes | Disease prevalence increases or decreases |

**Post-deployment monitoring plan:**

1. **Performance tracking:** Periodically re-evaluate calibration, discrimination, and clinical utility on new data
2. **Trigger criteria:** Define when to recalibrate or retrain — e.g., calibration slope deviates from 1 by more than 0.2, or AUC drops by more than 0.05
3. **Recalibration:** Update the model intercept (and optionally slope) using new data, without full retraining
4. **Retraining:** Rebuild the model from scratch when recalibration is insufficient
5. **Adverse event reporting:** Document and investigate cases where the model's prediction led to clinical harm

> **Can you guess:**
>
> - If a hospital changes its lab equipment, which type of drift would occur?
> - Why is recalibration preferred over retraining as a first step?
> - *(Hint: recalibration preserves the original model structure and requires less data; retraining requires repeating the entire development process)*

---

## Session 4: Hands-on — Deployment and Post-Deployment Planning (5 mins)

**Task:** Draft a deployment and post-deployment plan for your capstone project.

**Steps:**
1. Answer the deployment questions for your best model:
   - **Who** will use this model? (target clinical users)
   - **When** will the prediction be made? (time point in clinical workflow)
   - **How** will the prediction be delivered? (nomogram from rmlnomogram, EHR alert, risk card)
   - **What action** follows a positive/negative prediction?
2. Draft a post-deployment monitoring plan:
   - How often will performance be re-evaluated?
   - What metrics will be tracked? (calibration slope, AUC, sensitivity at cost-aware threshold)
   - What are the trigger criteria for recalibration or retraining?
3. Update your capstone study plan with the deployment and post-deployment sections

**Connect to your capstone study plan:**
This completes the "deployment and post-deployment" section. Students should update the study plan with their deployment and monitoring plan.

**Orange environment** — No Orange widgets needed; this is a planning exercise

---

## Take-home Message

1. **Deployment** requires answering who, when, how, and what action — use rmlnomogram to create a nomogram for any ML algorithm, enabling clinicians to use the model without software
2. **Post-deployment monitoring** detects model drift — define trigger criteria for recalibration or retraining, and report adverse events
