#! /bin/bash

PATH_TO_YAMLS=/home/alf/edapa/other/yolov5/yamls
yaml_files=($(cd ${PATH_TO_YAMLS} &&  ls *.yaml))

for yaml_file in "${yaml_files[@]}"; do 
    ./pipeline.sh yamls/$yaml_file
done