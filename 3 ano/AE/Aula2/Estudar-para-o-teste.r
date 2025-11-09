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

library(dplyr)
library(tidyr)

