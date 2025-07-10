#! /bin/bash
NAME=$1
rm ${NAME}-int8_edgetpu.log
rm ${NAME}-int8_edgetpu.tflite
rm ${NAME}-int8.tflite
# rm ${NAME}.pt
rm -rf ${NAME}_saved_model


