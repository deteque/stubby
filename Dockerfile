FROM debian:buster-slim
LABEL maintainer="Andrew Fried <afried@deteque.com>"
LABEL build_date="2021-06-06"
ENV STUBBY_VERSION 0.2.5

RUN mkdir /etc/stubby \
	&& apt-get clean \
	&& apt-get update \
	&& apt-get -y dist-upgrade \
	&& apt-get install --no-install-recommends --no-install-suggests -y \
		ca-certificates \
		dnsutils \
		libssl-dev \
		libyaml-dev \
		net-tools \
		stubby \
		sysstat \
	&& sync \
	&& ldconfig 

COPY stubby.yml /etc/stubby
COPY stubby.yml.DISTRIBUTION /etc/stubby
COPY start-docker-stubby.sh /root/scripts/

EXPOSE 53/udp
EXPOSE 53/tcp

CMD [ "/usr/sbin/stubby","-C","/etc/stubby/stubby.yml" ]
