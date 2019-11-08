#Ggplot
#Es una adicion de capas, consiste de dataframe, aesthetics y geometry para definir todos los componentes del plot

library(ggplot2) #Cargar paquete

data(iris)

head(iris)

ggplot(data=iris, aes(x=Sepal.Length, y=Sepal.Width)) + #grafica ejes y etiquetas
  theme_bw() + theme(panel.border = element_blank(), 
                     panel.grid.major = element_blank(), 
                     panel.grid.minor = element_blank(), 
                     axis.line = element_line(colour = "white")) +#definimos fondo y bordes
  labs(title = "Longitud del sepalo Vs. Ancho del sepalo", #titulo
       subtitle = "Data: Iris") + #subtitulo
  labs(x = "Longitud del sepalo", y = "Ancho del sepalo")#nombre de los ejes

#Puntos

ggplot(data=iris, aes(x=Sepal.Length, y=Sepal.Width)) + #Grafico base 
  geom_point() + # geometria que corresponde a los puntos
  theme_bw() + theme(panel.border = element_blank(), 
                     panel.grid.major = element_blank(), 
                     panel.grid.minor = element_blank(), 
                     axis.line = element_line(colour = "white"))+#definimos fondo y bordes
  labs(title = "Longitud del sepalo Vs. Ancho del sepalo", #tituo
       subtitle = "Data: Iris con puntos") + #subtitulo
  labs(x = "Longitud del sepalo", y = "Ancho del sepalo")#nombre de los ejes

#Color por especie

ggplot(data=iris, aes(x=Sepal.Length, y=Sepal.Width, color=Species)) + #Grafico base 
  geom_point(shape=5) +  # geometria que corresponde a los puntos
  theme_bw() + theme(panel.border = element_blank(), 
                     panel.grid.major = element_blank(), 
                     panel.grid.minor = element_blank(), 
                     axis.line = element_line(colour = "white"))+#definimos fondo y bordes
  scale_colour_discrete(name = "Especies")+
  labs(title = "Longitud del sepalo Vs. Ancho del sepalo", #titulo
       subtitle = "Data: Iris con puntos y color") + #subtitulo
  labs(x = "Longitud del sepalo", y = "Ancho del sepalo")#nombre de los ejes

#Mediante geom_point(shape =) podemos usar diferentes formas, como la estrella de david (shape = 11), arroba @ (shape = 64), numeros del 0 al 9  (shape = 48-58), entre otros

#########################################################################################
### GRAFICA BARRAS 


ggplot(data=iris, aes(x=Species, y=Sepal.Length, fill=Species)) + 
  geom_col()+ #grafico de barras, fill con especies (color de cada barra)
  theme_bw() + theme(panel.border = element_blank(), 
                     panel.grid.major = element_blank(), 
                     panel.grid.minor = element_blank(), 
                     axis.line = element_line(colour = "white"))+#definimos fondo y bordes
  scale_colour_discrete(name = "Especies")+
  labs(title = "Longitud del sepalo por especie", #titulo
       subtitle = "Data: Iris grafico de barras") + #subtitulo
  labs(x = "Especies", y = "Longitud del sepalo")#nombre de los ejes

### GRAFICA HISTOGRAMAS

ggplot(data=iris) + 
  geom_histogram(aes(x = Sepal.Width, fill = Species), 
                 bins = 12, position = "identity", alpha = 0.4) + # alpha para ver las barras que se sobreponen
  theme_bw() + theme(panel.border = element_blank(), 
                     panel.grid.major = element_blank(), 
                     panel.grid.minor = element_blank(), 
                     axis.line = element_line(colour = "white"))+#definimos fondo y bordes
  labs(title = "Longitud del sepalo por especie", #titulo
       subtitle = "Data: Iris histograma") + #subtitulo
  labs(x = "Especies", y = "Ancho del sepalo")#nombre de los ejes 


#Podemos graficar dado variables discretas como especies? Revisar facet_wrap
#con facet_wrap podemos plotear varias paneles de la misma secuencia de las diferentes especies
ggplot(data=iris) + 
  geom_histogram(aes(x = Sepal.Width, fill = Species), bins = 12) + 
  facet_wrap(~Species, ncol = 1)+#para cada especie, haga tres histogramas en una columna
  theme_bw() + theme(panel.border = element_blank(), 
                     panel.grid.major = element_blank(), 
                     panel.grid.minor = element_blank(), 
                     axis.line = element_line(colour = "white"))+#definimos fondo y bordes
  labs(title = "Longitud del sepalo por especie", #titulo
       subtitle = "Data: Iris histograma") + #subtitulo
  labs(x = "Ancho del sepalo", y = "Conteo")#nombre de los ejes


#Smooth

