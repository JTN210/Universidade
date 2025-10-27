# EX1
library(palmerpenguins)
library(tidyverse)
peng <- penguins |> drop_na(flipper_length_mm, bill_length_mm)

peng
dim(peng)

summary(peng)

ggplot(peng,aes (x = bill_length_mm, y = flipper_length_mm)) +
  geom_point()


modelo <- lm(flipper_length_mm ~bill_length_mm, data = peng)

summary(modelo)

126.6844+1.6902*45
predict(modelo, newdata = data.frame(bill_length_mm = 45), interval = "prediction")


plot(modelo)


# EX 2

data(diamonds, package = "ggplot2")

ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point(alpha = 0.5, color = "cyan") +  # pontos
  geom_smooth(method = "lm", color = "pink", se = TRUE) +  # reta de regressão linear
  labs(
    title = "Relação entre preço e peso em quilates dos diamantes",
    x = "Peso (carat)",
    y = "Preço (USD)"
  ) 

modelo1 <- lm(price ~ carat, data = diamonds)

summary(modelo1)


modelo2 <- lm(log(price) ~ log(carat), data = diamonds)
summary(modelo2)

summary(modelo1)$r.squared   # R² do modelo original
summary(modelo2)$r.squared   # R² do modelo logarítmico

# Resíduos do modelo 1
plot(modelo1, which = 1)  # resíduos vs ajustados

# Resíduos do modelo 2
plot(modelo2, which = 1)  # resíduos vs ajustados (modelo log)

novo_diamante <- data.frame(carat = 1.0)
pred_log <- predict( modelo2,  newdata = novo_diamante, interval = "prediction",  level = 0.95)

pred_log


# EX 3 
library(gapminder)
gm <- gapminder |> filter(year == 2007)

modelo1 <- lm(lifeExp ~ gdpPercap, data = gm)

modelo1

ggplot(gm,aes (x = gdpPercap, y = lifeExp)) +
  geom_point() + geom_smooth(method = "lm")

modelo2 <- lm(lifeExp ~ log(gdpPercap), data = gm)

modelo2 

ggplot(gm,aes (x = log(gdpPercap), y = lifeExp)) +
  geom_point() + geom_smooth(method = "lm")