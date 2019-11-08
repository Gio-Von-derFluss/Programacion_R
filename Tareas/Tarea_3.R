##################################################
#####     TAREA DE RegEx, Ggplot2 y shiny      ###
##################################################

##########
# RegEx   -------------------------------------------------
library(stringr)
library("Biostrings")
setwd("~/cursoR")
fasta <- readDNAStringSet("tarea.fasta")

vectorCars <- c("juan1@hotmail.com",
                "2juanes@hotmail.com",
                "juaMes@hatmail.com",
                "pedro99@gmail.com",
                "pedro@hotmail.com",
                "pedro9@gmail.com",
                "peter11@xmail.com",
                "otroJujuan99@hotmail.com",
                "otrojuan99@gmail.com",
                "juanchito99@gmail.com",
                "superJuancho99@xmail.com",
                "mary01@gmail.com",
                "sistermarria@gmail.com",
                "marryMe@gmail.com",
                "maria01@gmail.com",
                "maRia01@gmail.com",
                "jhonBravo@gmail.xom",
                "johnBravo@gmail.com",
                "jaunMalEscritoBravin@gmiial.com",
                "jaunGravo@gmail.com",
                "JHONNY@gmail.com",
                "pedrito611@gmail.com",
                "marian@hotmail.com",
                "PedroMaria@gmail.com",
                "juanMaria@xmail.com",
                "JuanPedro@hotmaail.com",
                "pedroJuan@hotmail.com",
                "juanPedrito@hotmail.com")


### crear un regex para extraer del vectorCars

