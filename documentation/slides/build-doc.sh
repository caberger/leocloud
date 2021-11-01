#!/usr/bin/env bash

#UID=$(id -u)
#GID=$(id -g)

echo "UID=$UID, GID=$GID"

docker run --rm -v $(pwd):/documents/ --user $UID:$GID asciidoctor/docker-asciidoctor asciidoctor -r asciidoctor-diagram -a docinfo=shared -a linkcss -a copycss -a lang=de -D html index.adoc
cp -r css/ images/ html/
