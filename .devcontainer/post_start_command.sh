#!/bin/bash

cd /home/developer/navigation_ws/src

./colcon_build.sh

cd /home/developer/navigation_ws/src
source ~/.profile
pre-commit install
