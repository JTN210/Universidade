r <- 0.7

P <- matrix(c(1, r,
              r, 1), nrow = 2, byrow = TRUE)

res <- eigen(P)
res$values  
res$vectors

