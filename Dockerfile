# Build Consul Server Container
FROM geoffh1977/alpine:latest
LABEL maintainer="geoffh1977 <geoffh1977@gmail.com>"
USER root

ENV OPENJDK_VERSION=8.212.04 \
    JAVA_HOME=/usr/lib/jvm/default-jvm/jre

# Install OpenJDK
# hadolint ignore=SC2046,DL3018,DL4006
RUN echo "http://nl.alpinelinux.org/alpine/v$(cut -d. -f1-2 /etc/alpine-release)/community/" >> /etc/apk/repositories && \
    apk --update --no-cache add openjdk$(echo ${OPENJDK_VERSION} | cut -d. -f1)=${OPENJDK_VERSION}-r0 nss

USER ${ALPINE_USER}
