library(tidyr)
library(dplyr)
library(ggplot2)

head(dados_eurostat)

dadospt <- dados_eurostat |>
          filter( country == "Portugal")

ggplot(dadospt, aes( x = time, y = Total)) + geom_line( color = "red")
dadospt



dadossex <- filter(dados_eurostat, time == "2019") 
dadossex |> group_by(country) |>
            summarise(total_Mulheres = mean(Females),
                      total_Homem = mean(Males)) |>
            arrange(desc(total_Mulheres - total_Homem)) |>
            head(5)
            
dadossex


dados_eurostat |> 
                group_by(country) |> 
                filter( time >= 2014) |> 
                summarise( tx_15_24 = mean(Under25),
                           tx_25 = mean(Over25)) |>
                mutate(racio = tx_15_24 / tx_25) |>
                arrange(desc(racio)) |>
                  head(5)
dados_eurostat
lume <- dados_eurostat |>
                          group_by(country) |>
                          summarise(Taxa = mean(Total)) |>
                          arrange(desc(Taxa)) |> 
                          head(5)
ggplot(lume, aes(x = country, y = Taxa)) + 
  geom_bar(stat = "identity",color = "cyan", fill = "pink")

  
              