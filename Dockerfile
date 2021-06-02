# use latest Debian as dependable builder. 
FROM debian:buster AS openwrt_builder

# install dependencies
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
        build-essential \
        ccache \
        ecj \
        fastjar \
        file \
        g++ \
        gawk \
        gettext \
        git \
        java-propose-classpath \
        less \
        libelf-dev \
        libncurses5-dev \
        libncursesw5-dev \
        libssl-dev \
        python \
        python2.7-dev \
        python3 \
        unzip \
        wget \
        python3-distutils \
        python3-setuptools \
        rsync \
        sed \
        subversion \
        sudo \
        swig \
        time \
        vim \
        xsltproc \
        zlib1g-dev  \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# add user
RUN useradd -m openwrt \
    &&  echo 'openwrt ALL=NOPASSWD: ALL' > /etc/sudoers.d/openwrt

# set user
USER openwrt

# set workdir
WORKDIR /home/openwrt
