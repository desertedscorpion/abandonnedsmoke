FROM grimdog_systemd
RUN dnf update --assumeyes; dnf clean all; systemctl enable jenkins.service
RUN dnf jenkins
