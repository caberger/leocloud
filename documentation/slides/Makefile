SHELL=/bin/bash
all:
	docker run --rm -v $$(pwd):/documents/ --user 1000:1000 asciidoctor/docker-asciidoctor asciidoctor -r asciidoctor-diagram -a docinfo=shared -a linkcss -a copycss index.adoc

clean:
	rm -rf *.pdf *.svg .asciidoctor

.PHONY: all clean