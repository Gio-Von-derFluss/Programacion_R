#Regex
#Manejo de expresiones regulares y caracteres

library(stringr)

nchar("South Pole")#da 10

paste("North","Pole",sep=".") #separa con .

paste("North","and","South","Poles")#tiene un separador por defecto (espacio)

paste0("North","and","South","Poles")#como paste pero no le pone separador

cat("North","and","South","Poles")#lanzada de texto en la consola

cat("North","and","South","Poles","\n")#new line al final, o tabulador al final

cat("North","and","South","Poles",sep="\t")#back slash tabulador(un espacio mas grande)

cat("North","and","South","Poles",sep="\n")#nueva linea



i <- 8

s <- sprintf("the square of %d is %d",i,i^2)#%d -escribir el primer digito que encuente
#sprintf?=
s

for (i in 1:5) { #for expande el numero de veces que hace algo, crea 5 archivos q1...
  
  fname <- sprintf("q%d.pdf",i)
  
  pdf(fname)
  
  hist(rnorm(100,sd=i))
  
  dev.off()
}




grep("pole",c("Equator","North Pole","South Pole"))#busca coincidencias de string en un string
#0 y null es diferente, conjunto vacio

grep("[Ppc]ole",c("Equator","North Pole","South pole"))#[] puede estar p o P antes de ole 
#2 y 3, busca la ubicaci�n, indica quien lo tiene, posici�n, si pongo el c da igual
grep("o.e",c("Equator","North Pole","South Pole","oe"))#que tenga o_cualquier cosa_e

grep("N.t",c("Equator","North Pole","South Pole"))#integer 0

grep("N..t",c("Equator","North Pole","South Pole"))#si encuentra, 2

grep("N...t",c("Equator","North Pole","South Pole"))#no

grep("N?t",c("Equator","North Pole","South Pole"))#que tenga o N o T

grep("?",c("Equator","North Pole","South Pole"))#cualquier cosa

grep(".",c("Equator","North Pole","South Pole"))#que tenga algo

?grep

grep("[.]",c("abc","de","f.g"))#1 2 y 3, que tenga algo? [.] cual tiene un punto
#\uno solo es escapar
#\\ el primer slash le dice a grep que slash es un caracter especial
#[] tambien sirve

grep(".",c("a","bc","bcd"))#cualquier cosa

grep("..",c("a","bc","bcd"))#dos caracteres almenos


grep("...",c("a","bc","bcd"))#3 cosas


grep("\\.",c("abc","de","f.g"))#que tenga punto


x <- c("apple", "banana", "pear","adnon")

str_extract(x, "an")#extraer el string "" en x, NA porque es not assing, no es integer porque no es un conteo

str_extract(x, "a.")#extrae el primero que encuentra con a.

str_extract(x, "a[dn][an]")#busca d o n, en ese orden

str_extract(x, "a.[dn]")#solo 4, estrictamente d o n 

str_extract(x, "a.[d]")#ninguno

str_extract(x, "a.[n]")#4 adn



substring("Equator",3,5)#extrae o reemplaza desde la posicion 3 a la 5

regexpr("ut","Equator")#matching ??????'

gregexpr("iss","Mississippi")##?????marca el inicio de los aciertos, luego la longitud

str_extract("Mississippi","iss")#1 iss solamente, muestra solo el primero, no es un conteo

#Algunas cosas de stringr

head(fruit)

str_extract(fruit, "nana")#solo es una nana, banana, muestra NA

str_extract(fruit, regex("nana"))#hizo lo mismo de arriba

bananas <- c("banana", "Banana", "BANANA")

str_detect(bananas, "banana")#match? y utiliza boileano

str_detect(bananas, regex("banana", ignore_case = TRUE))#busque banana e ignore si tiene mayus o minus

regex("banana", ignore_case = TRUE)#??????

str_extract(x, ".a.")#extrae el string

x <- "a\\b"

writeLines(x)#caracteres a\b, \\ indica que \ es el verdadero!

str_extract(x, "\\\\")#el primero y tercero dicen que el 2 y 4 son el verdadero

# caracteres especiales
#hexadecimal 0-9-a-z

#~      \xhh: 2 hex digitos.

