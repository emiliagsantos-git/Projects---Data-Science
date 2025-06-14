# Load necessary libraries
library(ggplot2)
library(dplyr)
library(readr)
PanelData <- read.csv("C:/Users/emili/Downloads/PanelData.csv") 
PanelData

# Basic summary of the dataset
summary(PanelData)
View(PanelData)



# Correlation between variables
cor<- cor(PanelData[, c("C", "PF", "LF", "Q")])
cor

# Compute the correlation matrix
library(reshape2)
cor_matrix <- cor(PanelData[, c("C", "PF", "LF", "Q")])

# Melt the correlation matrix
melted_cor_matrix <- melt(cor_matrix)



# Heatmap
ggplot(melted_cor_matrix, aes(Var1, Var2, fill = value)) +
  geom_tile() +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", midpoint = 0) +
  theme_minimal() +
  labs(title = "Correlation Matrix Heatmap", x = "", y = "")


# Boxplot of Total Cost for Each Airline
ggplot(PanelData, aes(x = factor(I), y = C, fill = factor(I))) +
  geom_boxplot() +
  labs(title = "Boxplot of Total Cost for Each Airline", x = "Airline", y = "Total Cost")


# Reshape the data to a long format for faceting
library(tidyr)
long_data <- PanelData %>% 
  gather(key = "Factor", value = "Value", PF, LF, Q)

# Create the plot
ggplot(long_data, aes(x = T, y = Value, color = factor(I))) + 
  geom_line() +
  facet_wrap(~ Factor, scales = "free_y") +
  labs(title = "Contribution of Each Factor to Airline Costs Over the Years",
       x = "Year", y = "Value") +
  theme_minimal()


# Load necessary libraries
library(tidyr)
library(scales)

data<- PanelData

# Normalize the factors for better visualization
data$PF_norm <- data$PF / max(data$PF)
data$LF_norm <- data$LF / max(data$LF)
data$Q_norm <- data$Q / max(data$Q)

# Reshape data for plotting
data_long <- data %>%
  gather(key = "Factor", value = "Value", PF_norm, LF_norm, Q_norm) %>%
  mutate(Factor = factor(Factor, levels = c("PF_norm", "LF_norm", "Q_norm"),
                         labels = c("Fuel Price", "Load Factor", "Output")))

# Define color palette
color_palette <- c("Fuel Price" = "blue", "Load Factor" = "green", "Output" = "red")

# Plot for each airline with enhanced aesthetics
p <- ggplot(data_long, aes(x = T, y = Value, group = Factor, color = Factor)) +
  geom_line(size = 1.2) +
  facet_wrap(~ I, scales = "free_y", ncol = 3) +
  scale_color_manual(values = color_palette) +
  labs(title = "Factor Contribution to Costs Across Years by Airline",
       x = "Year",
       y = "Normalized Factor Value",
       color = "Factor") +
  theme_minimal() +
  theme(text = element_text(size = 12),
        plot.title = element_text(hjust = 0.5),
        legend.position = "bottom")

print(p)


# Histogram for Total Cost (C)
ggplot(PanelData, aes(x=C)) + 
  geom_histogram(bins=30, fill="blue", color="black") +
  theme_minimal() +
  labs(title="Histogram of Total Cost (C)", x="Total Cost", y="Frequency")

# Histogram for Output (Q)
ggplot(PanelData, aes(x=Q)) + 
  geom_histogram(bins=30, fill="green", color="black") +
  theme_minimal() +
  labs(title="Histogram of Output (Q)", x="Output", y="Frequency")

# Histogram for Fuel Price (PF)
ggplot(PanelData, aes(x=PF)) + 
  geom_histogram(bins=30, fill="red", color="black") +
  theme_minimal() +
  labs(title="Histogram of Fuel Price (PF)", x="Fuel Price", y="Frequency")

# Histogram for Load Factor (LF)
ggplot(PanelData, aes(x=LF)) + 
  geom_histogram(bins=30, fill="orange", color="black") +
  theme_minimal() +
  labs(title="Histogram of Load Factor (LF)", x="Load Factor", y="Frequency")



