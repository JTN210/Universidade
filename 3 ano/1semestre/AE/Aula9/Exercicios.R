#Exercicio 1 

dados_ex1 <- c(6.5, 7.0, 5.8, 8.2, 6.9, 7.5, 5.2, 6.1, 7.8, 6.3, 5.9, 7.1)
dados_ex1
length(dados_ex1)


mean(dados_ex1)

var(dados_ex1)

min(dados_ex1)
mean(dados_ex1)
max(dados_ex1)
sd(dados_ex1)


#Exercicio 2 
#  1 
dados <- baterias
summary(dados)
media_amostral <- mean(dados$duracao)
devio_padrão <- sd(dados$duracao)
media_amostral
devio_padrão

# 2 
t.test(dados$duracao, conf.level = 0.95)

# 3 

# Exercicio 3 

p <- 90/200
p


sucessos <- 90
n <- 200
prop.test(sucessos, n, correct = FALSE)

# 2 

p_hat <- 90/200
p0    <- 0.4
n     <- 200

se0   <- sqrt(p0*(1-p0)/n)
Z     <- (p_hat - p0)/se0
Z

# p-valor bilateral
2 * (1 - pnorm(abs(Z)))



# e 

# Exercicio 4 

dados2 <- estudo_notas

plot(dados2$horas_estudo, dados2$nota,
     xlab = "Horas de estudo por semana",
     ylab = "Nota no teste",
     pch = 19, col = "darkblue",
     main = "Dispersão: horas de estudo vs nota")

# b 

modelo <- lm(nota ~ horas_estudo, data = dados2)
summary(modelo)

# c 

# e 

confint(modelo, level = 0.95)




# ================================== LUME =====================================

dados <- c(6.5, 7.0, 5.8, 8.2, 6.9, 7.5, 5.2, 6.1, 7.8, 6.3, 5.9, 7.1)
dados
length(dados) 
mean(dados)

var(dados)

min(dados)
max(dados)
mean(dados)
sd(dados)

dados_bateria <- baterias
summary(dados_bateria)
mean(dados_bateria$duracao)
sd(dados_bateria$duracao)

# 3 c 

t.test(dados_bateria$duracao,conf.level = 0.95)

# 3 d 


# Exercicio 3 

proporcao <- 90/200 
proporcao


# c 
fixe <- 90 
todos <- 200 
prop.test(fixe, todos, correct = FALSE)




# Exercicio 4 

notas <- estudo_notas
ggplot(data= notas, aes(x = horas_estudo, y = nota)) +
  geom_point() + 
  labs(title = " Grafico de dispersão",
       x = "Horas estudo",
       y = "Notas")

modelo1 <- lm(nota ~ horas_estudo, data = notas)
summary(notas)

confint(modelo1, level = 0.95)

#=============================== Ficha 9 - 2 =================================================
library(ggplot2)
redução_controlo   <- c(2, 0, 3, -1, 1, 2, 0, 1, -2, 2)
redução_tratamento <- c(5, 7, 4, 6, 3, 8, 5, 6, 4, 7)

mean(redução_controlo)
mean(redução_tratamento)
sd(redução_controlo)
sd(redução_tratamento)
length(redução_controlo)
length(redução_tratamento)

dados <- data.frame(
          redução = c(redução_controlo, redução_tratamento),
          grupos = c(rep("Controlo", length(redução_controlo)),
                     rep("Tratamento", length(redução_tratamento))
                     )
                  )
dados
ggplot(data = dados, aes(x = grupos , y = redução)) + 
  geom_boxplot()



