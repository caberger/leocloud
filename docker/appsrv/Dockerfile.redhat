FROM registry.access.redhat.com/ubi8/ubi-minimal
WORKDIR /deployments/
COPY deployments/*-runner /deployments/application
RUN chmod 775 /deployments
EXPOSE 8080
CMD ["./application", "-Dquarkus.http.host=0.0.0.0"]
