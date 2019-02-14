FROM frolvlad/alpine-glibc

ENV UID=1000 GID=1000
EXPOSE 10036 10037

ADD https://download-cdn.resilio.com/stable/linux-x64/resilio-sync_x64.tar.gz /tmp/resilio-sync_x64.tar.gz
COPY rslsync.conf /etc/
#COPY resilio-sync_x64.tar.gz /tmp/
RUN set -eu; sed -i 's/dl-cdn.alpinelinux.org/mirrors.cloud.tencent.com/' /etc/apk/repositories && sed -i 's/http:/https:/' /etc/apk/repositories && apk --no-cache add su-exec && tar -xf /tmp/resilio-sync_x64.tar.gz -C /usr/local/bin rslsync && chmod +x /usr/local/bin/rslsync && rm -f /tmp/* && addgroup -g $GID -S resilio && adduser -u $UID -S resilio -G resilio -D -h "/myResilio"
COPY --chown=resilio:resilio entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
