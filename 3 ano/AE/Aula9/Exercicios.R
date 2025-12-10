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
