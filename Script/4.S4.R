#S4

#Sistema que surge de la reescitura de los objetos s3, es mas riguroso debido a su mayor nivel de encapsulacion, adecuado para construir sistemas que evolucion
#listas,ambientes ,objetos orientados hacia la programación, cuando es buena idea?
#Contruir herramientas,etc,
#S4--->reescritura de objetos s3,mas garantias o riguroso(definimos clase y objeto), cada objeto esta escrito de diferentes formas,s3=clase,metodo,genericos
#hay que pensar muy bien su diseño

setClass("Car",representation=representation(
  price = "numeric",
  numberDoors="numeric",
  typeEngine="character",
  mileage="numeric"
))

ls()

#primero definimos la clase, y posterior el objeto
aCar <- new("Car",price=20000,numberDoors=4,typeEngine="V6",mileage=143)


ls()
class(aCar) #clase definida como Car
typeof(aCar) #objeto s4
str(aCar) #para obtener los componentes de un objeto s4, los hacemos llamando sus slots con @ 

aCar@price

slot(aCar,"price")

#Aparte de tener una clase formal deficnial, los objetos s4 tienen funciones axuiliares para deficinir metodos especificos y metodos genericos, que a su vez eligen el metodo basado en la clase 

#### Instalar y cargar el paquete stats4 y pryr 

## S4 se implementa en el paquete de m?todos b?sicos, que siempre se instala con R.

#install.packages("stats4") #Instalar paquete
library(stats4)#Cargar paquete

#install.packages("pryr")#Instalar paquete
library(pryr)#Cargar paquete

#install.packages("sloop")#Instalar paquete
library(sloop)#Cargar paquete

## sloop proporciona ayudas como  sloop :: otype (), esto facilita descubrir el sistema OOP (object-oriented programming) utilizado por un objeto. 

##############################################


### Las ideas subyacentes de los objetos s4 son similares a S3, sin embargo, la implementaci?n es mucho m?s estricta y hace uso de funciones especializadas para crear clases: setClass (), gen?ricos: setGeneric () y m?todos: setMethod ().


### setClass: 
#### Para definir una clase S4 llame a setClass () con el nombre de la clase y una definición de sus slots.

setClass("Person",# creo clases que tiene estos slots especificos
         slots = list(name = "character", age = "numeric"))
setClass("Employee",
         slots = list(boss = "Person"),
         contains = "Person")

ls()

### para construir objetos dentro de la clase ya definida use new() con el nombre de la clase y valores para los slots.
alice <- new("Person", name = "Alice", age = 40) #podemos ir creando nuevos objetos especificando los valores de cada slot
john <- new("Employee", name = "John", age = 20, boss = alice)
juan <- new("Employee", name = "Juan", age = 21)

juan


class(juan)
class(alice) 

newPerson <- c(alice,  john) #concateno dos objetos
str(newPerson) #sera una lista, es el objeto base resultante de concatenar
ls()
class(newPerson) #no sera objeto s4 ya que no fue creado con new ()

otype(juan) #s4 creado con new()
otype(newPerson)

## Un importante componente de S4 son los slots @ (ranura en espa?ol). 

alice@age

#> [1] 40
newPerson
newPerson@age # es una lista, no un s4

slot(john, "boss")


newPerson[1][[1]]@name #para obtener un slot dento de una lista
john@boss@name[1]

class(john)
otype(john)

## Ejemplo 2

setClass("employee",
         representation(
           name="character",
           salary="numeric",
           union="logical")
)

#####

Daniel <- new("employee",name="",salary=)


#Que hace falta? ##salario en modo numerico

## ejercicio 
### Al objeto Daniel, definir un nuevo empleado con nombre Daniel y asignarle un salario de 55000 

ls()
Daniel <- new("employee",name="Daniel",salary=55000)

### EL empleado Joe tiene un salario igual que Daniel 

joe <- new("employee",name="Joe",salary=55000)
#esta es la forma en la que se crean los objetos s4

#####

joe@salary

slot(joe,"salary")

show(joe)

ls()

##Ejemplo 3

setClass("RangedNumeric", #creo una nueva clase con dos slots
         contains = "numeric",
         slots = list(min = "numeric", max = "numeric"))

rn <- new("RangedNumeric", 1:10, min = 1, max = 10)

