#install.packages(readr)
datos_uip <- readr::read_csv("https://raw.githubusercontent.com/cienciadedatos/datos-de-miercoles/master/datos/2019/2019-05-08/datos_uip.csv")
library(tidyverse)
library(tidyselect)
library(readr)

#Filtrar datos

library(dplyr)
library(ggplot2)

Mujeres_Parlamento<-datos_uip%>% filter(integrante_mas_joven<35)

#limpiar datos

Mujeres_parl_L<-Mujeres_Parlamento%>%
  mutate(integrante_mas_joven=factor(integrante_mas_joven))%>%
  select(pais,integrante_mas_joven)

install.packages("gghighlight")
library(gghighlight)

#grafica con color y paises
Mujeres_parl_L%>%filter(pais %in% c("Argentina","Venezuela","Chile","Brasil","Perú","Uruguay","Paraguay","Trinidad y Tobago","Bolivia"))%>%
  ggplot(Mujeres_parl_L,mapping=aes(x=integrante_mas_joven,y=pais, color=pais))+
  geom_point()  + 
  theme_minimal() + 
  facet_wrap(~pais)+
  labs(x = "Edad de integrante más Joven",
       y = "Paises de America del Sur",
      title = "Mujeres más Jovenes del Parlamento en America del Sur",
      subtitle = "2000 - 2018",
      caption = "Fuente: Unión Interparlamentaria (Datos de Miercoles)")
      ggsave("ejemplo.png", width = 10, height = 6, dpi = 300)



