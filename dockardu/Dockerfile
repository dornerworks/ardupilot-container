FROM dockardu_xcompile:latest AS builder

FROM arm64v8/ubuntu:18.04

WORKDIR /ardupilot
RUN apt update && apt install -y python bc screen \
    && mkdir -p Tools/autotest/ && mkdir ArduCopter && mkdir build

COPY --from=builder /ardupilot/site-packages/ /root/.local/lib/python2.7/site-packages/
COPY --from=builder /ardupilot/build/ build/
COPY --from=builder /ardupilot/build/sitl/bin/arducopter /
COPY --from=builder /ardupilot/Tools/autotest/ Tools/autotest/
COPY --from=builder /ardupilot/ArduCopter/ ArduCopter/
COPY copter.parm /copter/Tools/autotest/default_params/copter.parm
COPY copter.parm /
COPY startArdu.sh /startArdu.sh

EXPOSE 5760-5760

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

# Finally the command
ENTRYPOINT /startArdu.sh ${NUMCOPTERS}  ${LAT} ${LON} ${ALT} ${DIR} ${INCREMENTSTEPLAT} ${INCREMENTSTEPLON} ${COPTERMODEL} ${SPEEDUP}