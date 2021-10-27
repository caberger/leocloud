FROM registry.access.redhat.com/ubi8/ubi-minimal
RUN microdnf update && microdnf install nmap && microdnf clean all

RUN mkdir /usr/local/bin/application
COPY deployments/*-runner /usr/local/bin/application/application
COPY scripts/* /usr/local/bin/application/
RUN sed -e 's/\r$//' -i /usr/local/bin/application/*.sh && chmod +x /usr/local/bin/application/*.sh
RUN chmod +x /usr/local/bin/application/application

EXPOSE 8080

WORKDIR /usr/local/bin/application
CMD ["./run-native.sh"]