ggplot(data=iris, aes(x=Sepal.Length, y=Sepal.Width)) +  
  geom_smooth(method = "loess", se=TRUE) + #  metodo loess e intervalo de confianza se
  theme_bw() + theme(panel.border = element_blank(), 
                     panel.grid.major = element_blank(), 
                     panel.grid.minor = element_blank(), 
                     axis.line = element_line(colour = "white"))+#definimos fondo y bordes
  scale_colour_discrete(name = "Especies")+
  labs(title = "Longitud del sepalo Vs. Ancho del sepalo", #titulo
       subtitle = "Data: Iris con l√???neas e intervalo de confianza") + #subtitulo
  labs(x = "Longitud del sepalo", y = "Ancho del sepalo")#nombre de los ejes 

## Podemos quitar el intervalo de confianza

ggplot(data=iris, aes(x=Sepal.Length, y=Sepal.Width)) +  
  geom_smooth(method = "loess",se = FALSE) + # sin intervalo de confianza, se=F
  theme_bw() + theme(panel.border = element_blank(), 
                     panel.grid.major = element_blank(), 
                     panel.grid.minor = element_blank(), 
                     axis.line = element_line(colour = "white"))+#definimos fondo y bordes
  scale_colour_discrete(name = "Especies")+
  labs(title = "Longitud del sepalo Vs. Ancho del sepalo", #titulo
       subtitle = "Data: Iris con l√???neas y sin intervalo de confianza") + #subtitulo
  labs(x = "Longitud del sepalo", y = "Ancho del sepalo")#nombre de los ejes 


#metodo "lm"

ggplot(data=iris, aes(x=Sepal.Length, y=Sepal.Width)) + 
  geom_point()+ #incluimos los puntos de dispersion
  geom_smooth(method = "lm",se = TRUE) + #metodo lm e intervalo de confianza
  theme_bw() + theme(panel.border = element_blank(), 
                     panel.grid.major = element_blank(), 
                     panel.grid.minor = element_blank(), 
                     axis.line = element_line(colour = "white"))+#definimos fondo y bordes
  scale_colour_discrete(name = "Especies")+
  labs(title = "Longitud del sepalo Vs. Ancho del sepalo", #titulo
       subtitle = "Data: Iris con lm e intervalo de confianza") + #subtitulo
  labs(x = "Longitud del sepalo", y = "Ancho del sepalo")#nombre de los ejes

#metodo "auto"

ggplot(data=iris, aes(x=Sepal.Length, y=Sepal.Width)) + 
  geom_point()+ #incluimos los puntos de dispersion
  geom_smooth(method = "auto",se = TRUE) + #metodo auto e intervalo de confianza
  theme_bw() + theme(panel.border = element_blank(), 
                     panel.grid.major = element_blank(), 
                     panel.grid.minor = element_blank(), 
                     axis.line = element_line(colour = "white"))+#definimos fondo y bordes
  scale_colour_discrete(name = "Especies")+
  labs(title = "Longitud del sepalo Vs. Ancho del sepalo", #titulo
       subtitle = "Data: Iris con auto e intervalo de confianza") + #subtitulo
  labs(x = "Longitud del sepalo", y = "Ancho del sepalo")#nombre de los ejes

#metodo "glm"

ggplot(data=iris, aes(x=Sepal.Length, y=Sepal.Width)) + 
  geom_point()+ #incluimos los puntos de dispersion
  geom_smooth(method = "glm",se = TRUE) + #metodo glm e intervalo de confianza
  theme_bw() + theme(panel.border = element_blank(), 
                     panel.grid.major = element_blank(), 
                     panel.grid.minor = element_blank(), 
                     axis.line = element_line(colour = "white"))+#definimos fondo y bordes
  scale_colour_discrete(name = "Especies")+
  labs(title = "Longitud del sepalo Vs. Ancho del sepalo", #titulo
       subtitle = "Data: Iris con glm e intervalo de confianza") + #subtitulo
  labs(x = "Longitud del sepalo", y = "Ancho del sepalo")#nombre de los ejes

#metodo "gam"

ggplot(data=iris, aes(x=Sepal.Length, y=Sepal.Width)) + 
  geom_point()+ #incluimos los puntos de dispersion
  geom_smooth(method = "gam",se = TRUE) + #metodo gam e intervalo de confianza
  theme_bw() + theme(panel.border = element_blank(), 
                     panel.grid.major = element_blank(), 
                     panel.grid.minor = element_blank(), 
                     axis.line = element_line(colour = "white"))+#definimos fondo y bordes
  scale_colour_discrete(name = "Especies")+
  labs(title = "Longitud del sepalo Vs. Ancho del sepalo", #titulo
       subtitle = "Data: Iris con gam e intervalo de confianza") + #subtitulo
  labs(x = "Longitud del sepalo", y = "Ancho del sepalo")#nombre de los ejes

