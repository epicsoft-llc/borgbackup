#### https://hub.docker.com/_/alpine
ARG ALPINE_VERSION=latest
FROM alpine:${ALPINE_VERSION}

ARG IMAGE_TAG="local"
ARG BUILD_DATE="development"
LABEL org.label-schema.name="BorgBackup" \
      org.label-schema.description="BorgBackup on Alpine for deduplicated, encrypted backups" \
      org.label-schema.vendor="epicsoft LLC / Alexander Schwarz <info@epicsoft.one>" \
      org.label-schema.url="https://gitlab.com/epicsoft-networks/borgbackup/" \
      org.label-schema.vcs-url="https://gitlab.com/epicsoft-networks/borgbackup/-/tree/master/" \
      org.label-schema.version=${IMAGE_TAG} \
      org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=${BUILD_DATE}

LABEL image.name="epicsoft_borgbackup" \
      image.description="BorgBackup on Alpine for deduplicated, encrypted backups" \
      maintainer="epicsoft LLC" \
      maintainer.name="Alexander Schwarz <info@epicsoft.one>" \
      maintainer.copyright="Copyright 2022-2026 epicsoft LLC" \
      license="MIT"

#### packages of the base image lag behind the Alpine repository - the upgrade brings their security fixes
RUN apk --no-cache upgrade \
 && apk --no-cache add borgbackup \
                       py3-packaging \
                       libffi-dev \
                       openssl-dev \
                       ca-certificates \
 && update-ca-certificates \
 && rm -rf /var/cache/apk/*

USER root

WORKDIR /

ENTRYPOINT [ "borg" ]

CMD [ "--show-version" ]
