#! /bin/bash
python3 -m venv my_venv
source my_venv/bin/activate
pip3 install -r requirements.txt
cp models/yolov5UPDATED.pt .
./pipeline.sh yamls/yolov5UPDATED.yaml 

