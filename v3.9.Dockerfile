ARG BASE_IMAGE_VERSION=3.9
FROM alpine:$BASE_IMAGE_VERSION
LABEL image.name="epicsoft_borgbackup" \
      image.description="Simple BorgBackup Docker Image" \
      maintainer="epicsoft.de" \
      maintainer.name="Alexander Schwarz <schwarz@epicsoft.de>" \
      maintainer.copyright="Copyright 2018-2019 epicsoft.de / Alexander Schwarz" \
      license="MIT"

#### Workaround: The 'msgpack-python!=0.5.0,!=0.5.1,!=0.5.2,!=0.5.3,!=0.5.4,!=0.5.5,<=0.5.6,>=0.4.6' distribution was not found and is required by borgbackup
RUN apk --no-cache add python3 \
 && pip3 install 'msgpack-python!=0.5.0,!=0.5.1,!=0.5.2,!=0.5.3,!=0.5.4,!=0.5.5,<=0.5.6,>=0.4.6' \
 && rm -rf /var/cache/apk/*

RUN apk --no-cache add borgbackup \
 && rm -rf /var/cache/apk/*

USER root

WORKDIR /

ENTRYPOINT [ "borg" ]

CMD [ "--show-version" ]
