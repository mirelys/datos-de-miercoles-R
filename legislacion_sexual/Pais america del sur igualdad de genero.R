#Base_de_Datos
library(readr)
leyes <- readr::read_csv("https://raw.githubusercontent.com/cienciadedatos/datos-de-miercoles/master/datos/2019/2019-06-19/leyes.csv")
cambios <- readr::read_csv("https://raw.githubusercontent.com/cienciadedatos/datos-de-miercoles/master/datos/2019/2019-06-19/cambios.csv")

#instalar las siguientes librerias

library(tidyverse)
library(dplyr)
library(ggplot2)
library(purrr)


#limpiar_data_para_filtrar_seleccionar_pais

Leyes_de_America_del_Sur<-leyes%>% 
  filter(pais_es %in% c("Argentina", "Bolivia", "Brasil", "Chile", "Colombia", "Ecuador", "Guyana", "Paraguay", "Peru", "Trinidad y Tobago", "Surinam", "Uruguay","Venezuela"))%>%
  select(pais_es,
         matrimonio= reconocimiento_matrimonio,
         union_civil= reconocimiento_union_civil,
         adopcion_conjunta= reconocimiento_adopcion_conjunta)%>%
  gather( "reconocimiento " , "acepta " , 2 :4 )

#paso 2

Leyes_de_America_del_Sur$`acepta `<-factor(Leyes_de_America_del_Sur$`acepta `,
                                           levels = c("0","1"),
                                           labels = c("no","si"))

install.packages("ggthemes")
library(ggthemes)
library(colorspace)
install.packages("colourpicker")
library(colourpicker)
install.packages("raster")
library(raster)
colorspace::

#crear imagen para colocar en grafica 

  library(magick) 
  library(grid)
  corazon<-image_read("https://i.pinimg.com/originals/a3/0c/d5/a30cd5c4a0f76c4cb87ec26b1d461d07.gif")
  corazon<-image_scale(corazon,"80")
  image_info(corazon)
  print(corazon)


#grafica con imagen agregada 
  
 library(ggthemes)
 library(raster) 
  
      ggplot(Leyes_de_America_del_Sur, aes ( x  = `reconocimiento ` , y  =  pais_es )) +
      geom_tile(aes(fill=`acepta `),color="lightsteelblue",size=7)+
      scale_fill_manual(values=c("hotpink","mediumorchid3"))+
      theme_gdocs() +
      theme()+
      ggtitle('Paises de America del Sur
      Legalidad de las relaciones entre parejas del mismo sexo')+
      grid.raster(corazon, x= 2:3/4,y=2:3/4,w=.1,interp=FALSE)
      
    
    
 
  
  
  



  
