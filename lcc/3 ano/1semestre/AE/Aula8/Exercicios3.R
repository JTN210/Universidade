library(titanic)
library(dplyr)
library(tidyr)
library(rsample)

dados_titanic <- titanic_train %>%
  select(Survived, Pclass, Sex, Age, Fare) %>%
  na.omit()

dados_titanic$Sex <- factor(dados_titanic$Sex, levels = c("male", "female"))

split<- initial_split(dados_titanic, 0.8)
dados_titanic_treino = training(split)
dados_titanic_teste = testing(split)
#dados de treino para ajustar
#dados de teste para avaliar
modelo_titanic <- glm(Survived ~ Pclass + Sex + Age + Fare, data = dados_titanic_treino, family = binomial)
summary(modelo_titanic)

prob_teste <- predict(modelo_titanic, newdata = dados_titanic_teste, type = "response")
prev_teste <- ifelse(prob_teste>= 0.5, 1, 0)
matriz_conf <- table(Real = dados_titanic_teste$Survived, Previsto = prev_teste)
matriz_conf

TP <- matriz_conf[1,1]
TN <- matriz_conf[0,0]
FN <- matriz_conf[1,0]
FP <- matriz_conf[0,1]
accuracy <- TP + TN /sum(matriz_conf)
sensibilidade <- TP / TP + FN
especifidade <- TN / TN + FP

library(pROC)
curva <- roc(response = dados_titanic_teste$Survived,
             predictor = prob_teste)
plot(curva)
auc(curva)

# Exercicio 2 
library(ISLR2)

dados_default <- Default
dados_default$Y<- ifelse(dados_default$default == "Yes", 1,0)
table(dados_default$Y)

split <- initial_split(dados_default,0.6)
dados_default_teste <- testing(split)
dados_default_treino <- training(split)
prop_treino <- mean(dados_default_treino$Y)
prop_teste  <- mean(dados_default_teste$Y)
prop_treino
prop_teste

modelo_default <- glm(Y ~ balance + income + student, data = dados_default_treino, family = binomial)
summary(modelo_default)
# positivo e altamente significativo
# à medida que o saldo no cartão de crédito aumenta, a probabilidade de incumprimento aumenta.
# negativo e significativo)
#estudantes têm menor risco de incumprimento
exp(coef(modelo_default))


prob_teste <- predict(modelo_default, newdata = dados_default_teste, type = "response")
prev_teste <- ifelse(prob_teste >= 0.5, 1, 0)
matriz_conf <- table(Real = dados_default_teste$Y, Previsto = prev_teste)
matriz_conf

TP <- matriz_conf[1,1]
TN <- matriz_conf[0,0]
FN <- matriz_conf[1,0]
FP <- matriz_conf[0,1]
accuracy <- TP + TN /sum(matriz_conf)
sensibilidade <- TP / TP + FN
especifidade <- TN / TN + FP

curva_roc <- roc(dados_default_teste$Y, prob_teste)
auc(curva_roc)
