#######################################
#####     TAREA DE S3, S4 y R6      ###
#######################################

##########
# S3 -------------------------------------------------------------------

# ejercicio 1.1 Cree un objeto de clase "Ropa" cuyos componentes sean precio y prenda.

obj <- list()
obj$precio <- c(1:3)
obj$prenda <- c("camisa","patalon","cucos")
class(obj) <- "Ropa"

# ejercicio 1.2 cree una función generica para la clase "Ropa" y un método que imprima la prenda y su precio.

fun_gen <- function(x,...){
  UseMethod("fun_gen",x)
}

fun_gen.Ropa <- function(x){#imprima prenda y precio
  cat(x$prenda,"\n")
  cat(x$precio,"\n")
}

fun_gen(obj)

# ejercicio 1.3 cree un print para la clase "Ropa" que muestre la suma del valor de todas las prendas.

print.Ropa <- function(x){
  cat(sum(x$precio),"\n")
}
print(obj)

# ejercicio 2.1 Cree un objeto de clase "Baraja" cuyos componentes sean número y simbolo. Según la baraja española de 40 cartas https://es.wikipedia.org/wiki/Baraja_espa%C3%B1ola#/media/Archivo:Baraja_de_40_cartas.png

cartas <- list(numero=c(1:7,10:12),simbolo=c("oros","copas","espadas","bastos"))
class(cartas) <- "Baraja"
# ejercicio 2.2 Cree un print que para la clase "Baraja" donde se muestre una descripción breve del objeto y 3 reglas de juego de cualquier variante de la baraja española, puede guiarse de http://www.juntadeandalucia.es/averroes/centros-tic/18700441/myscrapbook/bookcontents.php?page=8&section=7&viewis=&username=

print.Baraja <- function(x){
  cat("Esta es una baraja española de 40 cartas, la cual consiste de los numeros del 1 al 7 y del 10 al 12, repartidos en  4 palos: oros, copas, espadas y bastos","\n")
  cat("Reglas","\n", "1. 3 o mas jugadores", "\n", "2. Intentar deshacerse cuanto antes de todas las cartas que tienen en su poder.", "\n", "3. El jugador que inicia la partidadebe  depositar boca abajo una o varias cartas y dice a sus contrincantes el numero de la baraja al que teoricamente pertenecen dichas cartas y el numero de cartas que deposita ")
}
print(cartas)

# ejercicio 2.3 cree una función generica para la clase "Baraja" que sirva de manera al azar (uniforme sin reemplazo) 9 cartas y se las asigne a un objeto jugador.

cartas_func <- function(x){
  UseMethod("cartas_func",x)
}

cartas_func.Baraja <- function(x){
  for (i in 1:9) {
    jugador <<- sample(paste(x$simbolo,x$numero),i,replace = FALSE, prob = NULL) #el jugador recibira al azar 9 cartas con diferente numero y simbolo sin repetirse
  }
}
cartas_func(cartas)
jugador

# ejercicio 3. Dado lo siguiente, explique y argumente (con evidencia resultante de diferentes comandos) por qué modificar el objeto "bubba" afecta a "louise" y viceversa? Recuerde comentar el código que use como argumento.

NordAmericain <- function(eatsBreakfast = TRUE, myFavorite = "cereal") {
  thisEnv <- environment()
  hasBreakfast <- eatsBreakfast
  favoriteBreakfast <- myFavorite
  me <- list(
    thisEnv = thisEnv,
    getEnv = function() {
      return(get("thisEnv", thisEnv))
    }
  )
  assign('this', me, envir = thisEnv)
  class(me) <- append(class(me), "NordAmericain")
  return(me)
}

bubba <- NordAmericain()
bubba
bubba <- NordAmericain(myFavorite="oatmeal")
bubba

get("favoriteBreakfast", bubba$getEnv())

louise <- bubba
assign("favoriteBreakfast", "toast", louise$getEnv())
get("favoriteBreakfast", louise$getEnv())
get("favoriteBreakfast", bubba$getEnv())
bubba

#explicacion #Bubba y louise son afectadas reciprocamente ya que al asignar bubba en un nuevo objeto con " <- ", tambien asignamos el environment de la funcón  bubba en dicho objeto, como se muestra en el siguiente ejemplo:

loppa <- function(){ #Creo mi funcón loppa que a su vez contiene una función de conteo, que suma 1 cada vez que se ejecuta
  x <- 0
  my_func <- function(){#esta función tiene su propio environment
    x <<- x + 1
    cat("vamos en",x)
  }
  return(my_func)#muestro el valor en el que va el conteo
}

loppa()
prueba_1 <- loppa() #asigno mi función a un nuevo vector, y tendra un nuevo environment
prueba_1()
prueba_2 <- prueba_1#al hacer una copia de prueba 1 en prueba 2, prueba 2 recibe el mismo environmet
prueba_2()#al ejecutar prueba 1 o 2 se mostrara el numero en donde va el conteo + 1
prueba_3 <- loppa()#prueba 3 no es afectado por los anteriores pues recibe un nuevo environment
prueba_3()
environment(prueba_1)#0x9478d68> 
environment(prueba_2)#0x9478d68>  mismo environment
environment(prueba_3)#0x91b91f0>  diferente
##########
# S4 ------------------------------------------------------------------- 

