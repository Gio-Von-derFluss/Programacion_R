a <- 2
b <- 3
c <- 4

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
  aab <- h(aa+b)
  return(aab)
}

g()

g(1)

f()

f(1)

m <- rbind(1:3,20:22)

m

get(m)

get("m")


showframe(-1)


#

## revisar <<

two <- function(u) {
  
  u <<- 2*u
  
  z <- 2*z
  
}

x <- 1
z <- 3

u

two(x)

## ??

u

x <- 6699
x

f <- function() {
  x <- 6
  
  inc <- function() {x <<- x + 1; return(x)}
  
  inc()
  
  cat("numero",x,"algo pasa")
  
  return(x)
  
  
}

ls()
f()

x

rm(x)

# x <- 1
-
  
  
  ## revisar assign
  
  z <- 1

two <- function(u) {
  assign("u",2*u,pos=.GlobalEnv)
  z <- 2*z
}
ls()
#rm(u)
two(x)

x

u




### bad blood Closures

counter <- function () {
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
-
  
  69

c3()


c3()




## y donde estan ctr (en plural)