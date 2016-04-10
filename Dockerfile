FROM taf7lwappqystqp4u7wjsqkdc7dquw/grimdog_systemd
RUN dnf install --assumeyes jenkins && dnf clean all && systemctl enable jenkins.service
RUN dnf install --assumeyes npm nodejs curl git
RUN mkdir /opt/thirdfrostbite
RUN echo '{ "allow_root": true }' > /root/.bowerrc
COPY src/thirdfrostbite/thirdfrostbite.service /usr/lib/systemd/system
RUN systemctl enable thirdfrostbite.service
RUN mkdir /opt/thirdfrostbite/client
COPY src/thirdfrostbite/client/application.html /opt/thirdfrostbite/client
COPY src/thirdfrostbite/client/application.js /opt/thirdfrostbite/client
COPY src/thirdfrostbite/client/bower.json /opt/thirdfrostbite/client
COPY src/thirdfrostbite/client/index.html /opt/thirdfrostbite/client
COPY src/thirdfrostbite/client/package.json /opt/thirdfrostbite/client
RUN cd /opt/thirdfrostbite/client && npm install && ./node_modules/.bin/bower install
RUN mkdir /opt/thirdfrostbite/server
COPY src/thirdfrostbite/server/package.json /opt/thirdfrostbite/server
COPY src/thirdfrostbite/server/server.express.js /opt/thirdfrostbite/server
RUN cd /opt/thirdfrostbite/server && npm install && curl -o /opt/thirdfrostbite/localizer-1.9.jar.zip http://www.java2s.com/Code/JarDownload/localizer/localizer-1.9.jar.zip && unzip -d /opt/thirdfrostbite /opt/thirdfrostbite/localizer-1.9.jar.zip && curl -o /opt/thirdfrostbite/commons-codec-1.9.jar http://central.maven.org/maven2/commons-codec/commons-codec/1.9/commons-codec-1.9.jar
EXPOSE 8080
EXPOSE 29615
CMD ["/usr/sbin/init"]
