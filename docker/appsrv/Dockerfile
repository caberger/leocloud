FROM alpine:3
RUN apt update && apt install -y netcat && apt clean

WORKDIR /usr/local/bin
COPY deployments/*-runner /usr/local/bin/application
RUN chmod 775 /usr/local/bin/application
EXPOSE 8080
CMD ["./application", "-Dquarkus.http.host=0.0.0.0"]
