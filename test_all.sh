#! /bin/bash

PATH_TO_YAMLS=/home/alf/edapa/other/yolov5/models
yaml_files=($(cd ${PATH_TO_YAMLS} &&  ls *.yaml))

for yaml_file in "${yaml_files[@]}"; do 
    var=$(echo $yaml_file | cut -d'.' -f1)
    echo Try to work with $var.yaml configure file.
    ./pipeline.sh $var
done