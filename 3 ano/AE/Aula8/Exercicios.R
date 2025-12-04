library(titanic)
library(dplyr)
 #Exercicio 1 
dados_titanic <- titanic_train %>%
  select(Survived, Pclass, Sex, Age, Fare) %>%
  na.omit()

dados_titanic$Sex <- factor(dados_titanic$Sex, levels = c("male", "female"))

set.seed(123)

n <- nrow(dados_titanic)

idx_treino <- sample(1:n,size = 0.8 * n)

dados_treino <- dados_titanic[idx_treino,]
dados_teste <- dados_titanic[-idx_treino,]

nrow(dados_treino)
nrow(dados_teste)

#2 

modelo_logit <- glm(
  Survived ~ Pclass + Sex + Age + Fare,
  data   = dados_treino,
  family = binomial(link = "logit")
)

summary(modelo_logit)
# O coeficiente associado a Pclass é negativo e altamente significativo, indicando que passageiros em classes inferiores apresentam probabilidades de sobrevivência substancialmente menores.
# O coeficiente de Sexfemale é positivo e extremamente significativo, revelando que mulheres têm uma probabilidade muito maior de sobreviver do que homens (odds ≈ 11 vezes superiores).
# A idade apresenta um pequeno efeito negativo, mas significativo, indicando que passageiros mais velhos tendem a ter menor probabilidade de sobreviver.
# A tarifa (Fare) não é estatisticamente significativa após ajustar pelos restantes preditores.


# 3 

# prever probabilidades P(Survived = 1) no conjunto de teste
prob_teste <- predict(modelo_logit, newdata = dados_teste, type = "response")

pred_class <- ifelse(prob_teste >= 0.5, 1, 0)

actual <- dados_teste$Survived

mat_conf <- table(
  Predito = pred_class,
  Real    = actual
)

mat_conf  
# TN FN 
# FP TP 

TP <- mat_conf["1", "1"]
TN <- mat_conf["0", "0"]
FP <- mat_conf["1", "0"]
FN <- mat_conf["0", "1"]

accuracy <- (TP + TN) / (TP + TN + FP + FN)
accuracy
TPR_sensibilidade <- TP / (TP + FN)
TPR_sensibilidade

TNR_especificidade <- TN / (TN + FP)
TNR_especificidade
#O modelo apresenta uma accuracy elevada (82.5%).
#A sensibilidade é 73.4%, indicando que o modelo tem uma boa capacidade de identificar sobreviventes, embora existam alguns falsos negativos.
#A especificidade é ainda superior (89.8%), mostrando que o modelo distingue muito bem os passageiros que não sobreviveram. 
#Em geral, o desempenho é equilibrado, ainda que ligeiramente melhor a identificar não-sobreviventes do que sobreviventes.


#4

library(pROC)

roc_obj <- roc(actual, prob_teste)

auc(roc_obj)
plot(roc_obj, col = "blue", lwd = 2, main = "Curva ROC — Modelo Titanic")
#A AUC representa a probabilidade de que o modelo atribua uma probabilidade de sobrevivência mais elevada a um passageiro que realmente sobreviveu do que a um passageiro que não sobreviveu.
#Uma AUC de 0.8833 indica que isso ocorre em cerca de 88% das comparações, mostrando excelente capacidade discriminatória.


#Exercicio 2 

library(ISLR2)
dados_default <- Default
dados_default$Y <- ifelse(dados_default$default == "Yes", 1, 0)
table(dados_default$default, dados_default$Y)
#A regressão logística é adequada porque a variável resposta (default) é binária e a logística modela diretamente a probabilidade P(Y=1), garantindo valores entre 0 e 1.
#A regressão linear não seria apropriada porque pode produzir previsões fora do intervalo [0,1], não modela a relação não-linear entre os preditores e a probabilidade e viola as suposições do modelo linear (normalidade e homoscedasticidade dos erros).

# 2
set.seed(123)

n <- nrow(dados_default)

