#!/bin/bash

set -e

#pull the docker image from Docker hub
docker pull pankaj1204/simple-python-flask-app:latest


docker run -d -p 5000:5000 pankaj1204/simple-python-flask-app:latest

