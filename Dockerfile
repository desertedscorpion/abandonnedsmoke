FROM taf7lwappqystqp4u7wjsqkdc7dquw/grimdog_systemd
RUN dnf install --assumeyes jenkins git vagrant openssh-server tar npm nodejs docker make && dnf clean all && systemctl enable jenkins.service && systemctl enable sshd.service
RUN adduser slave
COPY src/root/usr/lib/systemd/system/abandonnedsmoke.service /usr/lib/systemd/system
COPY src/root/usr/local/src /usr/local/src
COPY src/root/usr/local/sbin/abandonnedsmoke.sh /usr/local/sbin
RUN chmod 0500 /usr/local/sbin/abandonnedsmoke.sh
RUN systemctl enable abandonnedsmoke.service
EXPOSE 8080
CMD ["/usr/sbin/init"]
