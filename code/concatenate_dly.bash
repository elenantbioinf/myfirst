#!/usr/bin/env bash

#Creacion de directorio para archivos temporales
mkdir -p data/temp

#Extraccion, filtrado y división de los datos del tarball
tar Oxvf data/ghcnd_all.tar.gz | grep "PRCP" | split -l 1000000 --filter 'gzip > data/temp/$FILE.gz'

#Conversión del script de R a Unix por si viene de Windows
dos2unix code/read_split_dly_files.R

#Ejecutar el script de R
Rscript code/read_split_dly_files.R

#Limpieza
rm -rf data/temp

