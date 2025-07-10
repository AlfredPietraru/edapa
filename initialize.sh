#! /bin/bash
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
pyenv shell 3.9.17
python3 -m venv venv
source venv/bin/activate
pip3 install -r requirements.txt
pip install https://github.com/google-coral/pycoral/releases/download/v2.0.0/tflite_runtime-2.5.0.post1-cp39-cp39-linux_x86_64.whl
pip install https://github.com/google-coral/pycoral/releases/download/v2.0.0/pycoral-2.0.0-cp39-cp39-linux_x86_64.whl
python train.py --img 64 --batch 1 --epochs 3 --data /home/alf/edapa/ultrafun/datasets/coco8/coco8.yaml --cfg models/yolov5n.yaml --weights yolov5n.pt
python export.py --weights yolov5n.pt --include tflite --int8 --img 64
edgetpu_compiler yolov5n-int8.tflite

python detect.py --weights yolov5n-int8_edgetpu.tflite  --source /home/alf/edapa/ultrafun/datasets/coco8/images/train --data /home/alf/edapa/ultrafun/datasets/coco8/coco8.yaml --img 64 --conf-thres 0.25 --iou-thres 0.1