#~      \x{hhhh}: 1-6 hex digitos.

#~      \uhhhh: 4 hex digitos.

#~      \Uhhhhhhhh: 8 hex digitos.

#~ \N{name}, e.g. \N{grinning face} encuentra el emoji sonrisa basico.

#~ Se pueden especificar caracteres de control comunes

#~      \a: bell. camapana

#~      \cX: match a control-X character.

#~      \e: escape (\u001B).

#~      \f: form feed (\u000C).

#~      \n: line feed (\u000A).

#~      \r: carriage return (\u000D).

#~      \t: horizontal tabulation (\u0009).

#~      \0ooo match an octal character. ‘ooo’ is from one to three 
#~      octal digits, from 000 to 0377. The leading zero is required.



x <- "n\u0301"#n con un simbolo hexadecimal

x

str_extract(x, ".")#extra caracter el caracter x

str_extract(x, "\\X")##extrae caracter especial

x <- "n\U0301"#simbolo hexadecimal

x

#~  \s: encuentra espacio en blanco. 
#~  \S: encuentra un caracter que no sea espacio.



(text <- "Some  \t badly\n\t\tspaced \f text")

text#no se escribe porque no maneja regex

print(text)#no maneja regex

cat("Some  \t badly\n\t\tspaced \f text")#hace explicitamente lo que tenga

writeLines(text)#usa regex

str_replace_all(text, "\\s+", "*")##encuentra todos los whitespace, tab etc
#con S reemplaza las palabras con *, lo que no es whitespace
.print	
.

#~  \p{property name} encuentra caracter con codigo unicode especifico
#~  property
#~  \P{property name}, todos los caracteres sin indice unicode. 
#~  http://www.unicode.org/reports/tr44/#Property_Index.


text1 <- c('"Double quotes"', "«Guillemet»", "“Fancy quotes”")

text1##comillas de afuera indica strin

(text <- c('"Double quotes"', "«Guillemet»", "“Fancy quotes”"))

str_replace_all(text1, "\\p{quotation mark}", "\"")#todos deben tener quotation marks
#. es un criterio de busqueda


#~  \w matches encuentra palabras, 
#~  \W, matches encuentra no palabras.



str_extract_all("Don't eat that!", "\\W+")[[1]]##extrae las no palabras
#w extra 4 palabras

str_split("Don't eat that!", "\\W")[[1]] #separa cada palabra, toma en cuenta el not

strsplit("Don't eat that!", "\\W")

strsplit("Don't eat that!", "\\W")[[1]][2]#segunda palabra




substring("Don't eat that!",1,4)#extra caracteres de 1 a 2

substring("Don't eat that!",2,1)#de first a last, toca voltear!!

substring("Don't eat that!",3)#del 3 haca abajo

#~  \b transicion entre palabras, lo que las separa
#~  \B los espacios que hay entre las no palabras, puede ser en las mismas letras



str_replace_all("The quick brown fox", "\\b", "_")#Reemplazo con _ antes y despues de espacio
#cada palabra tiene dos limites, boundary y space no es lo mismo 
str_replace_all("The quick brown fox", "\\B", "_")#tiene 12 no boundary, osea no espacio entre cada letra, o cada letra


#~      [:punct:]: puntuacion
#~      [:alpha:]: letras.
#~      [:lower:]: letras minusculas
#~      [:upper:]: letras mayusculas
#~      [:digit:]: digitos
#~      [:xdigit:]: digitos hexadecimales
#~      [:alnum:]: numeros y letras
#~      [:cntrl:]: caracteres de control
#~      [:graph:]: letras numeros y puntuacion
#~      [:print:]: letras, numeros, puntuacion y espacios
#~      [:space:]: caracteres de espacio (como \s)
#~      [:blank:]: espacio y tabulador

#todos van dentro de [] para caracteres

#| puede buscar lo que este adelante o atras abc|def

str_detect(c("abc", "def", "ghi"), "abc|def")#boileano, T T F

#con parentesis reescribe el orden del procedimiento

str_extract(c("grey", "gray"), "gre|ay")#extrae de los dos cosas distintas

str_extract(c("grey", "gray"), "gr(e|a)y")#extrae toda la palabra

