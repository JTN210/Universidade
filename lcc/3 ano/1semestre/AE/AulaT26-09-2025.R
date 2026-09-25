
library(ggplot2)
library(gapminder)
library(gganimate)
gapminder
gapminder$year
gapminder$country
unique(gapminder$country)

head(gapminder)
ggplot(gapminder, aes(x=country, y= lifeExp)) + 
  geom_bar(stat = "identity")

ggplot(gapminder,aes(x=gdpPercap,y=lifeExp)) + 
  geom_point()


head(beers)


unique(beers$brand)
length(unique(beers$brand))

table(beers$brand)

beers_superbock <- beers[beers$brand=="Super Bock",]

preço_marca <- tapply(beers$price_eur,beers$brand,mean)
str(preço_marca)
dados_novos <- as.data.frame(preço_marca)
dados_novos$brand<-row.names(dados_novos)
dados_novos
ggplot(dados_novos,aes(x=brand,y=preço_marca)) + 
  geom_bar(stat="identity")

