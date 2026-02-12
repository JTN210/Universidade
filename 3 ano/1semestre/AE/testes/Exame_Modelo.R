req <- c("tidyverse","broom","gapminder","babynames","glmnet","ISLR2","GGally","scales","janitor")
new <- setdiff(req, rownames(installed.packages()))
if(length(new)) install.packages(new)

library(tidyverse)
library(broom)
library(gapminder)
library(babynames)
library(glmnet)
library(ISLR2)
library(GGally)
library(scales)
library(janitor)
library(dplyr)
library(ggplot2)
# EX1 a)
gp <- gapminder::gapminder |> janitor::clean_names()
glimpse(gp)

ggplot(gp, aes(x = gdp_percap, y = life_exp)) + 
  scale_x_log10() +
  geom_point(alpha = 0.3) + 
  facet_wrap(~ continent) +
  geom_smooth(method = "lm", se = FALSE)


#EX1 b

grafico <- gp |> 
  filter(country %in% c("Japan", "France", "Angola")) 

grafico
ggplot(grafico, aes(x = year, y = life_exp, color = country)) + 
  geom_line() + 
  labs(title = "Evolução da expectativa de vida ao longo do tempo",
       x = "Ano",
       y = "Expectativa de vida (anos)")


#Ex c) 

grafico2 <- gp |> 
  filter(year == 2007)

ggplot(grafico2, aes(x = continent, y = life_exp,color = continent, fill = continent)) + 
  geom_boxplot() + 
  labs(title = "Boxplot de Life_Exp dos Continentes",
       x = "Continentes",
       y = "Expetativa de vida")


#Ex 2 a) 

bb <- babynames::babynames |> janitor::clean_names()
glimpse(bb)

nomes <- bb |> 
  filter( name %in% c("Mary", "Anna", "Emma", "Minnie", "Margaret", "Ida"), year >= 1900, year <= 2015)

ggplot(nomes, aes(x = year, y = prop, color = name)) + 
  facet_wrap(~name) + 
  geom_smooth()

#Ex 2 b 

nomes_comuns <- bb |>
  group_by(name) |>
  filter(sex  == "M") |>
  summarise(
  total = sum(n, na.rm = TRUE)) |> 
  arrange(desc(total))
nomes_comuns

nomes_comuns2 <- bb |>
  filter(name %in% c("James", "John", "Robert", "Michael", "William"))
         nomes_comuns2
ggplot(nomes_comuns2, aes(x = year,y = n, color = name, fill =  name)) +
  geom_col()


#Parte B a
library(glmnet)
library(Metrics)
data("diamonds", package = "ggplot2")
dm <- diamonds |> janitor::clean_names() |> mutate(log_price = log(price))


modelo_base <- lm(log(price) ~ carat+cut+color+clarity, data = dm)
set.seed(123)
idx <- sample(seq_len(nrow(dm)), size = round(0.8 * nrow(dm)))
dm_treino <- dm[idx,]
dm_teste <- dm[-idx,]

predict_treino <- predict(modelo_base, newdata = dm_treino)
predict_teste <- predict(modelo_base, newdata = dm_teste)
rmse_treino = rmse(dm_treino$log_price,predict_treino)
rmse_teste = rmse(dm_teste$log_price,predict_teste)

modelo_base <- lm(log(price) ~ carat+cut+color+clarity, data = dm_treino)
r2_treino = summary(modelo_base)$r.squared
r2_treino

modelo_base <- lm(log(price) ~ carat+cut+color+clarity, data = dm_teste)
r2_teste = summary(modelo_base)$r.squared
r2_teste


#EX B b)

modelo_base <- lm(log(price) ~ carat+cut+color+clarity, data = dm)
summary(modelo_base)$adj.r.squared # R² ajustado
AIC(modelo_base)

modelo_V1<- lm(log(price) ~ carat * clarity+cut+color, data = dm)
summary(modelo_V1)$r.squared

# Se o AIC DIMINUI o novo modelo é preferível, pois equilibra bem ajuste e complexidade
# Se o R² AJUSTADO AUMENTA a interação acrescenta explicação real e não apenas overfitting



#EX B c)
plot(modelo_base)
# homostastecicida, media0 e independencia grafico Residuals vs Fitted
# Normalidade grafico Q-Q Residuals

#EX B d)





#EX C a)
library(rsample)

ht <- as_tibble(ISLR2::Hitters) |> janitor::clean_names() |> drop_na(salary) |>
  mutate(log_salary = log(salary))

split_ht <- initial_split(ht, 0.8)
 treino <- training(split_ht)
 teste <- testing(split_ht)
X<-model.matrix(log_salary~.,ht)
Y<-ht$log_salary
X_treino<-model.matrix(log_salary~.,treino)
Y_treino<-treino$log_salary
X_teste<-model.matrix(log_salary~.,teste)
Y_teste<-teste$log_salary
modelo_ridge_cv <- cv.glmnet(
  x = X_treino,
  y = Y_treino,
  alpha=0,
  nfolds = 10
)

pred_ridge <- predict(modelo_ridge_cv,X_teste)
rmse_ridge <- rmse(actual = Y_teste,predicted = pred_ridge)

modelo_ridge_cv$lambda.min
rmse_ridge

#EX C b) 

ht <- as_tibble(ISLR2::Hitters) |> janitor::clean_names() |> drop_na(salary) |>
  mutate(log_salary = log(salary))

split_ht <- initial_split(ht, 0.8)
treino <- training(split_ht)
teste <- testing(split_ht)
X<-model.matrix(log_salary~.,ht)
Y<-ht$log_salary
X_treino<-model.matrix(log_salary~.,treino)
Y_treino<-treino$log_salary
X_teste<-model.matrix(log_salary~.,teste)
Y_teste<-teste$log_salary
modelo_Lasso_cv <- cv.glmnet(
  x = X_treino,
  y = Y_treino,
  alpha=1,
  nfolds = 10
)

pred_Lasso <- predict(modelo_Lasso_cv,X_teste)
rmse_Lasso <- rmse(actual = Y_teste,predicted = pred_Lasso)

modelo_Lasso_cv$lambda.min
rmse_Lasso



  

