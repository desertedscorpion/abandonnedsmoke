#!/bin/bash


docker run -d --privileged -ti -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 8080:8080 taf7lwappqystqp4u7wjsqkdc7dquw/grimdog_jenkins
