# use Debian as dependable builder for older OpenWRT releases. 
FROM debian:buster AS openwrt_builder

# install dependencies
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
        build-essential ccache ecj fastjar file g++ gawk \
        gettext git java-propose-classpath libelf-dev libncurses5-dev \
        libncursesw5-dev libssl-dev python python2.7-dev python3 unzip wget \
        python3-distutils python3-setuptools python3-dev rsync subversion \
        swig time xsltproc zlib1g-dev sudo less vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# add user - Do everything as an unprivileged user
RUN useradd -m openwrt && \
    echo 'openwrt ALL=NOPASSWD: ALL' > /etc/sudoers.d/openwrt

# set user
USER openwrt

# set workdir
WORKDIR /home/openwrt