#Cargar paquetes

library(maptools)
library(rgeos)
library(nnclust)
library(shapefiles)


# Ejercicios 1. ¿Que hace el objeto graph_mst? comente cada componente de la función

graph_mst <- function (l) {
  distrib<-l@lines[[1]]@Lines[1][[1]]@coords   #obtiene las coordenadas de los putos que unen lineas
  mst<-mst(l@lines[[1]]@Lines[1][[1]]@coords)  #encuentra el numero minimo de puntos para formar una curva
  plot(l, col="white");title("MST") #grafica las lineas en l
  segments(distrib[mst$from,1], distrib[mst$from,2], distrib[mst$to,1],distrib[mst$to,2],col="red") # dibuja las lineas minimas para formar una curva entre putos
}

# Ejercicios 2. Crear un objeto s4 en donde incluya 30 letras y 30 observaciones aleatorias de una distribucion normal. 

setClass("s4class",
         slots = list(letras = "character", numeros = "numeric"))

ejercicio_2 <- new("s4class",letras = sample(letters, 30, replace = TRUE), numeros = rnorm(30, mean = 0, sd = 1))

# Ejercicios 3. Usando setGeneric() y setMethod(), escribir dos funciones para extraer los datos del objeto creado en el punto 2 y graficarlos.

setGeneric("graficare", function(x) standardGeneric("graficare")) #creo la clase generica para graficar los datos

setGeneric("extraer",function(x) standardGeneric("extraer")) #creo la clase generica para extraer los datos que se graficaran

setMethod("graficare", "s4class", function(x){ #metodo para graficar un histograma de los numeros y las letras obtenias
  par(mfrow=c(1,2))
  hist(x@numeros)
  plot(1:30,pch=x@letras, main = "PLot of letras")
})
setMethod("extraer","s4class", function(x){ #metodo para extraer
  datos_erjercicio_2 <<- x
})
extraer(ejercicio_2)
datos_erjercicio_2
graficare(ejercicio_2)

# Ejercicios 4. Sin ejecutar que pasa en cada una de laa asignaciones y ¿por qué? comente errores de código y la correción que le realizó

rm(list=ls())


setClass("angelito",
         representation(nombre="character",
                        apellido="character",
                        peso=altura="numeric")#error asignacion  =, ambiguedad de argumentos a recibir, debe recibir peso o altura (peso="numeric",altura="numeric")
)



setClass("angelito", #No habra error, sin embargo peso no es un slot valido, peso es creado en el ambiente global 
         representation(nombre="character",
                        apellido="character",
                        peso  <- "numeric", 
                        altura="numeric")
)

setClass("angelito", #no habra error, la clase tendra los 4 slots
         representation(nombre="character",
                        apellido="character",
                        peso="numeric",
                        altura="numeric")
)

yo+  <- new("angelito",#error en el nombre, no aceptara el simbolo "+, no cre seara el objeto
            nombre  <- "Daniel",
            apellido  <- "Miranda")


yo  <- new("angelito", #no habra error, se creara el objeto yo con datos en dos slots
           nombre  = "Daniel",
           apellido  = "Miranda")


yo

setClass("estudiante", #nueva clase que contiene a la case angelito y dos slots
         
         representation(
           identidad="angelito",
           semestre="numeric",
           grado="logical")
)


yoReal  <- new("estudiante") #cre oun objeto de clase estudiante con slots vacios, y as uvez contiene a la clase angelito

yoReal #muestro lo que hay en el objeto

yoReal$angelito#error,no mostara nada ya que la clase no puede ser seleccionada, solo los slots, y deberia usarse "@"

yoReal@estudiante#error, no se puede seleccionar clases, solo slots

yo@nombre #mostrara el nombre Daniel

yoReal@identidad <- yo #a????ra los slots de yo en los slots de identidad, quedara igual

yoReal #muestro el objeto

yo@nombre #mostrara el nombre Daniel

yoReal@nombre #error, primero hay que seleccionar el slot identidad, yoReal@identidad@nombre, pues nombre esta encapsulado

yoReal@identidad@nombre #mostrara el nombre daniel

ls() #mostrara las clases angelito, estudiante y los objetos yo y yoReal


##########
# R6 ------------------------------------------------------------------- 


# Ejercicio 1. Cree una clase de cuenta bancaria R6 que almacene un saldo y le permita depositar y retirar dinero. Cree una subclase que arroje un error si intenta entrar en sobregiro. Cree otra subclase que le permita entrar en sobregiro, pero le cobra una tarifa.

cuenta_Bancaria <- R6Class("cuenta_Bancaria", public =  list(
  saldo = 100000,
  consignar = function(x = 1){ #sumele x al saldo creado anteriormente
    self$saldo <- self$saldo + x
    invisible(self)
  },
  retirar = function(x = 1){
    self$saldo <- self$saldo - x #resto a mi saldo
    invisible(self)
  })  
)

