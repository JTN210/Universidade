library(dplyr)
library(tidyr)

head(mtcars)
cars <-mtcars |> 
  filter(mpg > 25, cyl %in% c(4, 6)) |>
  mutate(kmpl = mpg * 0.4251,potencia = case_when(
    hp < 100 ~ "baixa",
    hp >= 100 & hp < 150 ~ "média",
    hp >= 150 ~ "alta"
  ))|>
  arrange(desc(kmpl)) |>
  select(mpg, cyl, hp, kmpl, potencia) |>
  slice_head(n = 8)
cars

##Exercício 2

f <-head(nycflights13::flights)
f |>
  group_by(carrier) |>
  summarise(
    n_voos = n(),
    atraso_medio_partida = mean(dep_delay, na.rm = TRUE),
    atraso_medio_chegada = mean(arr_delay, na.rm = TRUE)
  ) |>
  arrange(desc(n_voos)) |>
  head(10)


f |>
  group_by(carrier) |>
  summarise(
    across(c(dep_delay, arrdelay),
           list(media = ~mean(.x, na.rm = TRUE),
                sd    = ~sd(.x,   na.rm = TRUE)),
           .names = "{.col}{.fn}")
  )

##Exercício 3
vendas <- tibble(
  id = 1:4,
  Jan = c(10, 12, 9, 11),
  Fev = c(11, 8, 13, 10),
  Mar = c(9, 12, 7, 15)
)

vl<- vendas |>
  pivot_longer(
    cols = c(Jan, Fev, Mar),
    names_to = "Mês",
    values_to = "Valor"
  )
vl
vl |>
  pivot_wider(
    names_from = Mês,     # coluna cujos valores serão os nomes das novas colunas
    values_from = Valor
  )

nomes <- tibble(nome_completo = c("Ana Silva","Bruno Costa","C. Rocha"))
juntos <- nomes |>
  separate(
    col = nome_completo,
    into = c("primeiro", "ultimo"),
    sep = " "  # separador é o espaço
  )
juntos
compacto <- juntos |>
  unite(
    col = "nomecompleto",  # nome da nova coluna
    primeiro, ultimo, 
    sep = "_"
  )
compacto

# FICHA 3

library(palmerpenguins)
library(tidyverse)
library(dplyr)

peng <- penguins |> drop_na(flipper_length_mm, bill_length_mm)

peng
ggplot(peng, aes(x = bill_length_mm, y = flipper_length_mm)) + geom_point()

modelo <- lm(flipper_length_mm ~ bill_length_mm, data = peng)

summary(modelo)

predict(modelo, newdata = data.frame(bill_length_mm = 45), interval = "prediction")

plot(modelo)




data(diamonds, package = "ggplot2")
ggplot(diamonds, aes(x = carat, y = price)) +
geom_point() + 
geom_smooth(method = "lm") +
  labs(
    title = "Relação entre preço e peso em quilates dos diamantes",
    x = "Peso (carat)",
    y = "Preço (USD)"
  )

modelo1 <- lm(price ~ carat, data = diamonds)

modelo1  



novo <- data.frame(carat = 1.0)
pred_log <- predict(modelo1, newdata = novo, interval = "prediction", level = 0.95)
pred_log


#EX3

library(gapminder)

gm <- gapminder |> filter(year == 2007)

modelo1 <- lm(lifeExp ~ gdpPercap, data = gm)
modelo1

ggplot(gm, aes(x = gdpPercap, y = lifeExp)) +
  geom_point() + 
  geom_smooth(method = "lm")


modelo2 <- lm(lifeExp ~ log(gdpPercap), data = gm)
modelo2

ggplot(gm, aes(x = log(gdpPercap), y = lifeExp)) +
  geom_point() + 
  geom_smooth(method = "lm")




# EX4

library(nycflights13)

fl <- flights |> drop_na(dep_delay, distance)

ggplot(fl, aes(x = distance, y = dep_delay)) + 
  geom_point() + 
  geom_smooth(method = "lm")


modelo1 <- lm(dep_delay ~ distance, data = fl)

summary(modelo1)

#EX5 

dm <- data(diamonds, package = "ggplot2")

dm_cut <- dm |> 
  filter(cut %in% c("Ideal", "Good"))
  
dm_cut



#FOLHA 6 
library(modeldata)
ames_num <- ames |> 
  select(where(is.numeric)) |> 
  mutate(Sale_Price = log10(Sale_Price))

split_ames <- initial_split(ames_num,0.8)
treino_ames <- training(split_ames)
teste_ames <- testing(split_ames)

modelo_ols <- lm(Sale_Price ~ ., data = treino_ames)

pred_ols <- predict(modelo_ols, newdata = teste_ames)

rmse(teste_ames$Sale_Price,pred_ols)
summary(modelo_ols)$r.squared

# Criar matrizes sem intercepto
X_tr <- model.matrix(Sale_Price ~ ., treino_ames)[, -1]
y_tr <- treino_ames$Sale_Price
X_te <- model.matrix(Sale_Price ~ ., teste_ames)[, -1]
y_te <- teste_ames$Sale_Price

ridge_cv <- cv.glmnet(
  x = X_tr, y = y_tr,
  alpha = 0,            # ridge!
  nfolds = 10
)

ridge_lambda <- ridge_cv$lambda.min
ridge_lambda

# Previsão no teste
pred_ridge <- predict(ridge_cv, newx = X_te, s = "lambda.min")
pred_ridge <- as.numeric(pred_ridge)

rmse_ridge <- rmse(y_te, pred_ridge)
rmse_ridge

summary(modelo_ols)$r.squared


