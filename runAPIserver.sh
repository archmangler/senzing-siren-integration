#!/bin/bash
set -ex
docker run -d -p 80:8888 --name senzing quay.io/engeneon/senzing:0.0.3
