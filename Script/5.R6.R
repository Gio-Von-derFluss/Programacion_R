#R6
#En R6 los metodo pertenen a los objetos, en S4 a funciones genericas

library(R6)

#R6 utiliza classname que mejora los posibles mensajes de error. Al igual de S3, utiliza objetos genericos
#Tambien es posible mantener objetos de manera publica o privada

.S4methods

#r6 especifica algo publico o privado, los elementos(lista de metodos o funciones)

Accumulator <- R6Class("Accumulator", list( #definimos clase con r6 class
  sum = 0,
  add = function(x = 1) {#metodo
    self$sum <- self$sum + x 
    invisible(self)#se lo aplico a mis metodos, self llama a sum, aplico add a sum
    #self toma lo que esta dentro de r6, se hace dentro de accumulator
  })
)

Accumulator


#~ construir un nuevo objeto de la clase mediante new(). En R6, los métodos pertenecen a los objetos, por lo que se utiliza $para acceder a new():


x <- Accumulator$new() ##nuevo objeto dentro dle la clase R6$

x
class(Accumulator)
str(Accumulator)
ls()
#~ #~  mediante $ se accede a los campos.
x

x$add(10)   ##mi x ahora es 4, que lo asigna a x
x$sum

#~ en esta clase, los campos y métodos son públicos, lo que significa que puede obtener o establecer el valor de cualquier campo. 

#~  "Metodo de encadenamiento"

#~ $add()se llama principalmente por su efecto secundario de la actualizacion $sum

Accumulator <- R6Class("Accumulator", list( #serie de argumentos contenidos en una lista
  sum = 0,
  add = function(x = 1) {
    self$sum <- self$sum + x 
    invisible(self)
  })
)



#~ Los métodos de efectos secundarios R6 siempre deben volver self invisiblemente. Esto devuelve el objeto "actual" y permite encadenar varias llamadas a métodos:


x


x$add(10)#suma 10 a sum

x

x$add(10)$add(10) #suma 20 a sum

x
x$add(10)$add(10)$sum #es posible encadenar sumas a nuestro x
#

x


#~  $initialize() anula el comportamiento predeterminado de $new()

Person <- R6Class("Person", list(
  name = NULL,
  age = NA,
  initialize = function(name, age = NA) {
    stopifnot(is.character(name), length(name) == 1)#si name no es un caracter, detengase
    stopifnot(is.numeric(age), length(age) == 1)
    
    self$name <- name
    self$age <- age
  }
))

hadley <- Person$new("Hadley", age = "thirty-eight") #age debe ser numerico, no caracter


hadley <- Person$new("Hadley", age = 38)

Person <- R6Class("Person", list( #cambio el comportamiento de print para que me muestre nombre y edad
  name = NULL,
  age = NA,
  initialize = function(name, age = NA) { #no hay restriccion en la forma como debe recibir las varbiales
    self$name <- name
    self$age <- age
  },
  print = function(...) { #ahora debera imprimir de la siguiente forma
    cat("Person: \n")
    cat("  Name: ", self$name, "\n", sep = "")
    cat("  Age:  ", self$age, "\n", sep = "")
    invisible(self) 
  }
))

hadley2 <- Person$new("Hadley")
hadley2
hadley2$print#llama el metodo, porque es del metodo en person
hadley2$print()

Accumulator <- R6Class("Accumulator") # creamos la clase y luego los metodos

Accumulator$set("public", "sum", 0)
Accumulator$set("public", "add", function(x = 1) {
  self$sum <- self$sum + x 
  invisible(self)
})

#es posible modificar los campos de los metodos. lo que ayuda a modificar clases con multiples metodos

#~ #~  herencia

# heredar el comportamiento de otra clase con el argumento inherit

AccumulatorChatty <- R6Class("AccumulatorChatty", 
                             inherit = Accumulator,#heredo en acumulatorchatty lo que hay en acumulator(antes era addcon $)
                             public = list(
                               add = function(x = 1) {#metodo
                                 cat("Adding ", x, "\n", sep = "")
                                 super$add(x = x)#ya no self, self$ metodo publico, super$ metodo publico del padre osea acumulator
                               }#heredar de dos padres, un padre no hereda del hijo,llamar de privado con super dot o doble dot
                             )
)


x2 <- AccumulatorChatty$new()

x2

x2$add(10)#aplica el add de cumulatorchatty con el metodo de su padre

x2$add(10)$add(1)$sum#muestra lo que estoy acumulando

x2$sum

class(x2)
names(x2)

#sintaxis cambia en s4 o r6(argumento asigados con $, lista de argumento)
#r6 hay que llamar paquete, y a diferencia de s4, todo se puede hacer al mismo tiempo, osea asignar clase,objeto y metodo, y se puede heredar clase y metodo con inherid y superself

#~ Cada objeto R6 tiene una clase S3 que refleja su jerarquia de clases R6. Esto significa que la forma más fácil de determinar la clase (y todas las clases de las que hereda) es usar class():

hadley
class(hadley)

names(hadley)

hadley2
class(hadley2)

names(hadley2)


#~ ejercicios

#1
#Defina a fabrica(factory) para microondas(a microwave oven).
#llame una clase R6Class.
#El nombre de la clase debe ser "MicrowaveOven".
#Determine un elemento que se llame private y que sea una list (asi como puede tener elementos publicos, se pueden tener elementos privados )
#Esta listdebe contener un unico campo, que se llame  power_rating_watts y que tenga un valor de  800.

# Defina microwave_oven_factory

microwave_oven_factory <- R6Class(
  "MicrowaveOven",
  private = list(
    power_rating_watts = 800
  )
)
microwave_oven_factory

# Crear un nuevo objeto MicrowaveOven  y asignelo a la variable microwave_oven

MicrowaveOven <- microwave_oven_factory$new()
  
#~ Tarea
  
#~ 1)Cree una clase de cuenta bancaria R6 que almacene un saldo y le permita depositar y retirar dinero. Cree una subclase que arroje un error si intenta entrar en sobregiro. Cree otra subclase que le permita entrar en sobregiro, pero le cobra una tarifa.

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
                                                cat("La tarifa ser� cobrada el doble del salda excedente", "\n", sep = "")
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

#~ 2) Cree una clase (parquedero) R6 que almacene diferentes vehiculos y le permita  diferencar motocicletas y automoviles. Cree una subclase para diferenciar el cobro por tipo de vehiculo y otra por la cantidad de tiempo. Adicione otra clase "dia" y finalemente presente los ingresos mensueales.

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

dia<- R6Class("dia", public =  list( #creo una nueva clase para saber cuanto es el monto ganado en un dia segun la cantidad de vehiculos a�adida en las clases y subcalses anteriores y el tiempo que estuvieron
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
