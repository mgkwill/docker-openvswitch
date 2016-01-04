FROM alpine:3.2
# Populated by mkovs_tarball.sh
ENV OVS_VERSION 2.3.2
# Workaround build warning related to 'tput'.
ENV TERM dumb
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
# Update alpine and install OVS
RUN apk update && apk upgrade
RUN apk add alpine-sdk && \
	apk add linux-headers && \
	apk add gcc && \
 	apk add make && \
 	apk add automake && \
 	apk add autoconf  && \
 	apk add libtool && \
 	apk add openssl-dev && \
	apk add clang && \
	apk add python && \
	apk add wget && \
	apk add tar && \
	apk add bash && \
	apk add patch && \
	rm -rf /var/cache/apk/*
# Let's make wget output a bit less verbose.
RUN echo progress = dot:mega > /.wgetrc
RUN wget http://openvswitch.org/releases/openvswitch-$OVS_VERSION.tar.gz
RUN tar -zxf openvswitch-$OVS_VERSION.tar.gz && \
	rm openvswitch-$OVS_VERSION.tar.gz
# This symlink is because WORKDIR doesn't expand $VARS.
RUN ln -s openvswitch-$OVS_VERSION openvswitch
WORKDIR /openvswitch
RUN mkdir build && \
	mkdir build/output && \
	mkdir build/output/install && \
	mkdir build/output/images
ADD build_tarball.sh /opt/
ADD patch/ /openvswitch/
# Following patches only apply to 2.4.0 and 2.3.0+ 
# In other cases we don't care about failure to apply
RUN patch -p1 | cat patches || return 0
#RUN patch -p1 < musl-if_packet.patch || return 0
#RUN patch -p1 < 0001-ovs-thread-Set-stacksize-to-1M.patch || return 0
RUN /opt/build_tarball.sh
RUN ln -s /openvswitch/build/output/images/openvswitch-$OVS_VERSION.tar.gz /openvswitch-$OVS_VERSION.tar.gz
