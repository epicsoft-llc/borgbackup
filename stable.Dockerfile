FROM alpine:latest
LABEL image.name="epicsoft_borgbackup" \
      image.description="Simple BorgBackup Docker Image" \
      maintainer="epicsoft.de" \
      maintainer.name="Alexander Schwarz <schwarz@epicsoft.de>" \
      maintainer.copyright="Copyright 2018 epicsoft.de / Alexander Schwarz" \
      license="MIT"

RUN apk --no-cache add borgbackup \
 && rm -rf /var/cache/apk/* \
 && mkdir /source \
 && mkdir /target

USER root

WORKDIR /

ENTRYPOINT [ "borg" ]

CMD [ "--version" ]
