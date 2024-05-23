FROM debian:buster

## Trick to get apt-get to not prompt for timezone in tzdata
ENV DEBIAN_FRONTEND=noninteractive

# Need Git to checkout our sources
RUN dpkg --add-architecture arm64
RUN apt update
RUN apt install -y \
    git \
    tzdata \
    bc \
    gawk \
    wget \
    screen \
    build-essential \
    crossbuild-essential-arm64 \
    rsync \
    libxml2-dev:arm64 \
    libxslt1-dev:arm64 \
    zlib1g-dev:arm64 \
    python-dev \
    python-pip \
    curl

RUN pip install --user -U argparse empy pyserial pexpect future lxml mavproxy intelhex numpy edn_format pymavlink

# Now grab ArduPilot from GitHub
RUN git clone https://github.com/ArduPilot/ardupilot.git ardupilot -b Copter-4.0 --depth 1

# Build the COPTER
WORKDIR /ardupilot

# Now start build instructions from http://ardupilot.org/dev/docs/setting-up-sitl-on-linux.html
RUN git submodule update --init --recursive

## Continue build instructions from https://github.com/ArduPilot/ardupilot/blob/master/BUILD.md
RUN ./waf distclean
RUN ./waf configure --board sitl --toolchain aarch64-linux-gnu
RUN ./waf copter

# setup python site-packages to be copied to target image
RUN ls /root/.local/lib/python2.7/site-packages
RUN mkdir site-packages && cp -r /root/.local/lib/python2.7/site-packages/builtins site-packages/ && cp -r /root/.local/lib/python2.7/site-packages/future* site-packages/ && cp -r /root/.local/lib/python2.7/site-packages/MAVProxy* site-packages/ && cp -r /root/.local/lib/python2.7/site-packages/serial site-packages/ && cp -r /root/.local/lib/python2.7/site-packages/pyserial-3.5.dist-info site-packages/ && cp -r /root/.local/lib/python2.7/site-packages/pymavlink* site-packages/

RUN cp build/sitl/bin/arducopter /

#load these up in case user would like to test on host
COPY copter.parm /copter/Tools/autotest/default_params/copter.parm
COPY copter.parm /
COPY startArdu.sh /startArdu.sh
# Variables for simulator
ENV INSTANCE=0 \
    LAT=42.9193939 \
    LON=-85.5814623 \
    ALT=14 \
    DIR=270 \
    COPTERMODEL=+ \
    SPEEDUP=1 \
    VEHICLE=arducopter \
    NUMCOPTERS=1 \
    INCREMENTSTEPLAT=0.01 \
    INCREMENTSTEPLON=0.01

ENTRYPOINT /bin/bash
#ENTRYPOINT /startArdu.sh ${NUMCOPTERS}  ${LAT} ${LON} ${ALT} ${DIR} ${INCREMENTSTEPLAT} ${INCREMENTSTEPLON} ${COPTERMODEL} ${SPEEDUP}
