#!/bin/bash

vagrant plugin install vagrant-aws &&
    vagrant box add dummy https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box &&
    cd $(mktemp -d) &&
    curl http://www.java2s.com/Code/JarDownload/localizer/localizer-1.9.jar.zip > localizer-1.9.jar.zip &&
    unzip localizer-1.9.jar.zip &&
    curl http://central.maven.org/maven2/commons-codec/commons-codec/1.9/commons-codec-1.9.jar > commons-code-1.9.jar &&
    export CLASSPATH=/usr/share/jenkins/webroot/WEB-INF/jenkins-cli.jar:/usr/share/jenkins/webroot/WEB-INF/remoting.jar:/usr/share/jenkins/webroot/WEB-INF/slave.jar:/usr/share/jenkins/webroot/WEB-INF/classes:localizer-1.9.jar:commons-code-1.9.jar:localizer-1.9.jar &&
    while ! java hudson.cli.CLI -s http://localhost:8080 help
    do
	sleep 1m &&
	    true
    done &&
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
    cat /usr/local/src/jobs/test.xml | java hudson.cli.CLI -s http://localhost:8080 create-job xxx &&    
    cat /usr/local/src/jobs/mooncloudy.xml | java hudson.cli.CLI -s http://localhost:8080 create-job mooncloudy &&    
    cat /usr/local/src/jobs/init-ssh.xml | java hudson.cli.CLI -s http://localhost:8080 create-job init-ssh &&    
    cat /usr/local/src/jobs/cli-x.xml | java hudson.cli.CLI -s http://localhost:8080 create-job cli-x &&    
    cat /usr/local/src/nodes/xxx.xml | sed -e "s#172.31.32.161#$(curl http://instance-data/latest/meta-data/local-ipv4)#" | java hudson.cli.CLI -s http://localhost:8080 create-node xxx &&    
    java hudson.cli.CLI -s http://localhost:8080 safe-restart &&
    true
