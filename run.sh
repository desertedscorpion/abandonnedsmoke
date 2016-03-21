#!/bin/bash

docker build -t taf7lwappqystqp4u7wjsqkdc7dquw/grimdog_jenkins . &&
    docker ps &&
    read -p "PID? " PID &&
    docker stop ${PID} &&
    docker run -d --privileged -ti -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 8080:8080 taf7lwappqystqp4u7wjsqkdc7dquw/grimdog_jenkins &&
    git clean -n -d &&
    git diff &&
    git commit -a &&
    docker push taf7lwappqystqp4u7wjsqkdc7dquw/grimdog_jenkins &&
    true