ggplot(PanelData, aes(x = T, y = C, group = I, color = as.factor(I))) +
  geom_line() +
  labs(title = "Trend of Costs Over Years for Each Airline",
       x = "Year",
       y = "Total Cost",
       color = "Airline") +
  theme_minimal()

ggplot(PanelData, aes(x = PF, y = C)) +
  geom_point(aes(color = as.factor(I))) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Relation Between Fuel Price and Costs",
       x = "Fuel Price",
       y = "Total Cost",
       color = "Airline") +
  theme_minimal()

ggplot(PanelData, aes(x = LF, y = C)) +
  geom_point(aes(color = as.factor(I))) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Load Factor and Costs",
       x = "Load Factor",
       y = "Total Cost",
       color = "Airline") +
  theme_minimal()

ggplot(PanelData, aes(x = Q, y = C)) +
  geom_point(aes(color = as.factor(I))) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Output (Revenue Passenger Miles) and Costs",
       x = "Output (Revenue Passenger Miles)",
       y = "Total Cost",
       color = "Airline") +
  theme_minimal()



# Create a plot for each airline
for (airline in unique(PanelData$I)) {
  airline_data <- subset(PanelData, I == airline)
  
  ggplot(airline_data, aes(x = T)) +
    geom_line(aes(y = C, color = "Total Cost")) +
    geom_line(aes(y = PF, color = "Fuel Price")) +
    geom_line(aes(y = LF * max(C), color = "Load Factor")) +  # Scaling LF for visibility
    geom_line(aes(y = Q, color = "Output")) +
    labs(title = paste("Cost Factors for Airline", airline),
         x = "Year",
         y = "Value",
         color = "Factor") +
    scale_color_manual(values = c("Total Cost" = "black", 
                                  "Fuel Price" = "blue", 
                                  "Load Factor" = "green", 
                                  "Output" = "red")) +
    theme_minimal() +
    theme(legend.position = "bottom")
  
  # Print each plot
  print(ggplot(airline_data))
}



# MODELS
library(plm)
library(lmtest)

#1) Pooled OLS
p_ols <- plm(C ~ Q+PF+LF, data= PanelData, model = "pooling")
summary(p_ols)

#2) Robust Pooled OLS 
coeftest(p_ols,vcov=vcovHC(p_ols, type="HC0", cluster="group"))

#3) Random Effects
random_effects <- plm(C ~ Q+PF+LF,  model = 'random', index = c('I', 'T'), data = PanelData)
summary(random_effects)

#4) Fixed Effects
fixed_effects <- plm(C ~ Q+PF+LF,  model = 'within', index = c('I', 'T'), data = PanelData)
summary(fixed_effects)

#5) Robust Fixed Effects 
# Re-estimating the Fixed Effects model with robust standard errors
fixed_effects_robust <- coeftest(fixed_effects, vcov = vcovHC(fixed_effects, type = "HC3"))
print(fixed_effects_robust)



#Tests
#1) Hausman Test
hausman_test <- phtest(fixed_effects, random_effects)
summary(hausman_test)
hausman_test

#2) Robust Hausman test:
library(sandwich)
hausman_test_robust <- phtest(fixed_effects, random_effects, vcov = function(x) vcovHC(x, method="white2", type="HC3"))
hausman_test_robust

#3) Ftest
#See which is the better fitted model: OLS or Fixed effects
pFtest(fixed_effects, p_ols)


# Go with fixed effects
# Summary of the Fixed Effects Model
summary(fixed_effects)


#4) Wooldridge test for autocorrelation
#serial correlation
wooldridge_test <- pdwtest(fixed_effects)
print(wooldridge_test)

#5) Breusch-Pagan test for Heteroskedasticity
bp_test <- bptest(fixed_effects, studentize = FALSE)
print(bp_test)

#6) Pesaran CD test for checking cross-sectional dependence:
pesaran_test <- pcdtest(fixed_effects, test = "cd")
print(pesaran_test)