idx_treino <- sample(1:n,size = 0.6 * n)

dados_treino <- dados_default[idx_treino,]
dados_teste <- dados_default[-idx_treino,]

prop_treino <- mean(dados_treino$Y)
prop_teste  <- mean(dados_teste$Y)

prop_treino
prop_teste
#No conjunto de treino, cerca de 3.32% dos clientes entraram em incumprimento, enquanto no conjunto de teste a proporção é de 3.35%.
#As proporções são praticamente idênticas às da amostra original (≈ 3.3%), o que indica que a divisão aleatória preservou bem a estrutura da variável resposta.
#Assim, os conjuntos de treino e teste são representativos no que diz respeito ao comportamento de default, evitando enviesamento.

# 3
modelo_logit <- glm(
  Y ~ balance + income + student,
  data   = dados_treino,
  family = binomial(link = "logit")
)

summary(modelo_logit)
#O coeficiente do saldo é positivo, indicando que clientes com saldos mais elevados têm maior probabilidade de incumprir.
#O coeficiente associado a ser estudante é negativo, sugerindo que estudantes têm menor probabilidade de incumprimento do que não-estudantes.
#Se exp(β) > 1 → Aumenta o risco
#Se exp(β) < 1 → Diminui o risco
exp(0.005783)
exp(-0.5641)
#O odds ratio exp(β₁) = 1.0058 indica que cada dólar adicional de saldo aumenta as odds de incumprimento em cerca de 0.58%.
#Já o odds ratio exp(β₃) = 0.568 mostra que as odds de incumprimento dos estudantes são cerca de 43% menores do que as dos não-estudantes.


# 4 
prob_teste <- predict(modelo_logit, newdata = dados_teste, type = "response")

pred_class <- ifelse(prob_teste >= 0.5, 1, 0)

actual <- dados_teste$Y

mat_conf <- table(
  Predito = pred_class,
  Real    = actual
)

mat_conf
TP <- mat_conf["1", "1"]
TN <- mat_conf["0", "0"]
FP <- mat_conf["1", "0"]
FN <- mat_conf["0", "1"]

accuracy <- (TP + TN) / (TP + TN + FP + FN)
accuracy
sensibilidade <- TP / (TP + FN)
sensibilidade
especificidade <- TN / (TN + FP)
especificidade

#Apesar da accuracy muito elevada (97.35%), a sensibilidade é bastante baixa (30.6%). Isto significa que o modelo falha a maioria dos incumpridores, classificando-os como clientes seguros.
#Este tipo de erro (falso negativo) é financeiramente crítico para o banco, pois significa conceder crédito a clientes que têm forte probabilidade de não pagar.
#Assim, embora o modelo seja muito bom a identificar bons pagadores (especificidade de 99.66%), ele é fraco a detetar risco real de default, tornando o threshold de 0.5 inadequado para este problema.

# 5

roc_obj <- roc(actual, prob_teste)
auc(roc_obj)

plot(roc_obj, col = "blue", lwd = 2, main = "Curva ROC — Modelo Default")
youden <- coords(roc_obj, x = "best", best.method = "youden")
youden

t_opt <- as.numeric(youden["threshold"])

pred_opt <- ifelse(prob_teste >= t_opt, 1, 0)

mat_opt <- table(Predito = pred_opt, Real = actual)
mat_opt
TP_opt <- mat_opt["1","1"]
TN_opt <- mat_opt["0","0"]
FP_opt <- mat_opt["1","0"]
FN_opt <- mat_opt["0","1"]

acc_opt <- (TP_opt + TN_opt) / sum(mat_opt)
acc_opt
sens_opt <- TP_opt / (TP_opt + FN_opt)
sens_opt
spec_opt <- TN_opt / (TN_opt + FP_opt)
spec_opt


#O threshold de 0.5 é inadequado para problemas de risco de crédito.
#O threshold ótimo (0.032) maximiza Youden, aumenta drasticamente a sensibilidade e reduz falsos negativos, tornando o modelo mais útil na prática.