## Ejercicio 1. el mismo usario (expl�?cito) en dos proveedores de correo
regex_1 <- regex(" #usuario que sea juan, jorge p john y que este en proveedores hotmail y gmail
  j #inicie con j
  [:alnum:]+ #tenga numeros o letras  hasta un graph
  [:graph:]
  (hotmail|gmail)
", comments = TRUE, ignore_case = TRUE)

str_extract_all(vectorCars,regex_1) 
## Ejercicio 2. potencialmente el mismo usuario tanto en el mismo proveedor como en distintos proveedores. Para los dos casos suponga que solo existen tres nombres: Maria / Juan / Pedro, en distintos idiomas
regex_2 <- regex("# usuario que inicie con j en cualquier proveedor
  j
  [:alnum:]+
  [:graph:]
  [:alnum:]+
", comments = TRUE, ignore_case = TRUE)

str_extract_all(vectorCars,regex_2)
## Ejercicio 3. corrija de manera automatica los usarios o los dominios con nombres errados; preferiblemente escrito como una función.
regex_3 <- regex(" #busque todo lo que inicia en numeros y letras e ignore si es mayuscula o minuscula
  ^[:alnum:]+
", comments = TRUE, ignore_case = TRUE)

my_func <- function(x) {#funcion para reemplazar con tres nombres: Juan, Pedro y Maria con las lineas que cumplen los requisitos para cada nombre
  x %>%
    str_replace_all(c("(\\w{4,7}uan|\\dj|j|J)[:alnum:]+" = "Juan", "(Ped|pet|ped)[:alnum:]+" = "Pedro", "(......m|m|M)[:alnum:]+" = "Maria"))
}

str_replace_all(vectorCars,regex_3,my_func)#Reemplazo con mi funcion para corregir todos los nombres

## Ejercicio 4.1 cuantificar el n�mero de veces que se repiten tripletas de la misma base AANA/CCC/TTNT/GGG
str_count(fasta@ranges@NAMES,"(AANA|CCC|TTNT|GGG)")#numero de veces por cada tripleta
## Ejercicio 4.2 repita el conteo anterior pero considere que N puede ser la base de la izquierda o de la derecha
sum(lengths(str_extract_all(fasta@ranges@NAMES,"(AA[AN]A|CCC|TT[TN]T|GGG)")))#numero de veces por cada tripeta y que a la derecha o izquerda pueda estar otra base

## Ejercicio 5.1 Suponga que los datos contienen 0 / 1 o 2 genes, el gen 1 inicia con SSSN y termina en WWWW y el gen 2 inicia en BWW y termina en AANA, indique si cada entrada contiene o no los genes 1 y/o 2. [Pista, inicio sucede ANTES que termina]
regex_5.1 <- regex(" #encontrar el primer gen
  [SGC][SGC][SGC][NATGC]
  [:alpha:]{1,}?
  [AT][AT][AT][AT]
  ", comments = TRUE)
regex_5.2 <- regex(" #encontrar el segundo gen
  [GTC][AT][AT]
  [:alpha:]{1,}?
  AA[AGTCN]A
  ", comments = TRUE)
regex_5.3 <- regex("
  [SGC][SGC][SGC][NATGC][:alpha:]{1,}?(?=)[AT][AT][AT][AT]|[GTC][AT][AT][:alpha:]{1,}?(?=)AA[AGTCN]A #combinacion para poder encontrar los dos genes, el {1,}? es usado para que pueda encontrar otras bases entre las secciones de inicio y fin
  ", comments = TRUE)#
str_locate_all(fasta@ranges@NAMES[3],regex_5.3) # en este caso, solo existe el gen 2
str_locate_all(fasta@ranges@NAMES[3],regex_5.1)
str_locate_all(fasta@ranges@NAMES[3],regex_5.2)

## Ejercicio 5.2 cuantificar el número de veces que se repiten tripletas de la misma base AAA/CCC/TTT/GGG

str_count(fasta@ranges@NAMES,"(AAA|CCC|TTT|GGG)")# numero de veces en que estan las tripletas de las 4 bases

## Ejercicio 5.3 repita el conteo anterior pero considere que N (el codigo IUPAC) puede ser cualquier base
str_count(fasta@ranges@NAMES,"(AA[AGTC]A|CCC|TT[AGTC]T|GGG)") #numero de veces de las tripletas en las que N puede ser cualquier base

##########
# Ggplot2   -------------------------------------------------

library(ggplot2) #Cargar paquete

data(iris)

## Utilizando los datos de iris

## Ejercicio 1. Usando el paquete "emoGG" y "ggplot2" definir un emoji por especie en un grafico de dispersión
#devtools::install_github("dill/emoGG") #Instalar el paquete emoGG

ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color = Species)) + #rellenamos por especies con tres emojis: gun para setosa, car para virginica y face para versicolor
  theme_bw() +
  geom_emoji(data = iris[iris$Species == "setosa", ], emoji = "1f52b",size=0.03) + #gun
  geom_emoji(data = iris[iris$Species == "virginica", ], emoji = "1f697", size=0.03) + #car
  geom_emoji(data = iris[iris$Species == "versicolor", ], emoji = "1f63b", size=0.03) #face

## Ejercicio 2. Construir una grafica con las l�?neas de regresión por especie, pero modificar en itálica los nombres de las especies en la leyenda

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

## Ejercicio 3. Construir una gráfica con las l�?neas de regresión por especie, incluir el valor de p, r2 y formula (Pista: Usar la función stat_poly_eq)

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
       subtitle = "Data: Iris regresión") + #subtitulo
  labs(x = "Longitud del sepalo", y = "Ancho del sepalo")#nombres de los ejes

## Ejercicio 4. Cree su propio theme donde las majorgrid sean verdes, las minorgrid de color rosado, el fondo de la grafica de color azul, el margen derecho y el margen superior no aparezcan.

mitema <- theme(panel.grid.major = element_line(colour = "green"), 
                panel.grid.minor = element_line(colour = "pink"),
                panel.background = element_rect(fill = "blue"),
                panel.border = element_blank(),axis.line = element_line(size = 0.9, linetype = "solid", colour = "black"))

##########
# Shiny   -------------------------------------------------

## Ejercicio 1. Crear un app que reciba una cantidad de números simulados bajo una distribución normal y que como output sea una grafica tipo histograma y una tabla que muestre la media, la mediana y la sd de los datos
shinyApp(ui = ui, server = server)



ui <- fluidPage( #espacio para que el usuario introduzca valor numerico
  numericInput(inputId = "n",
               "Sample size", value = 100), #por defecto, 100
  plotOutput(outputId = "hist"), #id de histograma
  tableOutput(outputId = "table") #id de tabla
)
server <- function(input, output) {
  output$hist <- renderPlot({#funcion para realizar el histograma y ser mostrado luego en nuestro ui con su id
    set.seed(10)
    data_1 <- rnorm(input$n)
    hist(data_1)
  })
  output$table <- renderTable({#funcion para realizar la tabla y ser mostrado luego en nuestro ui con su id
    set.seed(10)
    data_2 <- rnorm(input$n)
    matrix(data=c(mean(rnorm(data_2)),median(rnorm(data_2)),sd(rnorm(data_2))), dimnames = list(c("Mean","Median","SD"),"Value"))
  }, rownames = T)
}
shinyApp(ui = ui, server = server)
