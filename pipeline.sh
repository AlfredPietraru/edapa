#! /bin/bash


# CLEAR_ENABLED=$1
MODEL_NAME=$1
SIZE=1024
# DATASET_YAML=/home/alf/edapa/other/datasets/VisDrone/VisDrone.yaml
# DATASET_DETECT=/home/alf/edapa/other/datasets/VisDrone/VisDrone2019-DET-val/images

DATASET_YAML=/home/alf/edapa/other/datasets/coco8/coco8.yaml
DATASET_DETECT=/home/alf/edapa/other/datasets/coco8/images/val

# DATASET_YAML=/home/alf/edapa/other/datasets/VisDroneLonely/VisDroneLonely.yaml
# DATASET_DETECT=/home/alf/edapa/other/datasets/VisDroneLonely/VisDrone2019-DET-val/images
SAVE_MODEL_PATH=dir_${MODEL_NAME}
MODEL=${MODEL_NAME}.pt


export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
pyenv shell 3.9.17
source venv/bin/activate
if [ ! -d ${SAVE_MODEL_PATH} ]
then
    mkdir ${SAVE_MODEL_PATH}
fi


# --weights ${MODEL} \

yolo detect train  \
imgsz=$SIZE \
batch=4 \
epochs=2 \
data=$DATASET_YAML \
cfg=models/${MODEL_NAME}.yaml \
save-period=2 \
project=${SAVE_MODEL_PATH} \
name=train_exp 

# mv ${SAVE_MODEL_PATH}/train_exp/weights/best.pt ./${MODEL}

# python export.py --weights ${MODEL} --include tflite --int8 --img $SIZE


# edgetpu_compiler ${MODEL_NAME}-int8.tflite
# cat ${MODEL_NAME}-int8_edgetpu.log
# mv ${MODEL_NAME}-int8.tflite ${MODEL_NAME}-int8_edgetpu.log ${MODEL_NAME}-int8_edgetpu.tflite ${SAVE_MODEL_PATH}

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
