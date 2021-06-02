#!/bin/bash

# set wanted branch name
BRANCH=openwrt-21.02 # openwrt-19.07

# get latest stable version - shallow copy
git clone --depth 1 git://git.openwrt.org/openwrt/openwrt.git --branch $BRANCH
# fetch and install package feeds
cd openwrt
./scripts/feeds update -a
./scripts/feeds install -a

# Append changes to bottom of .config
cat ../diffconfig >> .config
# Apply changes
make defconfig
# fix MIPS CPU version 24kc > 74kc
sed -Ei 's/24kc/74kc/' .config

# run build process
make download
ionice -c 3 nice -n 20 make -j 2 V=s 2>&1 | tee build.log | grep -i -E "^make.*(error|[12345]...Entering dir)"

