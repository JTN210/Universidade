library(ISLR2)

str(NCI60)
dim(NCI60$data)

anyNA(NCI60$data)      # TRUE se houver NA, FALSE se não houver
sum(is.na(NCI60$data)) # número total de NA

X <- scale(NCI60$data)

# 3

pca_nci <- prcomp(X, center = FALSE, scale. = FALSE)

# Eigenvalues (variância explicada por cada componente)
eigenvalues <- (pca_nci$sdev)^2

# Variância total (soma de todas as variâncias)
total_var <- sum(eigenvalues)

# PVE = Proporção da Variância Explicada
PVE <- eigenvalues / total_var

# PVE acumulada
PVE_acum <- cumsum(PVE)


par(mfrow = c(1, 2))  # dois gráficos lado a lado

# (a) Scree plot dos eigenvalues
plot(eigenvalues,
     type = "b",
     xlab = "Componente principal",
     ylab = "Variância explicada (eigenvalue)",
     main = "Scree plot")

# (b) PVE e PVE acumulada
plot(PVE,
     type = "b",
     xlab = "Componente principal",
     ylab = "Proporção da variância explicada",
     main = "PVE")

plot(PVE_acum,
     type = "b",
     xlab = "Componente principal",
     ylab = "PVE acumulada",
     main = "PVE acumulada",
     ylim = c(0, 1))
abline(h = 0.8, lty = 2)



# 4

scores <- pca_nci$x       # 64 × 64 (no máx. min(n, p) = 64 CPs)
labs <- NCI60$labs        # tipos de cancro

# Converter labels em fator e depois em cores
labs_factor <- as.factor(labs)
cores <- as.numeric(labs_factor)  # 1,2,3,... uma cor para cada tipo

par(mfrow = c(1,1))

plot(scores[, 1], scores[, 2],
     col = cores,
     pch = 19,
     xlab = "CP1",
     ylab = "CP2",
     main = "CP1 vs CP2 (NCI60)")

legend("bottom",
       legend = levels(labs_factor),
       col = 1:length(levels(labs_factor)),
       pch = 19,
       cex = 0.6)


# 5 

loadings <- pca_nci$rotation   # 6830 × 64
dim(loadings)

# Loadings do CP1
load_pc1 <- loadings[, 1]

# Índices dos 25 maiores |loadings|
idx_pc1 <- order(abs(load_pc1), decreasing = TRUE)[1:25]

# Nomes dos genes (são os nomes das colunas de NCI60$data)
genes_pc1 <- colnames(NCI60$data)[idx_pc1]

genes_pc1

load_pc2 <- loadings[, 2]
idx_pc2 <- order(abs(load_pc2), decreasing = TRUE)[1:25]
genes_pc2 <- colnames(NCI60$data)[idx_pc2]

genes_pc2

intersec <- intersect(genes_pc1, genes_pc2)
intersec
length(intersec)  # quantos genes aparecem nas duas listas

# Exercicio 2 

library(mlbench)
data(Sonar)
str(Sonar)

X <- scale(as.matrix(Sonar[, 1:60]))
y <- Sonar$Class

pca_sonar <- prcomp(X, center = FALSE, scale. = FALSE)

eigenvalues <- (pca_sonar$sdev)^2
eigenvalues[1:10]   # só para ver os primeiros

total_var <- sum(eigenvalues)

PVE <- eigenvalues / total_var
PVE_acum <- cumsum(PVE)


par(mfrow = c(1, 2))

# Scree plot
plot(eigenvalues,
     type = "b",
     pch = 19,
     xlab = "Componente Principal",
     ylab = "Variância Explicada",
     main = "Scree Plot - Sonar")

# PVE acumulada
plot(PVE_acum,
     type = "b",
     pch = 19,
     ylim = c(0, 1),
     xlab = "Componente Principal",
     ylab = "PVE Acumulada",
     main = "PVE Acumulada")
abline(h = 0.8, col = "red", lty = 2)


# 3

scores <- pca_sonar$x
y_factor <- as.factor(y)
cores <- as.numeric(y_factor)

