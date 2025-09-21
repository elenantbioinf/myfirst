#!/usr/bin/env bash


#Con este código se llama a correr al script para descargar los datos y se les da
#el argumento directamente. Corriendo este script se descargan los tres archivos
#simultaneamente

bash code/get_ghcnd_data.bash ghcnd-inventory.txt

bash code/get_ghcnd_data.bash ghcnd-stations.txt

bash code/get_ghcnd_data.bash ghcnd_all.tar.gz


#Añadimos tambien el script creado para guardar los nombres de los archivos de dentro
#del archivo tar

bash code/get_ghcnd_all_files.bash
