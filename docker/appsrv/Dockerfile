FROM alpine:3
RUN apk update && apk add netcat-openbsd

WORKDIR /usr/local/bin
COPY deployments/*-runner /usr/local/bin/application
RUN chmod 775 /usr/local/bin/application

EXPOSE 8080

CMD ["./application"]
