#                       AULA PRATICA 23/10 

req <- c("tidyverse","broom","palmerpenguins","nycflights13","car","performance","GGally", "see")
new <- setdiff(req, rownames(installed.packages()))
if(length(new)) install.packages(new)

library(tidyverse)
library(broom)
library(palmerpenguins)
library(nycflights13)
library(car)           # VIF e diagnóstico
library(performance)   # checks de suposições
library(GGally)        # ggpairs
library(see)          # diagnóstico




penguins <- palmerpenguins::penguins |> drop_na()
glimpse(penguins)

summary(penguins)

flts <- nycflights13::flights |>
  filter(!is.na(dep_delay), !is.na(arr_delay),
         !is.na(distance), !is.na(air_time)) |>
  # amostra reprodutível
  slice_sample(n = 30000, replace = FALSE)
glimpse(flts)


# Ex1


penguins2 <- penguins |> select(bill_length_mm, bill_depth_mm, flipper_length_mm, body_mass_g)

ggpairs(penguins2)

cor(penguins2)


# Ex2

modelo <- lm(body_mass_g ~ bill_length_mm + bill_depth_mm * flipper_length_mm + species + sex, data=penguins)

summary(modelo)



