a = 4
b = 5 
a+b
c(1,2,3,a,b)
matrix(1:9,nrow = 3, ncol = 3)
 
dados <- data.frame(nome = c("Ana", "Bruno","Marco","Tomas"), Signo=c("Aquario","peixes","gemeos","carneiro"),cidade=c("Vieira","Braga","Famalicão","Trofa"), altura=c(1.84,1.72,1.80,1.80))
dados
str(dados)
summary(dados)
dados[2:4,]
dados$pe<-c(44,42,40.5,44)
dados
plot(dados$altura,dados$pe)



library(ggplot2)
ggplot(dados,aes(x=altura,y=pe)) + geom_point()

library(dplyr)

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
        
   
                          #  AULA 9-10-2025

# FICHA 3 
# 2
head(dados_eurostat)
View(dados_eurostat)
dim(dados_eurostat)
eurostat_pt <- filter(dados_eurostat,country == "Portugal")
View(eurostat_pt)
ggplot(eurostat_pt, aes(x = time, y = Total)) +
  geom_line(color = "purple", linewidth = 0.5)

#3

dados_recentes <- filter(dados_eurostat, year == "2019")
dados_recentes |>
  group_by(country) |> 
  summarise(
    total_mulheres = (mean(Females)),
    total_homens = (mean(Males))
    ) |>
  arrange(desc(total_mulheres - total_homens))|>
  head(5)
  
#4 

dados_recentes <- filter(dados_eurostat, year >= 2014 )
dados_recentes |>
  group_by(country) |> 
  summarise(
    taxa_desemprego15_24 = mean(Under25),
    taxa_desemprego25_54 = mean(Over25)
  ) |>
  arrange(desc(taxa_desemprego15_24 / taxa_desemprego25_54))|>
  head(5)

#5

dados_recentes <- dados_eurostat |>
  group_by(country) |> 
  summarise(taxa = mean(Total)
  ) |>
  arrange(desc(taxa))|>
  head(5)
str(dados_recentes)
  
ggplot(dados_recentes,aes(x = country, y = taxa)) +
  geom_bar( stat = "identity", color = "cyan",fill = "pink")


                       # AULA TEORICA 10/10
library(ggplot2)

data(women)
women
 ggplot(women,aes(x = height, y = weight)) +
   geom_point()
modelo <- lm(weight ~ height,data=women)
summary(modelo)

plot(modelo)


                    # AULA PRATICA 16/10

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













