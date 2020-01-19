FROM debian:buster-slim
LABEL maintainer="Andrew Fried <afried@deteque.com>"
ENV STUBBY_VERSION 0.3.0-rc.1

RUN mkdir /etc/stubby \
	&& apt-get clean \
	&& apt-get update \
	&& apt-get -y dist-upgrade \
	&& apt-get install --no-install-recommends --no-install-suggests -y \
		build-essential \
		ca-certificates \
		cmake \
		dnsutils \
		git \
		libgetdns-dev \
		libssl-dev \
		libyaml-dev \
		net-tools \
		sysstat \
	&& sync \
	&& ldconfig 

WORKDIR /root
RUN	/usr/bin/git clone https://github.com/getdnsapi/stubby.git
WORKDIR /root/stubby
RUN	cmake . \
	&& make \
	&& mv stubby /usr/bin/ \
	&& mv stubby.yml.example /etc/stubby

COPY stubby.yml /etc/stubby
COPY start-docker-stubby.sh /root/scripts/

EXPOSE 53/udp
EXPOSE 53/tcp

CMD [ "/usr/sbin/stubby","-C","/etc/stubby/stubby.yml" ]
