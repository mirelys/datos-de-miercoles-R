
#instalar las siguiente libraria antes de ejecutar el data set
install.packages("readr")
library(readr)
library(dplyr)
library(ggplot2)
library(tidyverse)

#data set 
vinos <- readr::read_csv("https://raw.githubusercontent.com/cienciadedatos/datos-de-miercoles/master/datos/2019/2019-06-12/vinos.csv") %>%
extract(titulo_resena,"year","([12][90]\\d\\d)",convert=TRUE,remove = FALSE)%>%
  mutate(year=ifelse(year<1900,NA,year))
  

install.packages("wordcloud")
library(wordcloud)
install.packages("dplyr")
install.packages("ggplot2")
library(dplyr)
library(ggplot2)
library(purrr)

#seleccionar los vinos con mayor puntación
vinos_mayor_puntacion<-vinos%>%filter(puntos>90)

install.packages("RColorBrewer")
library(RColorBrewer)
install.packages("cluster")
library(cluster)
install.packages("tm")
library(NLP)
library(tm)

#limpiar data los nombres de los vinos con mayor puntacion de 90

nombre_vinos_mayor_pt<-vinos_mayor_puntacion$nombre
nombre_mayor_f_Vino<-data.frame(nombre_vinos_mayor_pt)
nombre_mayor_f_Vino <- nombre_mayor_f_Vino[!is.na(nombre_vinos_mayor_pt),]

nombre_vinos_text <- nombre_mayor_f_Vino %>% as.matrix
dim(nombre_vinos_text)

#ordenar y limpiar textos de la data

nombre_vinos_text <- gsub("[[:cntrl:]]", " ", nombre_vinos_text)
nombre_vinos_text <- tolower(nombre_vinos_text)
nombre_vinos_text <- removePunctuation(nombre_vinos_text)
nombre_vinos_text <- removeNumbers(nombre_vinos_text)
nombre_vinos_text<- stripWhitespace(nombre_vinos_text)

nombre_mayor_Vinos_c<-Corpus(VectorSource(nombre_vinos_text))
nombre_mayor_f_Vino_ptd <- tm_map(nombre_mayor_Vinos_c, PlainTextDocument)
wordcloud(nombre_mayor_Vinos_c, max.words = 250, random.order = F, colors = brewer.pal(name = "Dark2", n = 8))

#numero de frecuenia en palabras

nombre_Vino_tdm<-TermDocumentMatrix(nombre_mayor_Vinos_c)
nombre_Vino_tdm

nombre_Vino_mat <- as.matrix(nombre_Vino_tdm)

dim(nombre_Vino_mat)
nombre_Vino_mat <- nombre_Vino_mat %>% rowSums()%>%sort(decreasing = TRUE)
nombre_Vino_mat <- data.frame(palabra = names(nombre_Vino_mat), frec = nombre_Vino_mat)

#grafica nube de palabras
nombre_Vino_mat[1:200,]
repetidas <- data.frame(nombre_Vino_mat[1:200,])


par(bg="black")#asignar color de fondo para la nube de palabras
wordcloud(
  words = repetidas$palabra, 
  freq = repetidas$frec, 
  max.words = 280, 
  random.order = F, 
  colors=brewer.pal(name = "Paired", n = 12))
  
