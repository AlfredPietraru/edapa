#! /bin/bash


# CLEAR_ENABLED=$1
YAML=$1
SIZE=1024
# DATASET_YAML=/home/alf/edapa/other/datasets/VisDrone/VisDrone.yaml
# DATASET_DETECT=/home/alf/edapa/other/datasets/VisDrone/VisDrone2019-DET-val/images

DATASET_YAML=/home/alf/edapa/other/datasets/coco8/coco8.yaml
DATASET_DETECT=/home/alf/edapa/other/datasets/coco8/images/val

# DATASET_YAML=/home/alf/edapa/other/datasets/VisDroneLonely/VisDroneLonely.yaml
# DATASET_DETECT=/home/alf/edapa/other/datasets/VisDroneLonely/VisDrone2019-DET-val/images
MODEL_NAME=$(basename $YAML .yaml)
SAVE_MODEL_PATH=${MODEL_NAME}_saved_model
MODEL=${MODEL_NAME}.pt


export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
pyenv shell 3.10.1
source my_venv/bin/activate

if [ ! -d ${SAVE_MODEL_PATH} ]
then
    mkdir ${SAVE_MODEL_PATH}
fi


# yolo detect train \
# imgsz=${SIZE} \
# batch=4 \
# epochs=2 \
# data=$DATASET_YAML \
# model=$YAML


# mv runs/detect/train/weights/best.pt ./${MODEL}

# yolo export \
# model=${MODEL} \
# format=tflite \
# imgsz=$SIZE \
# optimize=True \
# int8=True


mv runs/detect/train/results.csv ${SAVE_MODEL_PATH}
edgetpu_compiler ${SAVE_MODEL_PATH}/${MODEL_NAME}_full_integer_quant.tflite
cat ${MODEL_NAME}_full_integer_quant_edgetpu.log
mv ${MODEL_NAME}_full_integer_quant_edgetpu.log  ${MODEL_NAME}_full_integer_quant_edgetpu.tflite ${SAVE_MODEL_PATH}

# python detect.py \
# --weights ${SAVE_MODEL_PATH}/${MODEL_NAME}-int8_edgetpu.tflite \
# --source $DATASET_DETECT \
# --data $DATASET_YAML \
# --img $SIZE \
# --conf-thres 0.25 \
# --iou-thres 0.1 \
# --project ${SAVE_MODEL_PATH} \
# --name detect_exp 

# mv ${SAVE_MODEL_PATH}/train_exp/weights/best.pt ./${MODEL}
# rm -rf ${MODEL_NAME}_saved_model
# echo "SE EXECUTA CU SUCCES TOATE COMENZILE"
