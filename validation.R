if (!require("glmtoolbox")) install.packages("glmtoolbox", repos = "http://cran.us.r-project.org")
library(glmtoolbox)
# Import dataset
df <- read.csv("data/partB_predictions.csv")

# Refit model for Hosmer-Lemeshow test 
model <- glm(actual ~ predicted, data = df, family = "binomial")
hl_result <- hltest(model, g=10)
print(hl_result)

# Null hypothesis Ho = Model's Prediction fit observed data well
# P-value = 0.635 > 0.05 : Fail to Reject Ho
# Conclusion : The model is significant at level (alpha 0.05)
# with chi-stats(8) 6.105235 -> p-value of 0.635 > 0.05


