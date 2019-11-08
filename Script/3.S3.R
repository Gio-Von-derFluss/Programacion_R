#S3

rm(list = ls())

install.packages("sloop")#Instalar paquete
library(sloop)#Cargar paquete

#s3 lenguaje s version 3, la mayoria de paquetes cranc y paquetes estadisticos son s3
#

n <- 1:10
attr(mtcars,"class")

otype(n) #tipo base

#s3= lista con atributo clase

ejemplo_S3 <- list()

ejemplo_S3$datos <- c(1,2,3)

ejemplo_S3$conteo <- 5

str(ejemplo_S3)

typeof(ejemplo_S3)#reporta lista

class(ejemplo_S3)# tambien tipo lista

otype(ejemplo_S3)#reporta base, aun no le asignamos clase s3 porque es el tipo base propio
#

# Establecemos la clase
class(ejemplo_S3)  <- "myClass"  #clase es un atributo que tiene un objeto

class(ejemplo_S3)  #s3 y s4 son tipos de objeto

otype(ejemplo_S3)  #es s3 cuando se le asigna clase


# Podemos crear el objeto y asignar la clase en un solo paso

# ejemplo_S3 <- structure(list(), class = "my_class")


# Otro ejemplo  

x <- c(1,2,3)

y <- c(1,3,8)

lmout <- lm(y ~ x)


str(lmout) #lista de atributos

typeof(lmout) #la funcion tiene su propia clase, aunque sigue siendo un objeto S3,
#la función le da la clase al objeto

class(lmout)

otype(lmout)


## Funciones genéricas  

# Todas las funciones genéricas tienen la misma estructura: una llamada a UseMethod que especifica el nombre genérico y el objeto para despachar. 
##metodo funcion especifica para la clase metodo
## estas son las funciones genericas
print#

summary#

plot#entorno basico de R, latice

# Creemos una función genérica
hola <- function(x,..){
  UseMethod("hola",x)
}
hola
## Métodos

#La funcion generica redirige el llamado al método adecuado

class(x)
print(x)

class(lmout)
print(lmout)  #cada clase diferente usa una forma de imprimir diferente

# Revisemos todos los métodos de la función print
# Los asteriscos indican métodos no visibles.
methods(print)#funcion.clase
#metodo forma de hacer algo, la forma como hace la acción, depende de la clase
#depende el metodo

# Los nombres de los métodos tienen el formato generic_name.class_name (). Así es como R es capaz de determinar qué método llamar dependiendo de la clase.


class(ejemplo_S3)

# qué imprime ? =el nombre de la clase
print(ejemplo_S3)#nos inventamos la clase, no sabe como imprimirla y la imprime tipo base
#osea lista


typeof(ejemplo_S3)


# creemos un método para print de la clase
print.myClass <- function(x){ #creo un print para my clase
  cat (x$datos,"\n","estos son mis datos")
}

print.myClass(ejemplo_S3)#imprimo con mi print, solo print es una lista
#no todos los print serviran, usara el más parecido, los atributos son diferentes

# Ahora usemos la función "hola" en este objeto
# ¿qué sucede ?#error por el metodo
hola(ejemplo_S3)

#funcion generica=no realiza accion, solo llama al metodo, que metodo usará?, definir el
#metodo

# Creemos un método de la función para la clase "myClass"
hola.myClass <- function(x,..){
  cat("me amo",x$conteo, "\n")#el conteo no sirve porqe es una lista, no matrix,use $
}

# Cuál es la salida?
hola.myClass(ejemplo_S3) #Lo que tenga el metodo de my Class
hola(ejemplo_S3)

## Repaso de objeto S3

# Cada componente de la lista es una variable

j <- list(name="Joe", salary=55000, union=T)

# Definimos el atributo clase 
class(j) <- "employee" #creamos una nueva clase
class(j)

# Imprimamos el objeto j ¿qué estructura tiene?
print(j) #estructura de lista con la que viene j

# Creemos el método "print" para la clase "employee" 
print.employee <- function(wrkr) { #cuando imprima una clase employee debera imprimir los siguientes cat
  cat(wrkr$name,"\n")
  cat("salary",wrkr$salary,"\n")
  cat("union member",wrkr$union,"\n")
}

# Ahora, cualquier objeto de la clase "employee" sera impreso con el método print.employee
print(j)


## Herencia 

# Es cuando formamos nuevas clases como versiones especializadas de las antiguas

# La nueva clase hereda los métodos de la clase antigua

# Si la nueva clase no tiene métodos entonces toma los métodos la clase anterior


#creemos un objeto, paso a paso y definimos su clase "cosa"

test01  <- list()

test01$datos  <-  c(1,2,3)

test01$conteo  <-  5

test01$letras  <-  "This is ok"

class(test01)  <- "cosa"

class(test01)

str(test01)

typeof(test01)


# creamos el metodo para la clase
print.cosa <- function(x, ...){
  "1_ Si!!!!!!!!!!!!, lo logramos!!"
}

print(test01) #imprime el metodo para nuestra clase

# la clase tambien puede ser un conjunto de caracteres
class(test01) <- c("cosa1" ,"cosa", "cosa2", "CCc")#esto sería la jerarquia
##toma el primero, si no, toma uno definido
#para las siguientes clases, si los 3 tienen metodo usa el del primero

class(test01)

# ¿ Qué debe pasar?
print(test01)#usa el metodo de cosa porque ya venia con el, lo heredo

# creemos un método para la siguiente clase del conjunto
print.cosa1 <- function(x, ...){
  "2_ ni idea si lo logramos!!"
}

# ¿Qué pasa?
print(test01)#sigue como cosa

