#!/usr/bin/env bash

USERID=$(id -u)
GROUPID=$(id -g)

echo "UID=$UID, USERID=$USERID, GROUPID=$GROUPID"
id
docker run --rm -v $(pwd):/documents/ --user $USERID:$GROUPID asciidoctor/docker-asciidoctor asciidoctor -r asciidoctor-diagram -a docinfo=shared -a linkcss -a copycss -a lang=de -D html index.adoc
cp -r css/ images/ html/