# lineas de dispersion por especie con color=Species

ggplot(data=iris, aes(x=Sepal.Length, y=Sepal.Width, color=Species)) + 
  geom_point()+ #incluir puntos de dispersion
  geom_smooth(method = "lm",se = TRUE) + # metodo lm e intervalo de confianza
  theme_bw() + theme(panel.border = element_blank(), 
                     panel.grid.major = element_blank(), 
                     panel.grid.minor = element_blank(), 
                     axis.line = element_line(colour = "white"))+#definimos fondo y bordes
  scale_colour_discrete(name = "Especies")+
  labs(title = "Longitud del sepalo Vs. Ancho del sepalo", #titulo
       subtitle = "Data: Iris con lm e intervalo de confianza") + #subtitulo
  labs(x = "Longitud del sepalo", y = "Ancho del sepalo")#nombre de los ejes



##################################################################################################
############################ Actividades adicionales #############################################
##################################################################################################
# 1. Construyan su propio tema

mitema <- theme(panel.grid.major = element_line(colour = "green"), 
                panel.grid.minor = element_line(colour = "pink"),
                panel.background = element_rect(fill = "blue"),
                panel.border = element_blank(),axis.line = element_line(size = 0.9, linetype = "solid", colour = "black"))
                
# 2. Usando el paquete "emoGG" y "ggplot2" definir un emoji por especie en un grafico de dispersi√≥n
#devtools::install_github("dill/emoGG") #Instalar el paquete emoGG

ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color = Species)) + #rellenamos por especies con tres emojis: gun para setosa, car para virginica y face para versicolor
  theme_bw() +
  geom_emoji(data = iris[iris$Species == "setosa", ], emoji = "1f52b",size=0.03) + #gun
  geom_emoji(data = iris[iris$Species == "virginica", ], emoji = "1f697", size=0.03) + #car
  geom_emoji(data = iris[iris$Species == "versicolor", ], emoji = "1f63b", size=0.03) #face

# 3. Construir una grafica con las l√???neas de regresi√≥n por especie, pero modificar en it√°lica los nombres de las especies en la leyenda

ggplot(data=iris, aes(x=Sepal.Length, y=Sepal.Width, color=Species)) + 
  geom_point()+ #puntos de dispersion
  geom_smooth(method = "lm",se = TRUE) + #smoth con metodo lm e intervalo de confianza
  scale_color_brewer(name = "Especies", palette = "Set2",labels=c(expression(paste(italic("I. setosa"))),expression(paste(italic("I. versicolor"))),expression(paste(italic("I. virginica"))))) + #leyenda con paleta de colores para los nombres de las epsecies, expression es usado para usar la fuente en italica
  theme_bw() + theme(panel.border = element_blank(), 
                     panel.grid.major = element_blank(), 
                     panel.grid.minor = element_blank(), 
                     axis.line = element_line(colour = "white"))+#definimos fondo y bordes
  labs(title = "Longitud del sepalo Vs. Ancho del sepalo", #titulo
       subtitle = "Data: Iris con lm e intervalo de confianza") + #subtitulo
  labs(x = "Longitud del sepalo", y = "Ancho del sepalo")#nombres de los ejes 

# 4. Construir una gr√°fica con las l√???neas de regresi√≥n por especie, incluir el p, r2 y formula (Pista: Usar la funci√≥n stat_poly_eq del paquete "ggpmisc")

library(ggpmisc)

ggplot(data=iris, aes(x=Sepal.Length, y=Sepal.Width, color=Species)) + 
  geom_point()+ #puntos de dispersion
  geom_smooth(method = lm, se = FALSE, formula = y~x, alpha= 0.18, size = 1.1) + # metodo lm y sin interval ode confianza
  stat_poly_eq(aes(label = paste(..eq.label.., ..rr.label.., sep = "~~~")), 
               label.x.npc = "right", label.y.npc = 0.9,
               formula = y~x, parse = TRUE, size = 4, position = "identity")+#generamos el p y el r2 en la posicion derecha
  scale_color_brewer(name = "Especies", palette = "Set2",labels=c(expression(paste(italic("I. setosa"))),expression(paste(italic("I. versicolor"))),expression(paste(italic("I. virginica"))))) + #leyenda con paleta de colores para los nombres de las epsecies, expression es usado para usar la fuente en ital
  theme_bw() + theme(panel.border = element_blank(), 
                     panel.grid.major = element_blank(), 
                     panel.grid.minor = element_blank(), 
                     axis.line = element_line(colour = "white"))+#definimos fondo y bordes
  labs(title = "Longitud del sepalo Vs. Ancho del sepalo", #titulo
       subtitle = "Data: Iris regresi√≥n") + #subtitulo
  labs(x = "Longitud del sepalo", y = "Ancho del sepalo")#nombres de los ejes
