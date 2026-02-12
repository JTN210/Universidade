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
