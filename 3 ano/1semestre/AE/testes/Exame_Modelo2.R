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
library(Metrics)
library(rsample)
library(ggplot2)
library(dplyr)
gp <- gapminder::gapminder |> janitor::clean_names()
glimpse(gp)

ggplot(gp, aes(x = gdp_percap, y = life_exp)) +
  scale_x_log10() +
  geom_point(alpha = 0.3) + 
  facet_wrap(~ continent) +
  geom_smooth(method = "lm", se = FALSE)


modelo <- gp |> 
  group_by(continent) |> 
  filter(country %in% c("Angola", "Japan", "Portugal"))
modelo

ggplot(modelo, aes( x = year, y = life_exp, color = country)) + 
  geom_line() + 
  labs(title  = "Taxa de Life_Exp ao longo dos anos",
       x = "Anos",
       y = " Expectativa de Vida" )


modelo1 <- gp |> 
           group_by(continent) |>         
           filter(year == "2007")

 ggplot(modelo1, aes(x = continent, y = life_exp, color = continent,fill = continent)) + 
   geom_boxplot() + 
   labs(title = "Grafico de Boxplot", 
        x = "Continentes",
        y = "Expectativa de Vida")

 
 
 bb <- babynames::babynames |> janitor::clean_names()
 glimpse(bb)
 nomes <- bb |> 
          filter(name %in% c("Mary","Anna","Emma","John","Minnie", year >= "1900", year >= "2015"))
 
 ggplot(nomes,aes(x = year, y = prop, color = name)) +
   facet_wrap( ~ name) +
   geom_smooth()

 
sexo <- bb |> 
        group_by(name) |>
        filter(sex == "F") |>
        summarise(total = sum(n,na.rm = TRUE)) |>
        arrange(desc(total))
sexo            

nomes_comuns <- bb |>
                filter(name %in% c("Mary","Elizabeth","Patricia","Jennifer","Linda"))

nomes_comuns
ggplot(nomes_comuns, aes(x = year, y = n, color = name, fill = name)) + 
  geom_bar(stat = "Identity")




data("diamonds", package = "ggplot2")
dm <- diamonds |> janitor::clean_names() |> mutate(log_price = log(price))

split_dm = initial_split(dm, 0.8)
treino = training(split_dm)
teste = testing(split_dm)

modelo_treino <- lm(log(price) ~ carat+cut+color+clarity, data = treino)
predict_treino = predict(modelo_treino, treino)
rmse_treino = rmse(treino$log_price,predict_treino)
summary(modelo_treino)$r.squared
modelo_teste <- lm(log(price) ~ carat+cut+color+clarity, data = teste)
predict_teste = predict(modelo_teste, teste)
summary(modelo_teste)$r.squared
rsme_teste = rmse(teste$log_price,predict_teste)


modelo_base <- lm(log(price) ~ carat+cut+color+clarity, data = dm)
AIC(modelo_base)
summary(modelo_base)$adj.r.squared

modelo_cona <- lm(log(price) ~ carat * clarity+cut+color, data = dm)
AIC(modelo_cona)
summary(modelo_cona)







modelo_base <- lm(log(price) ~ carat+cut+color+clarity, data = dm)

split_modeloBase <- initial_split(dm, 0.8)

treino = training(split_modeloBase)
teste = testing(split_modeloBase)
X_treino = model.matrix(log_price ~ carat+cut+color+clarity,treino)[, -1]
X_teste  = model.matrix(log_price ~ carat+cut+color+clarity,teste)[, -1]
Y_treino = X_treino = treino$log_price ~ carat+cut+color+clarity
Y_teste  = X_teste = treino$log_price ~ carat+cut+color+clarity

modelo_base <- lm(log_price ~ carat + cut + color + clarity, data = treino)

pred_treino <- predict(modelo_base, newdata = treino)
pred_teste  <- predict(modelo_base, newdata = teste)

rmse_treino = rmse(modelo_base, pred_treino)
rmse_teste = rmse(modelo_base, pred_teste)

modelo_base <- lm(log_price ~ carat + cut + color + clarity, data = teste)
summary(modelo_base)$r.squared


modelo_base <- lm(log_price ~ carat + cut + color + clarity, data = dm)
summary(modelo_base)$adj.r.squared
AIC(modelo_base)

modelo_V <- lm(log_price ~ carat * clarity + cut + color , data = dm)
AIC(modelo_V)
summary(modelo_V)$r.squared

plot(modelo_base)
