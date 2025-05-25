ARG IMAGE_TAG=latest
FROM alpine:$IMAGE_TAG

ARG IMAGE_TAG=latest
ARG BUILD_DATE="development"
LABEL org.label-schema.name="BorgBackup" \
      org.label-schema.description="Simple BorgBackup Docker Image" \
      org.label-schema.vendor="epicsoft LLC / Alexander Schwarz <as@epicsoft.one>" \
      org.label-schema.version=${IMAGE_TAG} \
      org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=${BUILD_DATE}

LABEL image.name="epicsoft_borgbackup" \
      image.description="Simple BorgBackup Docker Image" \
      maintainer="epicsoft LLC" \
      maintainer.name="Alexander Schwarz <as@epicsoft.one>" \
      maintainer.copyright="Copyright 2022-2025 epicsoft LLC" \
      license="MIT"

RUN apk --no-cache add borgbackup \
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
