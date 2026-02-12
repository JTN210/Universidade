library(ISLR2)
library(ggplot2)
#1
ncol(NCI60$data)
sum(anyNA(NCI60$data))

# 2
X <- scale(NCI60$data)

# 3 

pca_ni <- prcomp(X, center = FALSE, scale. = FALSE)

valores_proprios <- pca_ni$sdev^2
PVE <- valores_proprios/sum(valores_proprios)
PVE_acumulado = cumsum(PVE)

plot(valores_proprios, type = "b",
    xlab = "Componente Principal",
    ylab = "Variância Explicada",
    main = "Scree Plot")
plot(PVE_acumulado, type = "b",
     xlab = "Componente Principal",
     ylab = "PVE-ACUMULADO",
     main = "Scree Plot")

scores <- pca_ni$x
labs <- NCI60$labs

ggplot(data = scores, aes(x = PC1, y = PC2,
     color = labs),
     xlab = "CP1",
     ylab = "CP2",
     main = "CP1 vs CP2 (NCI60)") + 
       geom_point()

loading <- pca_ni$rotation
ord1 <- order(abs(loading[,1]), decreasing = TRUE)[1:25]
ord2 <- order(abs(loading[,2]), decreasing = TRUE)[1:25]
ord1
ord2
sobreposicao = length(intersect(ord1, ord2))
sobreposicao

# Exercicio2
library(mlbench)
data(Sonar)
X <- scale(as.matrix(Sonar[, 1:60]))
y <- Sonar$Class

pca_sonar <- prcomp(X,center = FALSE, scale. = FALSE)
ev = pca_sonar$sdev^2
PVE = ev / sum(ev)
PVE_ACUMULADA = cumsum(PVE)

plot(ev, type = "b", 
    xlab = "Componente Principal",
    ylab = "Variancia Explicado",
    main = "Scree Plot")


scores <- pca_sonar$x
labs <- y    
ggplot(data = scores, aes(x = PC1, y = PC2,
      colour = y),
       xlab = "CP1",
       ylab = "CP2",
       main = "CP1 VS CP2") + 
  geom_point()

biplot(pca_sonar, scale = 0)
loading <- pca_sonar$rotation
ord1 <- order(abs(loading[,1]), decreasing = TRUE)[1:5]
ord2 <- order(abs(loading[,2]), decreasing = TRUE)[1:5]
ord1
ord2

# Exercicio 3 

library(pls)

X <- scale(yarn$NIR)
pca_yarn <- prcomp(X, center = FALSE,scale. = FALSE)
ev <- pca_yarn$sdev^2
PVE <- ev/sum(ev)
PVE_ACUMULADO <- cumsum(PVE)

plot(ev, type = "b",
     xlab = "Componentes Principal",
     ylab = "Variancia Explicada",
     main = " SCREE PLOT")

plot(PVE,type = "b",
     xlab = "Componente Principal",
     ylab = " PVE",
     main = "SCREE PLOT")

plot(PVE_ACUMULADO,type = "b",
     xlab = "Componente Principal",
     ylab = " PVE_Acumulado",
     main = "SCREE PLOT")



