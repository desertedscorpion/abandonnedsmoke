#!/bin/bash

cd $(mktemp -d) &&
    ssh-keygen -f /usr/local/src/ssh/bLapOgpy_id_rsa -C "jenkins 2 slave" -P "" &&
    chown jenkins:jenkins /usr/local/src/ssh/bLapOgpy_id_rsa &&
    cp /usr/local/src/ssh/credentials.xml /var/lib/jenkins &&
    chown jenkins:jenkins /var/lib/jenkins/credentials.xml &&
    mkdir /home/slave/.ssh &&
    chmod 0700 /home/slave/.ssh &&
    cat /usr/local/src/ssh/bLapOgpy_id_rsa.pub > /home/slave/.ssh/authorized_keys &&
    chmod 0600 /home/slave/.ssh/authorized_keys &&
    cat /usr/local/src/ssh/config > /home/slave/.ssh/config &&
    chmod 0600 /home/slave/.ssh/config &&
    cat /usr/local/src/private/xSGyYmpH_id_rsa > /home/slave/.ssh/xSGyYmpH_id_rsa &&
    chmod 0600 /home/slave/.ssh/xSGyYmpH_id_rsa &&
    chown --recursive slave:slave /home/slave/.ssh &&
    rm /run/nologin &&
    curl http://www.java2s.com/Code/JarDownload/localizer/localizer-1.9.jar.zip > localizer-1.9.jar.zip &&
    unzip localizer-1.9.jar.zip &&
    curl http://central.maven.org/maven2/commons-codec/commons-codec/1.9/commons-codec-1.9.jar > commons-code-1.9.jar &&
    export CLASSPATH=/usr/share/jenkins/webroot/WEB-INF/jenkins-cli.jar:/usr/share/jenkins/webroot/WEB-INF/remoting.jar:/usr/share/jenkins/webroot/WEB-INF/slave.jar:/usr/share/jenkins/webroot/WEB-INF/classes:localizer-1.9.jar:commons-code-1.9.jar:localizer-1.9.jar &&
    while ! java hudson.cli.CLI -s http://localhost:8080 help
    do
	sleep 1m &&
	    true
    done &&
    echo INSTALLING PLUGINS &&
    java hudson.cli.CLI -s http://localhost:8080 install-plugin greenballs &&
    java hudson.cli.CLI -s http://localhost:8080 install-plugin jobConfigHistory &&
    java hudson.cli.CLI -s http://localhost:8080 install-plugin ghprb &&
    java hudson.cli.CLI -s http://localhost:8080 install-plugin gitlab-plugin &&
    java hudson.cli.CLI -s http://localhost:8080 install-plugin github &&
    java hudson.cli.CLI -s http://localhost:8080 install-plugin git-tag-message &&
    java hudson.cli.CLI -s http://localhost:8080 install-plugin gitlab-logo &&
    java hudson.cli.CLI -s http://localhost:8080 install-plugin gitlab-merge-request-jenkins &&
    java hudson.cli.CLI -s http://localhost:8080 install-plugin git &&
    java hudson.cli.CLI -s http://localhost:8080 install-plugin docker-build-step &&
    java hudson.cli.CLI -s http://localhost:8080 install-plugin docker-plugin &&
    java hudson.cli.CLI -s http://localhost:8080 install-plugin kubernetes &&
    java hudson.cli.CLI -s http://localhost:8080 install-plugin docker-commons &&
    java hudson.cli.CLI -s http://localhost:8080 install-plugin amazon-ecr &&
    java hudson.cli.CLI -s http://localhost:8080 install-plugin amazon-ecs &&
    java hudson.cli.CLI -s http://localhost:8080 install-plugin DotCi-DockerPublish &&
    java hudson.cli.CLI -s http://localhost:8080 install-plugin google-container-registry-auth &&
    java hudson.cli.CLI -s http://localhost:8080 install-plugin yet-another-docker-plugin &&
    java hudson.cli.CLI -s http://localhost:8080 safe-restart &&
    sleep 1m &&
    java hudson.cli.CLI -s http://localhost:8080 safe-restart &&
    echo INSTALLING JOBS &&
    for FILE in /usr/local/src/jobs/*.xml
    do
	sleep 1m &&
	cat ${FILE} | java hudson.cli.CLI -s http://localhost:8080 create-job $(basename ${FILE%.*}) &&
	    true
    done &&
    echo INSTALLING NODES &&
    for FILE in /usr/local/src/nodes/*.xml
    do
	cat ${FILE} | java hudson.cli.CLI -s http://localhost:8080 create-node $(basename ${FILE%.*}) &&
	    true
    done &&
    java hudson.cli.CLI -s http://localhost:8080 safe-restart &&
    sleep 1m &&
    echo RUNNING INIT JOBS &&
    java hudson.cli.CLI -s http://localhost:8080 build init-git &&
    sleep 1m &&
    java hudson.cli.CLI -s http://localhost:8080 build init-vagrant-aws &&
    sleep 1m &&
    java hudson.cli.CLI -s http://localhost:8080 build init-vagrant-scp &&
    sleep 1m &&
    java hudson.cli.CLI -s http://localhost:8080 safe-restart &&
    sleep 1m &&
    echo RUNNING TEST JOBS &&
    java hudson.cli.CLI -s http://localhost:8080 build test &&
    sleep 1m &&
    java hudson.cli.CLI -s http://localhost:8080 build desertedscorpion-strawsound &&
    sleep 1m &&
    java hudson.cli.CLI -s http://localhost:8080 safe-restart &&
    echo "ENJOY!!!!!!!!" &&
    true
