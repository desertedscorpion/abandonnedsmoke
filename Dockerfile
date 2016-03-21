FROM taf7lwappqystqp4u7wjsqkdc7dquw/grimdog_systemd
RUN dnf install --assumeyes jenkins git vagrant  && dnf clean all && systemctl enable jenkins.service
COPY src/root/usr/lib/systemd/system/bigneptune.service /usr/lib/systemd/system
COPY src/root/usr/local/src /usr/local/src
COPY src/root/usr/local/sbin/bigneptune.sh /usr/local/sbin
RUN chmod 0500 /usr/local/sbin/bigneptune.sh
RUN systemctl enable bigneptune.service
EXPOSE 8080
CMD ["/usr/sbin/init"]
