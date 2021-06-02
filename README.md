# Grab bag of scripts to quickly build OpenWrt from scratch in Docker.

Always looking to squeeze the last drop of speed out of my router's hardware, a long time ago I've started compiling the whole installation system. Back then I used virtual machines, a solution which used a lot of precious disk space on my laptop and suffered from the emulation performance penalty (especially painful when running long running build scripts such as these). Recently, I've discovered the fresh horizons opened by the [Docker](https://www.docker.com/why-docker) ecosystem and there's no going back :)

My main goal was to access the specific GCC optimization settings for the MIPS CPU core revision used by my router (74kc in a [TP-Link TL-WDR3600](https://openwrt.org/fr/toh/tp-link/tl-wdr3600) router; instead of the generic, lowest common denominator 24kc for the whole MIPS32 Release 2 Architecture family of chips). Only the full compilation from scratch allowed also for the stripping of unnecessary libraries from the kernel (smaller ROM sizes, always a bonus in embedded computing). 

## Resources

* [The OpenWrt build system](https://openwrt.org/docs/guide-developer/build-system/start) - The original complete documentation and fount of ideas.
* [Docker OpenWrt Image Generation](https://openwrt.org/docs/guide-user/virtualization/obtain.firmware.docker) - specific advice for enabling building on Docker.

## Usage

My laptop is a current (May 2021) ArchLinux machine, with Docker version 20.10.6, build 370c28948e installed. Recent glibc based Linux distros should work just fine, however YMMV. One should be have ~20GB disk space free and be ready for 5-6hours long build time.

Please be aware: the `diffconfig` file is specific to my target router and tastes. You should most likely
 run a `make menuconfig` to specify your own wishes.

Just clone in a directory and run:
```
./start_here.sh
```

## License

The contents of this repository are covered under the [MIT License](LICENSE).