# Install libraries else skip
if (!require("glmtoolbox")) install.packages("glmtoolbox", repos = "http://cran.us.r-project.org")
if (!require("ggplot2")) install.packages("ggplot2", repos = "http://cran.us.r-project.org")
if (!require("dplyr")) install.packages("dplyr", repos = "http://cran.us.r-project.org")

library(glmtoolbox)
library(ggplot2)
library(dplyr)

# Import dataset
df <- read.csv("data/partB_predictions.csv")

# Refit model for Hosmer-Lemeshow test 
model <- glm(actual ~ predicted, data = df, family = "binomial")
hl_result <- hltest(model, g=10)
print(hl_result)
######################################################################
# Null hypothesis Ho = Model's Prediction fit observed data well
# P-value = 0.635 > 0.05 : Fail to Reject Ho
# Conclusion : The model is significant at level (alpha 0.05)
# with chi-stats(8) 6.105235 -> p-value of 0.635 > 0.05
######################################################################

# Bin predictions into 10 groups and calculate observed vs pred
calibration_data <- df %>%
    mutate(bin = ntile(predicted, 10)) %>%
    group_by(bin) %>%
    summarise (
        avg_pred = mean(predicted),
        obs_rate = mean(actual)
    )

# Create calibration Plot
cal_plot <- ggplot(calibration_data, aes(x = avg_pred, y = obs_rate)) +
    geom_point(size = 2, color ="black") +
    geom_line(color = "red", size= 1) +
    geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "gray") +
    labs(
        title = "Calibration Curve",
        x = "Average Predicted Probability",
        y = "Observed Default Rate"
    ) +
    theme(
        panel.background = element_rect(fill = "white"),        
        panel.grid.major = element_line(color = "black"),        
        panel.grid.minor = element_line(color = "black", linetype = "dotted"),
        plot.background = element_rect(fill = "white"),
        text = element_text(color = "black")
    )

ggsave("~/Downloads/calibration_curve.png", plot = cal_plot, width = 6, height = 4, dpi = 300)
######################################################################
# The calibration curve shows that the predicted probabilities align 
# with the actual default rates reasonably, especially in the higher
# score ranges (0.4 - 0.6). 
# Most low-score groups had zero observed default, suggesting model 
# not overestimating risks.
######################################################################


thresholds <- seq(0.01, 1, by = 0.01)
cutoff <- NA

for (t in thresholds) {
    group <- df %>% filter(predicted >= t)
    if (nrow(group) > 0) {
        rate <- mean(group$actual)
        if (rate <= 0.05) {
            cutoff <- t
            break
        }
    }
}

print(paste("Cut-off score with expected default <= 5%:", cutoff))
######################################################################
# The cut-off score is extremely low at 0.01 - it implies that the 
# model are very conservative. Recall through our dataset, the imbalance
# case are only 1.23% defaulters in total and most features are uniformly
# distributed. The model learned that most people don't default, so it 
# outputs low scores for nearly everyone.
######################################################################
