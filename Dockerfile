FROM grimdog_systemd
RUN dnf install jenkins.service; dnf clean all; systemctl enable jenkins.service
EXPOSE 80
CMD["/usr/bin/init"]
