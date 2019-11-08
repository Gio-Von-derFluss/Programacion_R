#Un entorno es un espacio donde se alojan los objetos, y es lo primero que se crea al iniciar sesion en R

environment() #muestro el ambiente, es global ya que no recibe argumento

x <- 0.001 #asigno el valor a x
x
x <- "esto es x" #asigno el caracter a x
x
#x cambia ya que es reasignado dentro el mismo entorno

ls() #listo los objetos del ambiente global

# 1.Funciones
#las funciones sob objetos que realizan acciones dentro de su propio ambiente, algunas veces requieren otros objetos

obj_1 <- 1 #asigno 1 a obj_1
obj_2 <- "a" #asigno el caracter "a" a obj_2

c <- function() { #hago una fucnión que crea x
  x <- 0 #
}

ls() #solo estaran los objetos creados en el ambiente global

c() #necesita un argumento para ejecutarse 

str(c) #con str puedo mirar los artibutos de la funcion y su entono propio

environment(c)

# 2.Variables globales
#son las variables en el ambiente mas "externo", son tambien parentales

global_ambiente <- 10 #vector en ambiente global

funcion_1 <- function() { #segundo entorno
  ambiente_1 <- global_ambiente + 1
  funcion_2 <- function(){ #tercer entorno
    ambiente_2 <- ambiente_1 + 1
    print(ls()) # muestro los objetos de este entorno (3)
    print(ambiente_2)
    print(environment())
  }
  print(ls()) #muestro los objetos del entorno en este nivel (2)
  print(ambiente_1)
  print(environment())
  funcion_2()
}

funcion_1() #mostrara primero lo creado en la primera funcion y luego en la segunda

#Los parentales no pueden usar entornos de los hijos

# 3.Variables locales
#Son especificos de objetos y sus propios objetos son invisibles

a <- 20 #esto es global

funcion_1 <- function(){ #objeto global con objeto local a y funcion_"
  a <- 10 
  print(a)
  funcion_2 <- function(){ #objeto local con objeto propio local a
    a <- "hello" 
    return(a)
  }
  funcion_2()
}

funcion_1() #imprime los objetos creados en los ambientes locales

#a es global y no se modifica


# 4.Retornar valores

#<<- si es usado, cambia un objeto global desde un ambiente local



a <- 20 #esto es global

funcion_1 <- function(){ #función que reasigna 10 al a global e imprime
  a <<- 10 
  print(a)
  funcion_2 <- function(){ #reasigna caracter al a global e imprime
    a <<- "hello" 
    return(a)
  }
  funcion_2()
}

funcion_1() #reasigna el a global y imprime los valores de cada funcion

a #ahora es el producto de la funcion 

#Ejercicio

w <-1

my_func <- function(y,fun) {
  d <- 8
  print(environment(fun))   #fun es una funcion
  return(fun(d,y))}

my_func2 <- function(dee,yyy){
  return(dee*(w+yyy))}

## Antes de ejecutar: ¿cuál será el env? será el de f? R//El global

my_func(3,my_func2) #el resultado total sera 32, en my_func creo el objeto d que en my_func2 corresponde a dee, y yyy que corresponde a 3. w se crea en el ambiente global

showframe <- function(upn) {
  if (upn < 0) {
    env <- .GlobalEnv #. algo es oculto y no visible 
  } else {
    env <- parent.frame(n=upn+1) ###asigna ambiente del vector
  }#lista de nombre de las variables
  vars <- ls(envir=env)
  for (vr in vars) { #imprime el valor de cada variable
    vrg <- get(vr,envir=env)
    if (!is.function(vrg)) { #si no es una funcion imprima la varible y su valor en una nueva linea
      cat(vr,":\n",sep="")
      print(vrg)
    }
  }
}

environment(showframe)

showframe(-1)

showframe(0)

showframe(2)

#En cualquier caso imrpime las varibales del ambiente global ya que el if y el else compian este ambiente

ls()

g <- function(aa) {
  b <- 2
  showframe(0)
  showframe(1)
  aab <- my_func2(aa+b)
  return(aab)
}

g()

g(1) #no se ejecutara pues faltan argumentos en my_func2

my_func()

my_func(1) #falta argumento fun

m <- rbind(1:3,20:22) #creo una matriz

m

get(m) #el nombre del vector debe ser como si fuera un caracter

get("m") #obtiene los valores del vector m

showframe(-1)

two <- function(u) { #crea u global multiplicando 2 por el argumento u, z se crea localmente
  u <<- 2*u
  z <- 2*z
}

x <- 1
z <- 3

u

two(x) #aca se crea u

u

x <- 6699
x

f <- function() { #crea un x local
  x <- 6
  inc <- function() { #asigna x+1 al x parental que es local e imprime el numero mas algo pasa
    x <<- x + 1; return(x)}
  inc()
  cat("numero",x,"algo pasa")
  return(x)
}

ls()
f() #esto no cambia el x global

x

rm(x)

x <- 1 #asignacion global
 
z <- 1

two <- function(u) { #asigna al u global la multiplicacion por x
  assign("u",2*u,pos=.GlobalEnv)
  z <- 2*z
}

ls()
#rm(u)
two(x) #aca se cambia u

x

u 

#bad blood Closures

counter <- function () { #adiciona 1 cada vez que se llama
  ctr <- 0
  f <- function() {
    ctr <<- ctr + 1
    cat("this count currently has value",ctr,"\n")
  }
  return(f)
}

counter
#el copiado tiene su propio ambiente, c1,c2 y c3 son cosas diferentes que hacen lo mismo
c1 <- counter()

c2 <- counter()

c1

c2

ctr

c3 <- counter()

c1()

c1()

c2()

c2()

c3()


c3()


ctr

## y donde estan ctr (en plural)
#Los ctr estan en el el ambiente propio de cada counter