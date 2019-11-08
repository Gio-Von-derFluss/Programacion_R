#1.if/else

c <- (3) #asigno 3 a c

if ( c <= 2) { #Si c es mayor o igual a 2 imprima la condición de, de lo contrario se imprimira la condición de else
  print ("Mayor/igual a dos")
} else {
  print ("Menor/igual a dos")
}

c <- (6) #asignar 6 a c

if (c <= 2) { #Si se cumple la condicion de if sera mostrado su print, tambien hay 2 condiciones intermedias y si ninguna se cumple se ejecutara el print de else
  print ("Valor numérico menor/igual a dos")
} else if (2 < c & c <= 5) { 
  print("Valor numerico entre 3 y 5")
} else if (5 < c & c < 8) { 
  print ("Valor numérico entre 6 y 7")
} else { 
  print ("Mayor/igual a 8 ")
}

#2. for/while

for (i in 1:10) { #concatena e imprime "numero" acompañado del bucle realizado por "for" separado por un espacio
   cat("Número", i, " ")        
}

a <- 1 #asigna 1 a a
b <- 2 #asigna 2 a b
for (i in 1:5) { #suma a,b y el numero del loop de "for"
  print (a+b+i)
}

c <- 0 #asigna 0 a c

while (c <= 10) { #Hasta que c sea menor o igual a 10 imprimo c, y le voy sumando 1 en cada iteracion, c sera 11
  print (c)  #si elimino print, no se mostara desde 0     
  c <- c + 1  
}
c

#Ejercicio con for
c <- 0
for (i in 1:11) { #imrpimir c e ir sumando 1 en cada iteracion hasta que sea menor o igual a 11
  print (c)
  c <- c+1                 
}
c

# 3. repeat/break/next

a <- 0 #asigno 0 a a

repeat { #repite a+1 hasta que llegue a 10 y lo imprime      
  a <- a + 1
  print (a)
  if (a >= 10) #funciona como un while
    break
}

for (i in 1: 100) { #si i es menor a 10, no lo imprima
  if (i > 10)
    print(i + 2) #suma 2 en cada i
  next
  print (i)         
}

#Ejercicio: extraer los numeros pares del 1 al 100
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

# 4. Funciones
#grupo de instrucciones que opera en un objeto

Celsius_a_fahrenheit <- function (temp_C) { #funcion que recibe temperatura en celsius, la convierte en fahrenheit y la devuelve
  temp_F <- (temp_C * 1.8) + 32
  return (temp_F)
}
Celsius_a_fahrenheit(30)

Celsius_a_kelvin <- function (temp_C) { #funcion que recibe temperatura en celsius, la convierte en kelvin y la devuelve
  temp_k <- ( temp_C + 273.15) #por que no puedo ver temp_F si lo llamo?
  return (temp_k)
}

fahrenheit_a_celsius <- function (temp_F) {
  temp_C <- (temp_F - 32)*5/9 #funcion que recibe temperatura en fahrenheit, la convierte en celsius y la devuelve
  return (temp_C)
}
fahrenheit_a_celsius(40)

huevo_cocido <- function (temperatura){ #funcion que recibe temperatura de coccion de un huevo y te diceen cuanto tiempo estara
  tiempo <- 0
  while (temperatura < 100 && tiempo < 100) {
    tiempo <- tiempo + 1
    temperatura <- temperatura + 1
  }
  print ( paste ("Su huevo estara listo en", tiempo, "segundos o", tiempo/60, "minutos", sep = " "))
}
huevo_cocido(20)
#tarea
#poner condiciones para saber si está quemado, está crudo, está cocido,crudo o cocido,(3)
#hacer una funcion que reciba 2 argumentos (time,t), que reporte cuando el huevo esté crudo
#cocido o quemado
condicion_huevo <- function (temperatura,tiempo){ #recibe temperatua y tiempo, dependiento de las condiciones te dira el estado en el que se encuentra el huevo
  if (temperatura <= 49 & tiempo <= 60) {
    print("su huevo esta crudo")
  } else if (temperatura >= 50 & temperatura < 70 & tiempo >= 3 & tiempo <=5) { 
    print("su huevo esta cocido")
  } else   { 
    print("Su huevo esta quemao")
  }
}
condicion_huevo(60,3)

# 5.apply/lapply/sapply

m <- matrix(data = (1: 10), nrow=5, ncol  = 2)

apply(m,c(1,2),mean) #aplico la media a las filas y columnas de la matriz m

lm <- as.list(m)
lapply(lm,sqrt) #aplico la raiz cuadrada de la lista lm

vm<- sapply(lm, sqrt) #aplico la raiz cuadrada en la lista lm y la devuelvo como un vector

# cargue el data "cars" y cree una nueva columna que rellene con "muy rapido" si la velocidad del modelo es mayor 15 o rellene con "muy lento" si es menor a 15

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

