FROM alpine:3
RUN apk update && apk add netcat-openbsd

RUN mkdir /usr/local/bin/application

COPY deployments/* /usr/local/bin/application/
COPY scripts/* /usr/local/bin/application/
RUN sed -e 's/\r$//' -i /usr/local/bin/application/*.sh && chmod +x /usr/local/bin/application/*.sh
RUN chmod +x /usr/local/bin/application/*-runner

EXPOSE 8080

WORKDIR /usr/local/bin/application
CMD ["./run-native.sh"]
