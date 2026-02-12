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