class(test01)


# y si lo creamos asi ?
print.cosa.cosa1 <- function(x, ...){
  "3_ ni idea si esta vez si lo logramos!!"
}

print(test01)


rm(print.cosa) #sale cosa 1, los objetos S3 tienen herencia y "jerarquia"


print(test01)


#################### actividades ############################################################################### 
# ejercicio 

# Cree un objeto de clase "Ropa" cuyos componentes sean precio y prenda
obj <- list()
obj$precio <- c(1:3)
obj$prenda <- c("camisa","patalon","cucos")
class(obj) <- "Ropa"

# cree  una función generica para la clase y un método que imprima la prenda y su precio

fun_gen <- function(x,...){
  UseMethod("fun_gen",x)
}

fun_gen.Ropa <- function(x){
  cat(x$prenda,"\n")
  cat(x$precio,"\n")
}

fun_gen(obj)

# cree un print para la clase que muestre la suma del valor de todas las prendas

print.Ropa <- function(x){
  cat(sum(x$precio),"\n")
}
print(obj)

NorthAmerican <- function(eatsBreakfast=TRUE,myFavorite="cereal") #objeto con funcion que recibe dos argumentos, en este caso ya los tiene por defecto
{
  me <- list( #contiene lista de ambos argumentos
    hasBreakfast = eatsBreakfast,
    favoriteBreakfast = myFavorite
  )
  class(me) <- append(class(me),"NorthAmerican") #asigno la clase
  return(me)
}

bubba <- NorthAmerican()

bubba #crea la lista y le agrega una clase, ahora tiene dos

louise <- NorthAmerican(eatsBreakfast=TRUE,myFavorite="fried eggs")

louise #cambio a huevos fritos la comida favorita

NordAmericain <- function(eatsBreakfast=TRUE,myFavorite="cereal")
{
  thisEnv <- environment() #obtengo este ambiente
  hasBreakfast <- eatsBreakfast
  favoriteBreakfast <- myFavorite
  me <- list( #lista de este ambiente
    thisEnv = thisEnv,

    getEnv = function()
    {
      return(get("thisEnv",thisEnv))
    }
    
  )
  
  assign('this',me,envir=thisEnv) #defino el ambiente de me

  class(me) <- append(class(me),"NordAmericain")#nombre de esta clase
  return(me)
}

environment()

## ejem

bubba <- NordAmericain()

bubba # de nuevo dos clases

get("hasBreakfast",bubba$getEnv())

get("favoriteBreakfast",bubba$getEnv())
#obtengo lo que hay en bubba con get

bubba <- NordAmericain(myFavorite="oatmeal")

bubba

get("favoriteBreakfast",bubba$getEnv())

louise <- bubba #asigno con <- a luise lo que hay en bubba

assign("favoriteBreakfast","toast",louise$getEnv())

get("favoriteBreakfast",louise$getEnv())

get("favoriteBreakfast",bubba$getEnv())

#Bubba y louise son afectadas reciprocamente ya que al asignar bubba en un nuevo objeto con " <- ", tambien asignamos el environment de la funcón  bubba en dicho objeto, como se muestra en el siguiente ejemplo:

#creo el metodo para cambiar breakfast
setHasBreakfast <- function(elObjeto, newValue)
{
  print("Calling the base setHasBreakfast function")
  UseMethod("setHasBreakfast",elObjeto) #especifico para el metodo del objeto
  print("Note this is not executed!")
}

#pongo un objeto, le pongo un nuevo valor y lo devuelvo
#objeto por defectgo digame esto(.default(que no se haga)), cuando no, haga esto (el print definido y la accion)
setHasBreakfast.default <- function(elObjeto, newValue)
{
  print("You screwed up. I do not know how to handle this object.")
  return(elObjeto)
}

#metodo especifico para la clase NorthAmerican
setHasBreakfast.NorthAmerican <- function(elObjeto, newValue)
{
  print("In setHasBreakfast.NorthAmerican and setting the value")
  elObjeto$hasBreakfast <- newValue
  return(elObjeto)
}



bubba <- NorthAmerican()

bubba$hasBreakfast

bubba <- setHasBreakfast(bubba,FALSE)# se realiza el cambio de hasBreakfast

bubba$hasBreakfast

bubba <- setHasBreakfast(bubba,"No type checking sucker!")
#cambia de nuevo el valor pues se utiliza el metodo para cla clase correcta
bubba$hasBreakfast

#manejo error
#control de la clase, pero aun no del argumento

someNumbers <- 1:4

someNumbers

someNumbers <- setHasBreakfast(someNumbers,"what?")
#esta clase no corresponde al metodo especifico, por lo tanto no se realiza y arroja el print del error

someNumbers


getHasBreakfast <- function(elObjeto) #defino el metodo para get
{
  print("Calling the base getHasBreakfast function")
  UseMethod("getHasBreakfast",elObjeto)
  print("Note this is not executed!")
}

getHasBreakfast.default <- function(elObjeto) #defino el metodo cuando no corresponde a la clase del objetvo
{
  print("You screwed up. I do not know how to handle this object.")
  return(NULL)
}


getHasBreakfast.NorthAmerican <- function(elObjeto)#defino el metodo para la clase en especifico (NorthAmerican)
{
  print("In getHasBreakfast.NorthAmerican and returning the value")
  return(elObjeto$hasBreakfast)
}



bubba <- NorthAmerican()
bubba <- setHasBreakfast(bubba,"No type checking sucker!")

result <- getHasBreakfast(bubba) #el get corresponde a su clase por lo tanto se guarda en resutl hasbreakfast

result
