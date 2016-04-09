FROM taf7lwappqystqp4u7wjsqkdc7dquw/grimdog_systemd
RUN dnf install --assumeyes jenkins && dnf clean all && systemctl enable jenkins.service
RUN dnf install --assumeyes npm nodejs
RUN mkdir /opt/thirdfrostbite
COPY src/thirdfrostbite/package.json /opt/thirdfrostbite
COPY src/thirdfrostbite/server.express.js /opt/thirdfrostbite
RUN cd /opt/thirdfrostbite && npm install --production && npm start
EXPOSE 8080
EXPOSE 29615
CMD ["/usr/sbin/init"]