class(rn)
otype(rn)
rn@min
#> [1] 1
rn@.Data # es posible debido al argumento contains
juan@.Data

#setGeneric y setMethod
### setGeneric realiza el envío del método 
setGeneric("union") #ningun metodo definido

##setMethod: define el m?todo de lo que pretende hacer (funciones)
setMethod("union", #defino el metodo de union
          c(x = "data.frame", y = "data.frame"),
          function(x, y) {
            unique(rbind(x, y))
          }
)

### Crear un empleado con su nonbre y que su salario sea 55000

otro_empleado<- new("employee",name = "otro empleado",salary=55000) 

show(otro_empleado)

### que hace show? #muestra los valores del objeto

setMethod("show", "employee",
          function(object) { #defino el metodo de la funcion show para mi clase employee
            inorout <- ifelse(object@union,"is","is not")#condicion si existe el slot union, en este caso no aplica
            cat(object@name,"has a salary of",object@salary,
                "and",inorout, "in the union", "\n")
          }
)


show(otro_empleado) #imprime con el show para nuestra clase



### Ejemplo 4 

setGeneric("myGeneric", function(x) { #defino funcion sin metodo
  standardGeneric("myGeneric")
})

class(myGeneric)
otype(myGeneric)
x=1
myGeneric() #no hay metodo en este objeto
myGeneric("show")
################################################
### ejercicio 2
####################################

#parte 1
setClass("Person", 
         slots = c(
           name = "character", 
           age = "numeric"
         )
)

#### crear un persona llamada john Smith, sin embargo no se conoce la edad de jhon
###como asignaria NA a age si es numeric ???

john <- new("Person",name="john smith")

#no se conoce su nombre, por lo tanto, no se le asigna ningún valor

john@name

slot(john, "age")


#####tarea????

#1 extaer edades de newperson
#2 set method

## Crear un setter y getter para el slot (age) creando genericos con setGeneric()


setGeneric("age", function(x) standardGeneric("age")) #creo funcion generica age
setGeneric("age<-", function(x, value) standardGeneric("age<-"))#creo la funcion generica de asignacion para la funcion age creada atras

## Despues definir metodos con setMethod():

setMethod("age", "Person", function(x) x@age)
setMethod("age<-", "Person", function(x, value) {
  x@age <- value
  x
})
#metodos para las funciones genericas
john

john@age <- 12

john


#parte 2
setClass("Person", #nueva clase con dos slots
         slots = c(
           name = "character", 
           age = "numeric"
         ), 
         prototype = list( #prueba la validez de los argumentos
           name = NA_character_,
           age = NA_real_
         )
)

me <- new("Person", name = "Hadley")
str(me)


#########################################################
###Ejercicio 2

######################################################
## Evaluates the effect of Ramer - Douglas - Peucker on simpliying tracks  
##
## DRME nov 04 - 2012
## dmiranda(at)uis(dot)edu(dot)co

########Cargar paquetes
## libraries
##

library(maptools)
library(rgeos)
library(nnclust)
library(shapefiles)

devtools::install_github("cran/nnclust") #Instalar el paquete emoGG

## functions
##¿Que hace el objeto graph_mst?

graph_mst <- function (l) {
  distrib<-l@lines[[1]]@Lines[1][[1]]@coords   #obtiene las coordenadas de los putos que unen lineas
  mst<-mst(l@lines[[1]]@Lines[1][[1]]@coords)  #encuentra el numero minimo de puntos para formar una curva
  plot(l, col="white");title("MST") #grafica las lineas en l
  segments(distrib[mst$from,1], distrib[mst$from,2], distrib[mst$to,1],distrib[mst$to,2],col="red") # dibuja las lineas minimas para formar una curva entre putos
}

######################################
############################ Actividades #############################################

# 1.Crear un objeto s4 en donde incluya 30 letras y 30 observaciones aleatorias de una distribucion normal. 

setClass("s4class",
         slots = list(letras = "character", numeros = "numeric"))

ejercicio_2 <- new("s4class",letras = sample(letters, 30, replace = TRUE), numeros = rnorm(30, mean = 0, sd = 1))

# 2.Usando setGeneric() y setMethod(),escribir dos funciones para extraer los datos del objeto creado en el punto 1 y graficarlos.

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