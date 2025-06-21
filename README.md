#SQL Analysis
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
