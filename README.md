_============-
#SQL Analysis
-============-
This project contains SQL-based analytics and explanation for 
customer behaviour, including RFM segmentation, anomaly detection,
and monthly repeat purchase analysis

##Key Concepts
- Recency : calculated as number of days since last purchase
- Frequency : total number of orders per customer
- Monetary : total payment value per customer
- Anomalies : flagged data points if decoy_noise fall outside threshold

##Files :
- analysis.sql : Full SQL script with explanation for all 3 tasks
- A_findings.md : Brief insight summary for anomaly found (<=150 words)

##Run Walkthrough 
1. Connect to PostgreSQL database with the required schema 
(data/e_commerce_transactions)
2. Open analysis.sql using SQL editor
3. Run each section individually
Note that anomaly detection section and monthly repeat purchase
have toggle options provided for extra meaningful insights

-============================-
#Credit Default Risk Modeling
-============================-
This project addresses the challenge of **predicting credit default risk** 
for loan applicants, particularly for a loan value of **IDR 5 million**. 
It combines statistical and machine learning models with 
explainability tools to aid decision-making for financial institutions.

##Key Concepts
- Class Imbalances : Target variable heavily skewed
- Uniform Distributions : Most features are distributed uniformly

##Files
- B_modelling.ipynb: Data Pre-processing & EDA, Model Training, Tuning,
  SHAP Interpretation, and decision summary

##Models
- Logistic Regression
- XGBoost
- Ensemble Method

##Evaluation Metrics
- Confusion Matrix
- ROC AUC & Precision-recall AUC

##Tools Used
- Programming Language : Python
- Numpy, Pandas, Matplotlib, Seaborn, Pearson Correlation
- Scikit-learn, XGBoost for model building & validation
- SMOTE for imbalanced target variable
- Git for version control

##Run Walkthrough
- Clone Repository git clone https://github.com/Alfredo2212/ds-takehome.git
- Run cloud-based jupyter notebook (Google Colab) or local environment
- open B_modeling.ipynb