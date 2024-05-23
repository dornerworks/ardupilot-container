FROM --platform=linux/arm64/v8 ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

WORKDIR /mavdock

RUN echo " Hello World " > /etc/timezone && \
    apt-get update && \
    apt-get install -y \
        python-dev \
        python-opencv \
        python-wxgtk3.0 \
        python-pip \
        python-matplotlib \
        python-pygame \
        python-lxml \
        python-yaml \
    && \
    apt-get clean all
RUN pip install --upgrade pip
RUN pip install --upgrade setuptools && \
    pip install --upgrade MAVProxy

COPY . .

ENTRYPOINT ["/mavdock/mavproxy.sh"]
