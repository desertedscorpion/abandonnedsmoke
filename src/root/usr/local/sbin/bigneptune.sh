#!/bin/bash

cd $(mktemp -d) &&
    curl http://www.java2s.com/Code/JarDownload/localizer/localizer-1.9.jar.zip > localizer-1.9.jar.zip &&
    unzip localizaer-1.9.jar.zip &&
    curl http://central.maven.org/maven2/commons-codec/commons-codec/1.9/commons-codec-1.9.jar > commons-code-1.9.jar &&
    export CLASSPATH=/usr/share/jenkins/webroot/WEB-INF/jenkins-cli.jar:/usr/share/jenkins/webroot/WEB-INF/remoting.jar:/usr/share/jenkins/webroot/WEB-INF/slave.jar:/usr/share/jenkins/webroot/WEB-INF/classes:localizer-1.9.jar:commons-code-1.9.jar:localizer-1.9.jar &&
    java hudson.cli.CLI -s http://localhost:8080 install-plugin greenballs &&
    java hudson.cli.CLI -s http://localhost:8080 safe-restart &&
    true
