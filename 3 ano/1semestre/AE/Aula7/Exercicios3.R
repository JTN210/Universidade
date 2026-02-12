library(ISLR2)
library(ggplot2)
ncol(NCI60$data)
sum(anyNA(NCI60$data))

X <- scale(NCI60$data)

pca_ni <- prcomp(X,center = FALSE, scale. = FALSE)

valores_proprios = pca_ni$sdev^2
PVE <- valores_proprios/sum(valores_proprios)
PVE_ACUMULADO <- cumsum(PVE)

screeplot(pca_ni)
 plot(valores_proprios, type = "b",
      xlab = "Componente Principal",
      ylab = "Valores Proprios",
      main = "Scree Plot")

plot(PVE_ACUMULADO, type = "b",
     xlab = "Componente Principal",
     ylab = " PVE ACUMULADO")

scores <- pca_ni$x
lab <- NCI60$labs

ggplot(data = scores, aes(x = PC1, y = PC2, color = lab)) + 
  geom_point()

loading <- pca_ni$rotation
ord1 <- order(abs(loading[,1]), decreasing = TRUE)[1:25]
ord2 <- order(abs(loading[,2]), decreasing = TRUE)[1:25]
ord1 
ord2
sobreposicao = length(intersect(ord1, ord2))
sobreposicao

#Exercicio 2 
library(mlbench)
data(Sonar)
X <- scale(as.matrix(Sonar[, 1:60]))
y <- Sonar$Class

pca_sonar <- prcomp(X,center = FALSE, scale. = FALSE)

ev <- pca_sonar$sdev^2 
PVE <- ev/sum(ev)
PVE_ACUMULADO <- cumsum(PVE)

plot(ev, type = "b", 
     xlab = "Componente Principal",
     ylab = "Variancia Explicado",
     main = "Scree Plot")

ggplot(pca_sonar$x, aes(x = PC1, y = PC2, color = y)) + 
  geom_point()

biplot(pca_sonar, scale = 0)
loading <-pca_sonar$rotation
ord1 <- order(abs(loading[,1]), decreasing = TRUE)[1:5]
ord2 <- order(abs(loading[,2]), decreasing = TRUE)[1:5]
ord1
ord2

# Exercicio 3 
library(pls)
X <- scale(yarn$NIR)

pca_yarn <- prcomp(X, center = FALSE, scale. = FALSE)
valores_proprios <- pca_yarn$sdev^2
PVE <- valores_proprios/sum(valores_proprios)
PVE_ACUMULADO <- cumsum(PVE)

plot(valores_proprios,type = "b",
     xlab = "Componente Principal",
     ylab = " valores_proprios",
     main = "Grafico de Valores Proprios")

plot(PVE,type = "b", 
     xlab = "Componente Principal",
     ylab = "PVE",
     main = "Grafico do PVE")

plot(PVE_ACUMULADO, type = "b",
     xlab ="Componente Principal",
     ylab = "PVE ACUMULADO",
     main = "Grafico do PVE ACUMULADO")
