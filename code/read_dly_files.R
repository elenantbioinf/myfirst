#Selección directorio de trabajo
setwd("//wsl.localhost/Ubuntu-24.04/home/elena/myfirst_repository/myfirst")
getwd()

#Instalación paquetes necesarios
install.packages("tidyverse")
install.packages("glue")

library(tidyverse)
library(glue)

#ReadMe

#https://www.ncei.noaa.gov/pub/data/ghcn/daily/readme.txt
#------------------------------
#  Variable   Columns   Type
#------------------------------
#ID            1-11   Character
#YEAR         12-15   Integer
#MONTH        16-17   Integer
#ELEMENT      18-21   Character
#VALUE1       22-26   Integer
#MFLAG1       27-27   Character
#QFLAG1       28-28   Character
#SFLAG1       29-29   Character
#VALUE2       30-34   Integer
#MFLAG2       35-35   Character
#QFLAG2       36-36   Character
#SFLAG2       37-37   Character
#.           .          .
#.           .          .
##.           .          .
#VALUE31    262-266   Integer
#MFLAG31    267-267   Character
#QFLAG31    268-268   Character
#SFLAG31    269-269   Character
#------------------------------

#These variables have the following definitions:
#  
#  ID         is the station identification code.  Please see "ghcnd-stations.txt"
#for a complete list of stations and their metadata.
#YEAR       is the year of the record

#MONTH      is the month of the record.
#
#ELEMENT    is the element type.   There are five core elements as well as a number
#of addition elements.  

#The five core elements are:
  
#PRCP = Precipitation (tenths of mm)
#SNOW = Snowfall (mm)
#SNWD = Snow depth (mm)
#TMAX = Maximum temperature (tenths of degrees C)
#TMIN = Minimum temperature (tenths of degrees C)
#---------------------------------------------


#Lectura de un archivo fwf

read_fwf("data/ghcnd_all/ASN00008255.dly")


#Selección de la primera columna

read_fwf("data/ghcnd_all/ASN00008255.dly") %>% select(X1)


#Delimitación de la anchura o width 

widths <- c(11,4,2,4,rep(c(5,1,1,1),31))


#Comprobación de la variable creada, debe sumar 269 caracteres, los mismos que
#indica la tabla inicial 

sum(widths)


#Definir los nombres de las diferentes columnas 

quadruple <- function(x){
  c(glue("VALUE{x}"), glue("MFLAG{x}"), glue("QFLAG{x}"), glue("SFLAG{x}"))
}

headers <- c("ID","YEAR", "MONTH", "ELEMENT",unlist(map(1:31, quadruple)))
headers


#Nombrar cada columna
read_fwf("data/ghcnd_all/ASN00008255.dly",
         fwf_widths(widths, headers)
        )

#Añadir NA value
read_fwf("data/ghcnd_all/ASN00008255.dly",
         fwf_widths(widths, headers),
         na = c("NA", "-9999", "")
)


#Especificar el tipo de columnas
read_fwf("data/ghcnd_all/ASN00008255.dly",
         fwf_widths(widths, headers),
         na = c("NA", "-9999", ""),
         col_types = cols(.default = col_character())
)


#Seleccionar las columnas de interés
read_fwf("data/ghcnd_all/ASN00008255.dly",
         fwf_widths(widths, headers),
         na = c("NA", "-9999", ""),
         col_types = cols(.default = col_character()),
         col_select = c(ID, YEAR, MONTH, ELEMENT, starts_with("VALUE"))
)
