FROM alpine:latest
ARG FREQUENCY=daily
ARG RCLONE_CONFIG_LOCATION=/root/.config/rclone
ARG RCLONE_PKG_URL=https://downloads.rclone.org/v1.55.0/rclone-v1.55.0-linux-amd64.deb

RUN set -ex && \
    apk update && \
    apk add \
        wget \
        dpkg && \
    dpkg --add-architecture amd64

RUN wget -qO /tmp/rclone.deb ${RCLONE_PKG_URL} && \
    dpkg -i /tmp/rclone.deb

COPY ./scripts/* /etc/periodic/$FREQUENCY
RUN chmod a+x /etc/periodic/$FREQUENCY/*

RUN mkdir -p ${RCLONE_CONFIG_LOCATION}
COPY ./rclone_config/* ${RCLONE_CONFIG_LOCATION}/
