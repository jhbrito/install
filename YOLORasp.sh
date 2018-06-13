#!/bin/bash
# This script installs YOLOv2 on a Raspberry Pi
# 2018-04-18-raspbian-stretch
# SD Card -> Win32DiskImager

mkdir install
cd install

# Download Tensorflow 1.8.0 -> https://github.com/lhelontra/tensorflow-on-arm/releases
wget https://github.com/lhelontra/tensorflow-on-arm/releases/download/v1.8.0/tensorflow-1.8.0-cp35-none-linux_armv7l.whl

# Download Darkflow -> https://github.com/thtrieu/darkflow
wget https://github.com/thtrieu/darkflow/archive/master.zip
# Extract Darkflow
unzip master.zip

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install python3-pip python3-dev
sudo apt-get install cmake build-essential git cmake pkg-config
sudo apt-get install libjpeg-dev libtiff5-dev libjasper-dev libpng12-dev
sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt-get install libxvidcore-dev libx264-dev
sudo apt-get install libgtk2.0-dev
sudo apt-get install libatlas-base-dev gfortran
sudo apt-get install python-opencv
sudo apt-get install libqt4-dev

pip3 install Cython h5py
pip3 install opencv-python
pip3 install tensorflow-1.8.0-cp35-none-linux_armv7l.whl
pip3 uninstall mock
pip3 install mock

cd darkflow-master
pip3 install -e .

# Download yolov2-tiny (cfg + weights): https://pjreddie.com/darknet/yolo/
cd cfg
wget https://github.com/pjreddie/darknet/blob/master/cfg/yolov2-tiny.cfg
cd ..
cd bin
wget https://pjreddie.com/media/files/yolov2-tiny.weights
cd ..

mv labels.txt labels.txt.o
cp cfg/coco.names labels.txt

# Edit darkflow/utils/loader.py - line 121 - 16->20
# !!!YOU HAVE TO DO THIS YOURSELF !!!

## You can now try on of these demos
#python3 flow --imgdir sample_img/ --model cfg/yolov2-tiny.cfg --load bin/yolov2-tiny.weights
#python3 flow --imgdir sample_img/ --model cfg/yolov2-tiny.cfg --load bin/yolov2-tiny.weights --json
#python3 flow --model cfg/yolov2-tiny.cfg --load bin/yolov2-tiny.weights --demo camera
