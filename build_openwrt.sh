#!/bin/bash

# clean old builds - if any
if [ -d "openwrt" ]; then
echo 'Cleaning old build trees...'
rm -rf openwrt
fi

# set wanted branch name
BRANCH=openwrt-19.07 # openwrt-19.07 // openwrt-21.02 // lede-17.01

# get latest stable version on that branch
git clone git://git.openwrt.org/openwrt/openwrt.git --branch $BRANCH
# fetch and install package feeds
cd openwrt
./scripts/feeds update -a
./scripts/feeds install -a

# timestamp the build
echo CONFIG_KERNEL_BUILD_DOMAIN=\"$(date +'%Y%m%d')\" >> ../diffconfig
# Append changes to bottom of .config
cat ../diffconfig >> .config
# Apply changes
make defconfig

# fix MIPS CPU version 24kc > 74kc
# https://gcc.gnu.org/onlinedocs/gcc/MIPS-Options.html
sed -Ei 's/24kc/74kc/' .config
sed -Ei 's/-mips32r2/-march=74kc/' .config
# Add MIPS DSP ASE - Revision 2.0 support
sed -Ei 's/-mtune=74kc/-mtune=74kc -mdspr2/' .config

# run build process; allow other work on desktop
make download
ionice -c 3 nice -n 20 make -j 2 V=s 2>&1 | tee build.log | grep -i -E "^make.*(error|[12345]...Entering dir)" ; tput bel


