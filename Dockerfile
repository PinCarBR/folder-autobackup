FROM alpine:latest
ARG FREQUENCY

COPY ./scripts/* /etc/periodic/$FREQUENCY

RUN chmod a+x /etc/periodic/$FREQUENCY/*
