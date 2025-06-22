# R Statistical Validation Report
The cut-off score is extremely low at 0.01 - it implies that the 
model are very conservative. Recall through our dataset, the imbalance
case are only 1.23% defaulters in total and most features are uniformly
distributed. The model learned that most people don't default, so it 
outputs low scores for nearly everyone.

# Future Improvement 
To improve performance, feature engineering, applying sampling procedure 
for class imbalances and evaluate advanced models with stronger class-separation
such as neural networks might improve model prediction ability. These methods may 
enhance the model’s predictive power, especially when supported by a sufficient 
sample size.