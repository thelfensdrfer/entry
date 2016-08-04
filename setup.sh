#!/bin/bash
# Setup script tested in Ubuntu 16.04

NUMBER_OF_CORES=$(getconf _NPROCESSORS_ONLN)

set -e

# Init and update submodules
git submodule update --init --recursive

# Install openface dependencies
# http://stackoverflow.com/a/26825009/1100089
sudo apt-get install libfreetype6-dev libxft-dev

# https://cmusatyalab.github.io/openface/setup/#by-hand
sudo -H pip2 install numpy pandas scipy scikit-learn scikit-image

# Install OpenCV
# https://cmusatyalab.github.io/openface/setup/#opencv
# http://docs.opencv.org/2.4/doc/tutorials/introduction/linux_install/linux_install.html
sudo apt-get install build-essential \
	cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev \
	python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev \
	wget

cd opencv
git checkout 2.4.11
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
	-D CMAKE_INSTALL_PREFIX=/usr/local ..
make -j $NUMBER_OF_CORES
sudo make install
cd ../..

# Install dlib
sudo apt-get install libboost-python*

# https://cmusatyalab.github.io/openface/setup/#dlib
cd dlib
git checkout v18.16
cd python_examples
mkdir build
cd build
cmake ../../tools/python
cmake --build . \
	--config Release
sudo cp dlib.so /usr/local/lib/python2.7/dist-packages
cd ../../../

# Install Torch
cd torch
./install-deps
./install.sh
source ~/.bashrc
cd ..

# Install lua dependencies
for NAME in dpnn nn optim optnet csvigo cutorch cunn fblualib torchx tds; do luarocks install $NAME; done

cd openface
sudo python2 setup.py install
