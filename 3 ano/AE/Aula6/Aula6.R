library(modeldata)
library(tidyverse)
library(caret)

# EX1
 # ex1 1 
head(ames)
View(ames)
dim(ames)
str(ames)

num_vars <- names(ames)[sapply(ames, is.numeric)]
num_vars <- setdiff(num_vars,"Sale_Price")

data <- ames[, c("Sale_Price", num_vars)]
data <- data %>% mutate(across(where(is.integer), as.numeric))
data <- data %>% mutate(Sale_Price = log10(Sale_Price))
str(data)

 # ex1 2
set.seed(123)
train_index <- sample.int(nrow(data), floor(0.8* nrow(data)))
train <- data[train_index, ]
test  <- data[-train_index, ]
str(data)

Xtr <- as.matrix(train[,num_vars])
ytr <- train$Sale_Price
Xte <- as.matrix(test[, num_vars])
yte <- test$Sale_Price

 #ex1 3 
fit_ols <- lm(Sale_Price ~., data = train)
pred_ols <- predict(fit_ols, newdata = test)
