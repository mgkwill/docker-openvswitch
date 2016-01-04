FROM alpine:3.2
MAINTAINER OpenDaylight OVSDB Project Team <ovsdb-dev@lists.opendaylight.org>
ENV OVS_VERSION 2.4.0
ENV SUPERVISOR_STDOUT_VERSION 0.1.1
# Update alpine and install Open vSwitch Dependencies
RUN apk update && apk upgrade && \
        apk add openssl && \
        apk add supervisor && \
	rm -rf /var/cache/apk/*
# Configure supervisord
ADD supervisord.conf /etc/
# Install supervisor_stdout
WORKDIR /opt
RUN mkdir -p /var/log/supervisor && \
	mkdir -p /etc/openvswitch && \
	mkdir -p /usr/local/var/run/openvswitch && \
	mkdir -p /var/log/supervisor/
RUN wget https://pypi.python.org/packages/source/s/supervisor-stdout/supervisor-stdout-$SUPERVISOR_STDOUT_VERSION.tar.gz && \
	tar -xzvf supervisor-stdout-0.1.1.tar.gz && \
	mv supervisor-stdout-$SUPERVISOR_STDOUT_VERSION supervisor-stdout && \
	rm supervisor-stdout-0.1.1.tar.gz && \
	cd supervisor-stdout && \
	python setup.py install -q
# Get Open vSwitch
WORKDIR /
COPY openvswitch-$OVS_VERSION.tar.gz /
RUN tar -xzvf openvswitch-$OVS_VERSION.tar.gz && \
	rm openvswitch-$OVS_VERSION.tar.gz
ADD configure-ovs.sh /usr/local/share/openvswitch/
# Create the database
RUN ovsdb-tool create /etc/openvswitch/conf.db /usr/local/share/openvswitch/vswitch.ovsschema
# Put the OVS Python modules on the Python Path
RUN cp -r /usr/local/share/openvswitch/python/ovs /usr/lib/python2.7/site-packages/ovs
CMD ["/usr/bin/supervisord"]
