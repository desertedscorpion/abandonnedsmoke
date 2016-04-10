FROM taf7lwappqystqp4u7wjsqkdc7dquw/grimdog_systemd
RUN dnf install --assumeyes jenkins && dnf clean all && systemctl enable jenkins.service
COPY src/thirdfrostbite/cli.sh /opt/thirdfrostbite/cli
RUN dnf install --assumeyes curl && chmod 0005 /opt/thirdfrostbite/cli && mkdir /opt/thirdfrostbite && curl -o /opt/thirdfrostbite/localizer-1.9.jar.zip http://www.java2s.com/Code/JarDownload/localizer/localizer-1.9.jar.zip && unzip -d /opt/thirdfrostbite /opt/thirdfrostbite/localizer-1.9.jar.zip && curl -o /opt/thirdfrostbite/commons-codec-1.9.jar http://central.maven.org/maven2/commons-codec/commons-codec/1.9/commons-codec-1.9.jar
EXPOSE 8080
CMD ["/usr/sbin/init"]
