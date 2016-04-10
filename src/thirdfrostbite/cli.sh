#!/bin/bash

export CLASSPATH=/opt/thirdfrostbite/localizer-1.9.jar:/opt/thirdfrostbite/commons-codec-1.9.jar:/usr/share/jenkins/webroot/WEB-INF/jenkins-cli.jar:/usr/share/jenkins/webroot/WEB-INF/remoting.jar:/usr/share/jenkins/webroot/WEB-INF/slave.jar:/usr/share/jenkins/webroot/WEB-INF/classes:localizer-1.9.jar &&
    java hudson.cli.CLI -s http://localhost:8080 "${@}"
