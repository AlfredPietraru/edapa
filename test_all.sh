#! /bin/bash

PATH_TO_YAMLS=/home/alf/edapa/new/yamls
yaml_files=($(cd ${PATH_TO_YAMLS} &&  ls *.yaml))

for yaml_file in "${yaml_files[@]}"; do 
    ./pipeline.sh yamls/$yaml_file
done