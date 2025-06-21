Report for -- ANOMALY DETECTION ( decoy_noise ) -- ( Part A )
This analysis aims to flag anomalies based on top and bottom 2.5% for
percentiles of the decoy_noise distribution. Out of 10.000 records,
around 500 entries are identified as anomalies, supporting the 
assumption that the flagged data points are statistically outliers.

A Sample case of sample with order_id 110964, customer_id 394 has a
decoy noise of -4.33 which is flagged as below 2.5% percentile
anomaly. On the other hand, order_id 109909, customer_id 880 has a
decoy noise of 1153.43 which is flagged as more than 97.5% percentile
anomaly.

These cases demonstrate an effective detection of anomalies at 
both distribution of tails. Whether 500 anomaly rows are 
acceptable, it requires domain expert to validate the findings, 
reducing false positives and improve the precision. Moreover,
percentile boundaries could be increased to 99%, flagging only
the most extreme value.

