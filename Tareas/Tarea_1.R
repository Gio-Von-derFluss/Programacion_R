#######################################
##### TAREA DE ENTORNOS Y REPASO    ###
#######################################

# REPASO -------------------------------------------------------------------

#Ejercicio 1: Repetir el ejercicio usando un "for" sin "while" pero con la condicion
c <- 0

while(c <= 10) {
  print(c)
  c <- c + 1
}

nuevo_c <- 0

for (i in 1:11) { #conteo de 1 hasta 11 que sumara +1 mientras sea menor o igual a 10
  if (nuevo_c <= 10)
    print(nuevo_c)
  nuevo_c <- nuevo_c+1
  
}

#Ejercicio 2: Extraer los números pares del 1 al 100 

a <- 0

repeat { #repito la suma de 2+a hasta que sea mayor-igual a 100
  a <- a + 2
  print (a)
  if (a >= 100)         
    break
}

c <- 0

for (i in 1:50) { #sumo i con si mismo hasta que sea menor-igual a 100
  if (i <= 100)
    print(i + i)
  next
}

c =0

for (i in 1:50) { #le sumo 2 a c en cada iteracion
  c <- c+2
  print(c)       
}

c <- 0

while (c <= 98) { #hasta que c sea menor-igual a 98, sume 2 a c e imprima
  c <- c + 2
  print (c) 
}

#Ejercicio 3: Modifique el siguiente código para que el loop rellene un vector con todos los resultados

for (i in 1:10){ #imprimo el caracter numero con cada i separado por un espacio
  
  cat("Numero", i, "")
  
}

vector <- (1:10)

for (i in 1:10) { #en un nuevo vector, guardo el caracter numero + i veces, en este caso se debe usar paste ya que cat solo imprime en la consola
  vector[i] <- paste("Numero", i)
}

vector

#Ejercicio 4: cargue el data "cars" y cree una nueva columna que rellene con "muy rapido" si la velocidad del modelo es mayor 15 o rellene con "muy lento" si es menor a 15

data <- cars

for (i in 1:50) { #creo una columna velocidades que sera llenada con muy rapido si la columna speed es mayor de 15 y muy lento si speed es menor o igual a 15
  velocidades <- c("muy lento", "muy rapido")
  velocidades[1] -> data[data$speed <= 15, paste("velocidades")]  
  velocidades[2] -> data[data$speed > 15, paste("velocidades")]    
}

# Cree un dataframe con 1000 filas y 2 columnas, reste la primer columna a la
# segunda y cree una nueva columna con el resultado. Haga este ejercicio usando
# "for" y apply.

df <- as.data.frame(matrix( data = rnorm(2000) , nrow=1000, ncol =2))

for (i in df) { #aplico una resta por columna creando una funcion propia que usare en apply
  my_func <- function(u){  
    u <- df[,2]-df[,1]
  }
  df$resta <- apply(df, 2, FUN = my_func)
  
}

##########
# ENTORNOS -------------------------------------------------------------------

# Responda las siguientes preguntas y comente las operaciones y valores de cada objeto en cada función
# ejerc 1 ---------------------------------------

func_1 <- function(u){  #dado un valor numerico u, multipliquelo por 2 y asigne su resultado al u global, por ultimo regrese el valor de u local que permanece como 1
  
  u <<- 2*u   # es un reasignación local o global? #Global ya que usa <<-
  
  return(u)
  
}

u <- 1

func_1(u) # es un reasignación local o global? #Global, realiza func_1 en el u global y lo modifica


# ejerc 2 ---------------------------------------

func_1 <- function(u){ #dado el valor numerico u, modifique el u local multiplicandolo por 2, la funcion dos no es realizada ya que no se especifica el argumento uu, por ende solo regresa el u local que es igual a 2
  
  u <- 2*u
  
  func_2 <- function(uu){
    u <<- 3*uu    # es un reasignación local o global? local, pero como no indexa nada en el argumento uu, no modifica el de la funcion 1
  }
  
  return(u)
  return(func_2(uu))
  
}
environment(print)

u <- 1

func_1(u) # es un reasignación local o global? #local, solo modifica el u de la primera funcion


# ejerc 3 ---------------------------------------

fun_1 <- function(d, j){  #dados los argumentos d y j que son asignados en la misma funcion, pegue los mismos y separelos por un espacio
  d <- 8
  j <- "esto es local y por defecto"
  paste(d,j, sep = " ")
}

v1 <- 1
v2 <- "esto es global y un argumento"

fun_1()      #porque ignora las variables locales? #las variables solo son creadas localmente y no globalmente


# ejerc 4 ---------------------------------------

fun_1 <- function(d = 8, j = "esto es local y por defecto"){
  paste(d,j, sep = " ")
}

fun_1()      #que valores muestra, explique su respuesta #muestra los valores locales creadas en la funci?n

fun_1(d = v1, j = v2)   #que valores muestra, explique su respuesta  #muestra los valores globales pues fueron utilizados como argumentos de la funcion

