#!/bin/bash

# set up build system image
docker build --pull -t img_openwrt_builder .

# run OpenWRT build
docker run --rm -ti -v "$(pwd)":/home/openwrt img_openwrt_builder bash -i /home/openwrt/build_openwrt.sh
