#!/bin/sh

echo $DOCKER_PASSWORD | docker login -u $DOCKER_USER --password-stdin && \
git clone https://github.com/$1 ./repo && \
cd repo && \
docker build . -t $DOCKER_USER/$2 && \
docker push $DOCKER_USER/$2
