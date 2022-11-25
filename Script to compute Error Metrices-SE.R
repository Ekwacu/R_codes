#Script for computing ERROR METRICES of RMSE, MAE, MSE, RAE, RRSE and MAPE by Samuel Ekwacu

#RMSE=Root Mean Squared Error, MAE=Mean Absolute Error, MSE=Mean squared Error, RAE=Relative Absolute Error
#RRSE=Root Relative Squared Error, MAPE=Mean Absolute Percentage Error.
#An error metric is a way to quantify the performance of a model and provides a way for the forecaster 
#to quantitatively compare different models. They give us a way to more objectively gauge how well the model executes its tasks.
#NOTE always remember to document the formula and advantages of using each metric.
rm(list = ls())
setwd("F:/Folder_2022/Bryan_Muk")
SHT <- read.csv("SHTsensor_practice1.csv")
head(SHT, 2)
library(Metrics)
#########To compute RMSE############
#Root Mean Square Error In R, The root mean square error (RMSE) allows
#us to measure how far predicted values are from observed values in a regression analysis.
#In other words, how concentrated the data around the line of best fit.
#RMSE = ???[ ??(Pi - Oi)2 / n ]
#where:
#?? symbol indicates "sum"
#Pi is the predicted value for the ith observation in the dataset
#Oi is the observed value for the ith observation in the dataset
#n is the sample size

########Method 1: Function###########
#sqrt(mean((data$actual - data$predicted)^2))
sqrt(mean((SHT$tsht_1 - SHT$tsht_2)^2))

#########Method 2: Package############
#install.packages("Metrics")
#library(Metrics)
#rmse(data$actual, data$predicted)
rmse(SHT$sht_1, SHT$tsht_2)

#Notes and Conclusions
#Mean square error is a useful way to determine the extent 
#to which a regression model is capable of integrating a dataset.
#The larger the difference indicates a larger gap between the predicted and observed values,
#which means poor regression model fit. In the same way, 
#the smaller RMSE that indicates the better the model.
#Based on RMSE we can compare the two different models with each other 
#and be able to identify which model fits the data better.

########To compute % BIAS##########
#install.packages("hydroGOF")
library(hydroGOF)
#percent bias (Obs, Sim)
#obs: observed values and Sim: simulated values
# pbias(data source$simulated, data source$observed)
pbias(SHT$tsht_2, SHT$sht_1)
#bias(estimates, Observed)
bias(SHT$tsht_2, SHT$sht_1)
#RE (Relative bias in percent)
RE<-sum(SHT$tsht_2 - SHT$sht_1)/sum(SHT$sht_1)*100
print(RE)
#To compute the Gini Coefficient
#install.packages("Gini")
library(Gini)
#Commonly used for imbalanced datasets where the probability alone makes it difficult to predict an outcome.
#Gini is measured in values between 0 and 1, where a score of 1 means that the model is 100% accurate in predicting the outcome
#A score of 1 only exists in theory. In practice, the closer the Gini is to 1, the better.
#Whereas, a Gini score equal to 0 means the model is entirely inaccurate. 
gini(SHT$tsht_2, SHT$sht_1)

############To compute MAE###########
#Mean Absolute Error in R, when we do modeling always need to measure the accuracy of the model fit.
#The mean absolute error (MAE) allows us to measure the accuracy of a given model.
#The formula for mean absolute error is
#MAE = (1/n) * ??|yi - xi|
#where:
#?? symbol Indicate that "sum"
#Yi indicates that ith observed value.
#Xi indicates that ith predicted value
#N indicates the total number of observations
#mae(observed, predicted)
mae(SHT$sht_1, SHT$tsht_2)
#This MAE value indicates the average absolute difference 
#between the observed values and the predicted values.
#Conclusion
#Lower MAE value indicates a better model fit. 
#This can be more useful when comparing two different models.

#############To compute MSE##############
#mean((data$actual - data$pred)^2)
mean((SHT$sht_1 - SHT$tsht_2)^2)
#One of the most common metrics used to measure the prediction accuracy of a model is MSE, 
#which stands for mean squared error. It is calculated as:
# MSE = (1/n) * ??(actual - prediction)2
#where:
#?? - a fancy symbol that means "sum"
#n - sample size
#actual - the actual data value
#prediction - the predicted data value
#The lower the value for MSE, the more accurately a model is able to predict values.

################To compute RAE############
#The Relative Absolute Error checks if a model performs better than just predicting the average (i.e., the simple model).
#The formula of the Relative Absolute Error:
#Formula Relative Absolute Error
#where:
# n: represents the number of observations
#yi: represents the realized value
#yi: represents the predicted value
#??: represents the average of the realized values
#The interpretation of the Relative Absolute Error is simple: if the RAE is smaller than one, 
#then the model performs better than the simple model. In the case of a perfect model, the Relative Absolute Error is 0. 
#Typically, you want an RAE as close a possible to zero.
#rae(actual = y, predicted = y_hat)
#library(Metrics)
rae(SHT$sht_1, SHT$tsht_2)

############To compute RRSE###############
#The interpretation of the Root Relative Squared Error (RRSE) is simple. The Root Relative Squared Error indicates how well a model performs
#relative to the average of the true values. Therefore, when the RRSE is lower than one, the model performs better 
#than the simple model. Hence, the lower the RRSE, the better the model.
#rrse(actual, predicted)
rrse(SHT$sht_1, SHT$tsht_2)

#############To compute MAPE##############
#The Mean Absolute Percentage Error (MAPE) is one of the easiest methods and easy to infer and explain. Suppose MAPE value of a particular 
#model is 5% indicate that the average difference between the predicted value and the original value is 5%.
#low percentage implies better model in simulating the observations
#mean(abs((data$actual-data$forecast)/data$actual)) * 100
mean(abs((SHT$sht_1 - SHT$tsht_2)/SHT$sht_1))* 100
###### God provides