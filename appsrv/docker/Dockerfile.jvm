FROM adoptopenjdk:jdk

RUN apt update && apt install -y netcat && apt clean
RUN mkdir /usr/local/bin/application
COPY deployments/*.jar /usr/local/bin/application/
COPY scripts/* /usr/local/bin/application/
RUN sed -e 's/\r$//' -i /usr/local/bin/application/*.sh && chmod +x /usr/local/bin/application/*.sh

EXPOSE 8080
WORKDIR /usr/local/bin/application
ENTRYPOINT ["./run.sh"]

