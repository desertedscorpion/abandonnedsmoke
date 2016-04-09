FROM taf7lwappqystqp4u7wjsqkdc7dquw/grimdog_systemd
RUN dnf install --assumeyes jenkins && dnf clean all && systemctl enable jenkins.service
RUN dnf install --assumeyes npm nodejs
RUN mkdir /opt/thirdfrostbite
COPY src/thirdfrostbite/package.json /opt/thirdfrostbite
COPY src/thirdfrostbite/server.express.js /opt/thirdfrostbite
COPY src/thirdfrostbite/thirdfrostbite.service /usr/lib/systemd/system
RUN cd /opt/thirdfrostbite && npm install
RUN systemctl enable thirdfrostbite.service
EXPOSE 8080
EXPOSE 29615
CMD ["/usr/sbin/init"]
