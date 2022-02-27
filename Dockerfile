ARG BASE_IMAGE_VERSION=latest
FROM alpine:$BASE_IMAGE_VERSION

ARG BUILD_DATE
LABEL org.label-schema.name="BorgBackup" \
      org.label-schema.description="Simple BorgBackup Docker Image" \
      org.label-schema.vendor="epicsoft.de / Alexander Schwarz <schwarz@epicsoft.de>" \
      org.label-schema.version=${BASE_IMAGE_VERSION} \
      org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=${BUILD_DATE}

LABEL image.name="epicsoft_borgbackup" \
      image.description="Simple BorgBackup Docker Image" \
      maintainer="epicsoft.de" \
      maintainer.name="Alexander Schwarz <schwarz@epicsoft.de>" \
      maintainer.copyright="Copyright 2018-2022 epicsoft.de / Alexander Schwarz" \
      license="MIT"

RUN apk --no-cache add borgbackup \
                       py3-packaging

USER root

WORKDIR /

ENTRYPOINT [ "borg" ]

CMD [ "--show-version" ]
