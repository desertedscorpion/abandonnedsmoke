FROM taf7lwappqystqp4u7wjsqkdc7dquw/grimdog_systemd
RUN dnf install --assumeyes jenkins && dnf clean all && systemctl enable jenkins.service && systemctl enable sshd.service
RUN adduser slave
EXPOSE 8080
CMD ["/usr/sbin/init"]
