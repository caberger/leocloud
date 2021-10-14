#!/bin/bash

RUNNER=$(ls *-runner.jar)

echo "starting quarkus $RUNNER..."
java -Dquarkus.profile=prod -jar $RUNNER
