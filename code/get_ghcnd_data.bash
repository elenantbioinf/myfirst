#!/usr/bin/env bash 

		# Este archivo se utiliza para descargar todos los datos que necesitaremos
		# Hay un archivo con TODOS los datos, llamado ghcnd_all, otro con los datos de estaciones,
		# llamado ghcnd_stations.txt, y otro de inventario, ghcnd_inventory.txt. 
		# Con este script se pueden descargar todos a la vez


		#Generamos una variable llamada file. al poner $1 le decimos que la variable file será
		#el primer argumento que encuentre tras correr el script
		#De esta manera, cuando tu le digas que quieres descargar, habrá que indicar qué archivo

#you will need to download next three files: 
#	ghcnd_all.tar.gz
#	ghcnd-stations.txt
#	ghcnd-inventory.txt
#these will be de arguments you need to write just after to run de bash

file=$1

		#Generamos una variable llamada file. al poner $1 le decimos que la variable file será
                #el primer argumento que encuentre tras correr el script
                #De esta manera, cuando tu le digas que quieres descargar, habrá que indicar qué archivo 
		#será el que se descargue

rm data/$file

		#Ademas con lo anterior se le indica que borre el archivo si lo tiene, asi siempre será
		#descargado el mas reciente
		
wget -P data/ https://www.ncei.noaa.gov/pub/data/ghcn/daily/$file

		#Con el comando wget se descargará el archivo indicado después en el argumento
		#Al poner la opcion -P seguida del directorio, se guardará en un directorio concreto, 
		#en este caso, en data
