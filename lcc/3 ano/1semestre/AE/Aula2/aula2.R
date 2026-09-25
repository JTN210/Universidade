# AULA 2-10-2025

library(tidyverse)

set.seed(1234)
n <- 200
alunos <- tibble(
  id            = 1:n,
  curso         = sample(c("CC", "SI"), n, replace = TRUE, prob = c(.65, .35)),
  ano           = sample(1:3, n, replace = TRUE, prob = c(.4, .35, .25)),
  sexo          = sample(c("F", "M"), n, replace = TRUE),
  horas_estudo  = round(rlnorm(n, meanlog = log(6), sdlog = 0.5), 1),
  faltas        = pmax(0, round(rpois(n, lambda = 3) - rbinom(n, 1, .1)*3)),
  nota          = pmin(20,
                       pmax(0,
                            round( 8 +
                                     0.6 * pmin(horas_estudo, 20) -
                                     0.4 * pmin(faltas, 10) +
                                     rnorm(n, 0, 2.5), 1)))
) %>%
  mutate(
    # introduzir alguns outliers na nota
    nota = replace(nota, sample(1:n, 3), c(2, 19.5, 0)),
    # introduzir NAs em horas_estudo
    horas_estudo = replace(horas_estudo, sample(1:n, 6), NA_real_)
  )

head(alunos) #visualizar primeiras 6 linhas


# Exericio 1 
# a) Indique o tamanho Amostral = 6 , tamanho amostral é = ao numero de dados que temos
# b) id é categorica nominal
#    curso é categorica nominal
#    ano  é categorica ordinal
#    sexo é categorica nominal
#    horas é quantitativa continua 
#    faltas é quantitativa discreta
#   nota é quantitativa continua

# Exercicio 2 
mean(alunos$nota)
median(alunos$nota)
sd(alunos$nota)
IQR(alunos$nota)

# Exercicio 3 

iqr <- IQR(alunos$nota)
quantile(alunos$nota)
Q1 <- 8.75
Q3 <- 13.30
Tukey1 <- Q1 - 1.5 * iqr
Tukey3 <- Q3 + 1.5 * iqr

outlier <- alunos[alunos$nota < Tukey1 |alunos$nota > Tukey3,]
outlier
boxplot(alunos$nota, main = "Boxplot das notas", ylab = "Nota")

# Exercicio 4

library(ggplot2)

ggplot(alunos, aes(x = nota)) +
  geom_histogram(binwidth = 1, fill = "pink", color = "purple") +
  labs(title = "Histograma das notas", x = "Nota", y = "Frequência")


ggplot(alunos, aes(x = nota)) +
  geom_histogram(aes(y = ..density..),  # histograma normalizado para densidade
                 binwidth = 1, fill = "pink", color = "purple", alpha = 0.6) +
  geom_density(color = "yellow", size = 1) +
  labs(title = "Histograma com densidade das notas", 
       x = "Nota", y = "Densidade")

# Exercicio 5

ggplot(alunos, aes(x = curso, y = nota, fill = curso)) +
  geom_boxplot(alpha = 0.6) +
  labs(title = "Boxplots das notas por curso",
       x = "Curso", y = "Nota") +
  theme_minimal()

ggplot(alunos, aes(x = curso, y = nota, fill = sexo)) +
  geom_boxplot(alpha = 0.6) +
  labs(title = "Boxplots das notas por curso e sexo",
       x = "Curso", y = "Nota") +
  theme_minimal()

# b) 
library(dplyr)

alunos %>%
  group_by(curso, sexo) %>%
  summarise(
    n = n(),
    media = mean(nota),
    mediana = median(nota),
    IQR = IQR(nota)
  )

# Exercicio 6 
dados2 <- alunos %>% drop_na(horas_estudo, nota)
ggplot(dados2, aes(horas_estudo,nota)) +
  geom_point(alpha=.6) + geom_smooth(method = "lm", se = FALSE)

cor_pearson <- cor(dados2$horas_estudo, dados2$nota, method="pearson")
cor_spearman <- cor(dados2$horas_estudo, dados2$nota, method="spearman")
c(pearson = cor_pearson, spearman = cor_spearman)