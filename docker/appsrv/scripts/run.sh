#!/bin/bash

RUNNER=$(ls application-server-*-runner.jar)

echo "starting quarkus $RUNNER..."
java -Dquarkus.profile=prod -jar $RUNNER
