#!/bin/sh
set -eu

mkdir -p /myResilio/myDatas/myConfs
mkdir -p /myResilio/myDatas/myDls

if ! [ -f /myResilio/myDatas/myConfs/rslsync.conf ]; then
    cp /etc/rslsync.conf /myResilio/myDatas/myConfs/;
fi

#chown -R resilio:resilio /myResilio
#chmod -R 777 /myResilio

if [ $# -eq 0 ]; then
  /sbin/su-exec resilio rslsync --config /myResilio/myDatas/myConfs/rslsync.conf --log /myResilio/myDatas/rslsync.log --nodaemon
else
  /sbin/su-exec "$@"
fi
