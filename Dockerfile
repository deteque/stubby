FROM debian:buster-slim
LABEL maintainer="Andrew Fried <afried@deteque.com>"
ENV STUBBY_VERSION 0.2.5

RUN mkdir /etc/stubby \
	&& apt-get clean \
	&& apt-get update \
	&& apt-get -y dist-upgrade \
	&& apt-get install --no-install-recommends --no-install-suggests -y \
		ca-certificates \
		dnsutils \
		libssl-dev \
		net-tools \
		stubby \
		sysstat \
	&& sync \
	&& ldconfig 

COPY stubby.yml /etc/stubby

EXPOSE 53/udp
EXPOSE 53/tcp

CMD [ "/usr/bin/stubby","-C","/etc/stubby/stubby.yml" ]
