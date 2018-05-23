FROM alpine:edge
LABEL image.name="epicsoft_borgbackup" \
      image.description="Simple BorgBackup Docker Image" \
      maintainer="epicsoft.de" \
      maintainer.name="Alexander Schwarz <schwarz@epicsoft.de>" \
      maintainer.copyright="Copyright 2018 epicsoft.de / Alexander Schwarz" \
      license="MIT"

#### Workaround because BorgBackup needs msgpack version '< 0.5.0' and '>= 0.4.6'
RUN echo 'http://nl.alpinelinux.org/alpine/v3.7/community' >> /etc/apk/repositories \
 && apk --no-cache add py3-msgpack=0.4.8-r2 \
                       borgbackup \
 && rm -rf /var/cache/apk/*

USER root

WORKDIR /

ENTRYPOINT [ "borg" ]

CMD [ "--show-version" ]
