#!/bin/bash

npm install &&
    IMAGE=taf7lwappqystqp4u7wjsqkdc7dquw/stormyhook_jenkins_$(date +s) &&
    docker build -t ${IMAGE} . &&
    docker run -d --privileged -ti -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 8081:8080 ${IMAGE} &&
    ./node_modules/.bin/protractor protractor.conf.js &&
    true


