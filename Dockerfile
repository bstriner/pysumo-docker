# Python 2.7 libSUMO Docker Image

FROM ubuntu:18.04
MAINTAINER Benjamin Striner <bstriner@andrew.cmu.edu>

## Basics
RUN apt-get update --fix-missing
RUN apt-get install -y software-properties-common
RUN apt-get install -y apt-utils
RUN apt-get install -y gcc
RUN apt-get install -y make
RUN apt-get install -y cmake
RUN apt-get install -y build-essential
RUN apt-get install -y git
RUN dpkg --configure -a

## Python
RUN apt-get install -y python python-dev python-pip
RUN python -m pip install --upgrade pip

## SUMO Dependencies
# Swig
RUN apt-get install -y swig
# XercesC
RUN apt-get install -y libxerces-c-dev
# GDAL
RUN apt-get install -y libgdal-dev
# proj
RUN apt-get install -y libproj-dev
# FOX
RUN apt-get install -y libfox-1.6-0 libfox-1.6-dev

## SUMO Install
WORKDIR /home
# RUN git clone https://github.com/eclipse/sumo.git
RUN git clone -b setuptools https://github.com/bstriner/sumo-1.git sumo
RUN cd sumo && mkdir build27 && cd build27 && cmake -DPython_ADDITIONAL_VERSIONS=2.7 -DCMAKE_BUILD_TYPE=Release .. && cmake --build . --target install_pylibsumo --config Release
