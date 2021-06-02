#!/bin/bash

rm -rf openwrt
docker build --pull -t img_openwrt_builder .
docker run -ti -v "$(pwd)":/home/openwrt img_openwrt_builder bash -i /home/openwrt/build_openwrt.sh