cuenta_Bancaria_sobregiro <- R6Class("cuenta_Bancaria_sobregiro",
                                     inherit = cuenta_Bancaria,
                                     public = list(
                                       retirar = function(x = 1) {#metodo
                                         if(x > 100000)
                                           cat("Error, el valor ", x, " excede el saldo actual", "\n", sep = "") #con esto advierto que que no se puede retirar mas de lo que se tiene de saldo
                                         super$retirar(x = x)
                                       })
)

cuenta_Bancaria_sobregiro_tarifa <- R6Class("cuenta_Bancaria_sobregiro_tarifa",
                                            inherit = cuenta_Bancaria,
                                            public = list(
                                              tarifa = 0,
                                              retirar = function(x = 1) {#metodo
                                                if(x > 100000)
                                                  self$tarifa <- (x - 100000) * 2 #cobro el doble del excedente del valor que entra en sobregiro
                                                cat(x, " excede el saldo actual, entrando en sobregiro", "\n", sep = "")
                                                cat("La tarifa será cobrada el doble del salda excedente", "\n", sep = "")
                                                cat("Tarifa = ",self$tarifa)
                                                super$retirar(x = x)
                                              })
)

papa <- cuenta_Bancaria_sobregiro_tarifa$new()
papa$saldo
papa$retirar(100001)
papa$tarifa
pepesa <- cuenta_Bancaria$new()
pepesa$saldo
pepesa$consignar(20000)
pepesa$saldo
pepesa$retirar(20000)
pepesa$saldo

# Ejercicio 2. Cree una clase (parquedero) R6 que almacene diferentes vehiculos y le permita  diferencar motocicletas y automoviles. Cree una subclase para diferenciar el cobro por tipo de vehiculo y otra por la cantidad de tiempo. Adicione otra clase "dia" y finalemente presente los ingresos mensueales.

parqueadero <- R6Class("parqueadero", public =  list( #ingreso el numero de vehiculos carro o moto que ingresan al parqueadero
  carro = 0,
  moto = 0,
  ingreso_carro = function(x = 1){
    self$carro <- self$carro + x
    invisible(self)
  },
  ingreso_moto = function(x = 1){
    self$moto <- self$moto + x
    invisible(self)
  })  
)

nuevito <- parqueadero$new()
nuevito$ingreso_carro(20)
nuevito$carro
nuevito$ingreso_moto(20)
nuevito$moto

parqueadero_cobro <- R6Class("parquedero_cobro",
                             inherit = parqueadero, #heredo de la clase parqueadero el ingreso de vehiculos
                             public = list(
                               cobro_moto = 0,
                               cobro_carro = 0,
                               carro = nuevito$carro,
                               moto = nuevito$moto,
                               cobrar_moto = function(x = self$moto) { #este es el valor por cada moto que ingresa
                                 self$cobro_moto <- x*1000
                                 invisible(self)
                               },
                               cobrar_carro = function(x = self$carro) { #y este el de los carros
                                 self$cobro_carro <- x*2000
                                 invisible(self)
                               })
)
capa <- parqueadero_cobro$new()
capa$carro
capa$cobrar_carro()
capa$cobro_carro
capa$cobrar_moto()
capa$cobro_moto

parqueadero_tiempo <- R6Class("parqueadero_tiempo",
                              inherit = parqueadero, #heredo de la clase parqueadero
                              public = list(
                                tiempo = 0,
                                cuanto_tiempo = function(x = 1) {
                                  self$tiempo <- x*100 #por cada minuto se cobra 100 pesos sumada a la tarifa base de cobro establecida en parqueadero_cobro
                                  cat("Tiempo en minutos","\n", sep = "")
                                  invisible(self)
                                })
)
tiempito <- parqueadero_tiempo$new()
tiempito$cuanto_tiempo(60) #con esto muestro en que unidad se hara el cobro
tiempito$tiempo #esta sera la tarifa sin tener en cuenta el vehiculo

dia<- R6Class("dia", public =  list( #creo una nueva clase para saber cuanto es el monto ganado en un dia segun la cantidad de vehiculos añadida en las clases y subcalses anteriores y el tiempo que estuvieron
  ganancia_carro = capa$cobro_carro*tiempito$tiempo, #hago el calculo para los carros y luego las motos
  ganancia_moto = capa$cobro_moto*tiempito$tiempo,
  ganancia_dia = 0,
  cuanto_dia = function(x = 1){
    self$ganancia_dia <- self$ganancia_carro+self$ganancia_moto+x #hago la sumatoria de todos los vehiculos al dia
    invisible(self)
  },
  cuanto_mes = function(x = 1){
    x <- self$ganancia_dia*30 #hago el calculo mensual considerando que al mes entran la misma cantidad de vehiculos y el mismo tiempo 
    cat("Las ganancias mensuales fueron ", x, " pesos","\n", sep = "")
  })  
)
ingreso <- dia$new()
ingreso$ganancia_moto #ganancias de solo motos
ingreso$ganancia_carro #ganancias de solo carros
ingreso$cuanto_dia()#reporto las ganancias diarias
ingreso$ganancia_dia
ingreso$cuanto_mes() #reporto las ganancias mensuales