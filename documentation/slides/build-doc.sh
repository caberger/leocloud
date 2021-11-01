#!/usr/bin/env bash

docker run --rm -v $(pwd):/documents/ --user 1000:1000 asciidoctor/docker-asciidoctor asciidoctor -r asciidoctor-diagram -a docinfo=shared -a linkcss -a copycss index.adoc