str_extract(c("grey", "gray"), "gr[ea]y")#aca lo mismo de arriba

#~      ^ el inicio de la palabra
#~      $ el final de la palabra

x <- c("apple", "banana", "pear")

str_extract(x, "^a")#si tiene a en el inicio

str_extract(x, "a$")#si tiene a en el final

str_extract(x, "a.")#si tiene algo despues de una a

str_extract(x, ".a")#banana y pear

str_extract(x, "^.a")#banana

str_extract(x, "a.$")#pear

#si hay multiples lineas, la opcion multine = True encontrara lo que hay el comienzo de cada linea por separado 

#~      ^ encuentra el comienzo de cada linea.

#~      $ encuentra el final de cada linea.

#~      \A lo que hay en el comienzo de la entrada.

#~      \z lo que hay al final de la entrada.

#~      \Z lo que hay al final de la entrada.

x <- "Line 1\nLine 2\nLine 3\n"

str_extract_all(x, "^Line..")#encuentra sollo la primera Line

str_extract_all(x, "^Line..")[[1]]##es una lista

str_extract_all(x, regex("^Line..", multiline = TRUE))[[1]]#diciente que multilinea es cierto, encuentre todas

str_extract_all(x, regex("^Line..", multiline = TRUE))#arriba todo

str_extract_all(x, regex("\\ALine..", multiline = TRUE))[[1]]#la primera, x es un solo input

str_extract_all(x, regex("\\ALine..", multiline = TRUE)) #extrae la primera linea

# Maneras de detectar comentarios

str_detect("xyz", "x(?#this is a comment)")#() busca algo, lo segundo es el comentario

phone <- regex("#regex expande, y match como string
  \\(!     # optional opening parens
  (\\d{3}) # area code #tengo 3 digitos
  [)- ]?   # optional closing parens, dash, or space#[] como si fuera comillas
  (\\d{3}) # another three numbers
  [ -]?    # optional space or dash
  (\\d{3}) # three more numbers
  ", comments = TRUE)

str_match("514-791-8141", phone)

#corregido
phone <- regex("
  \\(?     # abre con parentesis
  (\\d{3}) # que tenga 3 digitos
  [)- ]?   # si tiene parentesis para cerrar
  (\\d{3}) # another three numbers
  [ -]?    # busca si tiene espacio o -
  (\\d{3}) # que tenga 3 digitos
  ", comments = TRUE) #tiene comentarios

str_match("514-791-8141", phone)

## ejercicio en clase / casa

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

## 1. el mismo usario (expl�?cito) en dos proveedores de correo
regex_1 <- regex(" #usuario que sea juan, jorge p john y que este en proveedores hotmail y gmail
  j #inicie con j
  [:alnum:]+ #tenga numeros o letras  hasta un graph
  [:graph:]
  (hotmail|gmail)
", comments = TRUE, ignore_case = TRUE)

str_extract_all(vectorCars,regex_1) 
## 2. potencialmente el mismo usuario tanto en el mismo proveedor
## como en distintos proveedores.

regex_2 <- regex("# usuario que inicie con j en cualquier proveedor
  j
  [:alnum:]+
  [:graph:]
  [:alnum:]+
", comments = TRUE, ignore_case = TRUE)

str_extract_all(vectorCars,regex_2)

## Para los dos casos suponga que solo existen tres nombres:
#### Maria / Juan / Pedro, en distintos idiomas


## 3. corrija de manera automatica los usarios o los dominios con nombres errados; preferiblemente escrito como una función.

regex_3 <- regex(" #busque todo lo que inicia en numeros y letras e ignore si es mayuscula o minuscula
  ^[:alnum:]+
", comments = TRUE, ignore_case = TRUE)

my_func <- function(x) {#funcion para reemplazar con tres nombres: Juan, Pedro y Maria con las lineas que cumplen los requisitos para cada nombre
  x %>%
    str_replace_all(c("(\\w{4,7}uan|\\dj|j|J)[:alnum:]+" = "Juan", "(Ped|pet|ped)[:alnum:]+" = "Pedro", "(......m|m|M)[:alnum:]+" = "Maria"))
}

str_replace_all(vectorCars,regex_3,my_func)#Reemplazo con mi funcion para corregir todos los nombres
