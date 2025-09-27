FROM nix-docker.registry.twcstorage.ru/ci/build/common-build:0.1.0@sha256:d7c61f3bc8d5fe85a16aa07e773ecbce9b24c1f7be3bb4fb5d08fcacdf2520a4

LABEL org.opencontainers.image.authors="wizardy.oni@gmail.com"

USER root

# Install nodejs, npm
ARG NODEJS_MAJOR_VERSION=22
ARG NODEJS_VERSION=22.20.0
RUN curl -kLso nodejs_${NODEJS_MAJOR_VERSION}.sh "https://rpm.nodesource.com/setup_${NODEJS_MAJOR_VERSION}.x" \
    && chmod +x nodejs_${NODEJS_MAJOR_VERSION}.sh \
    && ./nodejs_${NODEJS_MAJOR_VERSION}.sh \
    && microdnf -y --refresh \
                --setopt=install_weak_deps=0 \
                --setopt=tsflags=nodocs \
                --disablerepo=nodesource-nsolid install nodejs-${NODEJS_VERSION} \
    && node --version \
    && npm --version \
    && microdnf -y clean all \
    && rm -rf /var/cache/dnf /var/cache/yum

USER jenkins