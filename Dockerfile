# Build Consul Server Container
ARG IMAGE_USER=geoffh1977
ARG IMAGE_NAME=alpine
ARG IMAGE_VERSION=latest

FROM ${IMAGE_USER}/${IMAGE_NAME}:${IMAGE_VERSION}
LABEL maintainer="geoffh1977 <geoffh1977@gmail.com>"
USER root

ARG OPENJDK_VERSION
ENV JAVA_HOME=/usr/lib/jvm/default-jvm/jre

# Install OpenJDK
# hadolint ignore=SC2046,DL3018,DL4006
RUN echo "http://nl.alpinelinux.org/alpine/v$(cut -d. -f1-2 /etc/alpine-release)/community/" >> /etc/apk/repositories && \
    apk --update --no-cache add openjdk$(echo ${OPENJDK_VERSION} | cut -d. -f1)=${OPENJDK_VERSION}-r1 nss

USER ${ALPINE_USER}
