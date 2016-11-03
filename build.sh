#!/bin/bash

docker rmi chyld/dev
docker build -t chyld/dev .
