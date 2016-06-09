FROM rhel7

ADD http://dl.bintray.com/netty/downloads/netty-4.1.1.Final.tar.bz2 /tmp/netty.tar.bz2
RUN yum install -y tar bzip2 java-1.8.0-openjdk && yum clean all && mkdir /srv/netty && tar -xvf /tmp/netty.tar.bz2 -C /srv/netty --strip 1 && chmod -R 777 /srv/netty

EXPOSE 8992

USER 1001

CMD java -cp '/srv/netty/jar/*' io.netty.example.securechat.SecureChatServer
