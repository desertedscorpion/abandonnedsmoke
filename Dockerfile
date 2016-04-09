FROM taf7lwappqystqp4u7wjsqkdc7dquw/grimdog_systemd
RUN dnf install --assumeyes jenkins && dnf clean all && systemctl enable jenkins.service
RUN dnf install --assumeyes npm nodejs curl
RUN mkdir /opt/thirdfrostbite
COPY src/thirdfrostbite/package.json /opt/thirdfrostbite
COPY src/thirdfrostbite/server.express.js /opt/thirdfrostbite
COPY src/thirdfrostbite/thirdfrostbite.service /usr/lib/systemd/system
RUN cd /opt/thirdfrostbite && npm install && curl -o /opt/thirdfrostbite/localizer-1.9.jar.zip http://www.java2s.com/Code/JarDownload/localizer/localizer-1.9.jar.zip && unzip -d /opt/thirdfrostbite /opt/thirdfrostbite/localizer-1.9.jar.zip && curl -o commons-codec-1.9.jar http://central.maven.org/maven2/commons-codec/commons-codec/1.9/commons-codec-1.9.jar 
RUN systemctl enable thirdfrostbite.service
RUN mkdir /opt/abandonnedleather
COPY src/abandonnedleather/application.html /opt/abandonnedleather
COPY src/abandonnedleather/application.js /opt/abandonnedleather
COPY src/abandonnedleather/bower.json /opt/abandonnedleather
COPY src/abandonnedleather/index.html /opt/abandonnedleather
COPY src/abandonnedleather/package.json /opt/abandonnedleather
EXPOSE 8080
EXPOSE 29615
CMD ["/usr/sbin/init"]