plot(scores[,1], scores[,2],
     col = cores,
     pch = 19,
     xlab = "CP1",
     ylab = "CP2",
     main = "CP1 vs CP2 - Sonar Dataset")

legend("topright",
       legend = levels(y_factor),
       col = 1:length(levels(y_factor)),
       pch = 19)


# 4 

biplot(pca_sonar, scale = 0)

loadings <- pca_sonar$rotation
dim(loadings)

load_cp1 <- loadings[, 1]   # coluna do CP1
idx_cp1 <- order(abs(load_cp1), decreasing = TRUE)[1:5]
vars_cp1 <- colnames(Sonar)[idx_cp1]

vars_cp1

load_cp2 <- loadings[, 2]   # coluna do CP2
idx_cp2 <- order(abs(load_cp2), decreasing = TRUE)[1:5]
vars_cp2 <- colnames(Sonar)[idx_cp2]

vars_cp2

intersect(vars_cp1, vars_cp2)

# Exercicio 3

library(pls)
data(yarn)
str(yarn)

X <- scale(yarn$NIR)
dim(X)
anyNA(X)

# 2 
pca_yarn <- prcomp(X, center = FALSE, scale. = FALSE)

eigenvalues <- (pca_yarn$sdev)^2
eigenvalues[1:10] 

total_var <- sum(eigenvalues)
PVE <- eigenvalues / total_var
PVE[1:10]

PVE_acum <- cumsum(PVE)
PVE_acum[1:10]

par(mfrow = c(1, 3))

# (1) Scree plot (eigenvalues)
plot(eigenvalues,
     type = "b",
     pch = 19,
       xlab = "Componente Principal",
     ylab = "Variância explicada (eigenvalue)",
     main = "Scree Plot - yarn")

# (2) PVE
plot(PVE,
     type = "b",
     pch = 19,
     xlab = "Componente Principal",
     ylab = "PVE",
     main = "Proporção da Variância Explicada")

# (3) PVE acumulada
plot(PVE_acum,
     type = "b",
     pch = 19,
     ylim = c(0, 1),
     xlab = "Componente Principal",
     ylab = "PVE acumulada",
     main = "PVE acumulada")
abline(h = 0.8, col = "red", lty = 2)  # marca o limiar de 80%

# 3 

scores <- pca_yarn$x

labels <- yarn$train          # TRUE / FALSE
labels_factor <- as.factor(labels)
cores <- as.numeric(labels_factor)
levels(labels_factor)

plot(scores[,1], scores[,2],
     col = cores,
     pch = 19,
     xlab = "CP1",
     ylab = "CP2",
     main = "Scores Plot: CP1 vs CP2 (yarn)")

legend("topright",
       legend = levels(labels_factor),
       col = 1:2,
       pch = 19,
       title = "Train/Test")

plot(scores[,2], scores[,3],
     col = cores,
     pch = 19,
     xlab = "CP2",
     ylab = "CP3",
     main = "Scores Plot: CP2 vs CP3 (yarn)")

legend("topright",
       legend = levels(labels_factor),
       col = 1:2,
       pch = 19,
       title = "Train/Test")
 
# 4 
loadings <- pca_yarn$rotation
dim(loadings)

load_cp1 <- loadings[, 1]

idx_cp1 <- order(abs(load_cp1), decreasing = TRUE)[1:10]
top_cp1 <- colnames(yarn$NIR)[idx_cp1]

top_cp1

load_cp2 <- loadings[, 2]

idx_cp2 <- order(abs(load_cp2), decreasing = TRUE)[1:10]
top_cp2 <- colnames(yarn$NIR)[idx_cp2]

top_cp2

par(mfrow = c(2,1))

plot(load_cp1, type="l", main="Loadings CP1", ylab="Loading", xlab="Wavelength Index")
abline(h=0)

plot(load_cp2, type="l", main="Loadings CP2", ylab="Loading", xlab="Wavelength Index")
abline(h=0)

wavelengths <- as.numeric(colnames(yarn$NIR))
plot(wavelengths, load_cp1, type="l")


