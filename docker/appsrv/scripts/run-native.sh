#!/usr/bin/env bash

while ! nc -z mysql 3306; do   
    echo "waiting for godot..."
    sleep 1
done

echo "starting quarkus..."
pwd
ls -l
./application

