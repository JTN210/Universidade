library(titanic)
library(dplyr)
library(tidyr)
library(rsample)
dados_titanic <- titanic_train %>%
  select(Survived, Pclass, Sex, Age, Fare) %>%
  na.omit()

dados_titanic$Sex <- factor(dados_titanic$Sex, levels = c("male", "female"))

split <- initial_split(dados_titanic, 0.8)
treino_titanic <- training(split)
teste_titanic <- testing(split)

modelo_titanic <- glm(Survived ~ Pclass + Sex + Age + Fare,data = treino_titanic,
                      family = binomial)
summary(modelo_titanic)


prob_teste <- predict(modelo_titanic, newdata = teste_titanic, type = "response") 
prev_test <- ifelse(prob_teste >= 0.5,1 ,0)

tabela <- table(Real = teste_titanic$Survived, Previsto = prev_test)
tabela
TP <- tabela["1","1"]
TN <- tabela["0","0"]
FP <- tabela["0","1"]
FN <- tabela["1","0"]

accuracy  <- (TP + TN) / sum(tabela)
sens      <- TP / (TP + FN)  # TPR
espec     <- TN / (TN + FP)  # TNR

library(pROC)
roc_titanic <- roc(response = teste_titanic$Survived,
                   predictor = prob_teste
                   )
plot(roc_titanic, mains = "Curva ROC - Titanic (teste)")

auc(roc_titanic)

# Exercicio  2
library(ISLR2)
dados_default <- Default
dados_default
dados_default$Y <-ifelse(dados_default$default == "Yes",1,0)
table(dados_default$Y)

split <- initial_split(dados_default, 0.6)
dados_default_teste <- testing(split)
dados_default_treino <- training(split)
dados_default_teste
dados_default_treino

modelo_default <- glm( Y ~ balance + income + student,  family = binomial, data = dados_default_treino)

summary(modelo_default)

# positivo e altamente significativo
# à medida que o saldo no cartão de crédito aumenta, a probabilidade de incumprimento aumenta.
# negativo e significativo)
#estudantes têm menor risco de incumprimento

exp(coef(modelo_default))

prob_teste <-predict(modelo_default, newdata = dados_default_teste, type = "response")
prev_teste <- ifelse(prob_teste >= 0.5, 1, 0)

tabela_default <- table(Observado = dados_default_teste$Y, Previsto = prev_teste)
tabela_default

TP <- tabela_default["1","1"]
TN <- tabela_default["0","0"]
FN <- tabela_default["1","0"]
FP <- tabela_default["0","1"]

sensibilidade <- TP/ TP + FN  
especifidade <- TN / TN + FP
accuracy <- (TP + TN)/ sum(tabela_default) 


roc_obj <- roc(dados_default_teste$Y, prob_teste)
auc(roc_obj)
