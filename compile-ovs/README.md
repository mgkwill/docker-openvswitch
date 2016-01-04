docker-openvswitch-compileovs
==============

This tarball is created using docker to compile OVS for running OVS in a docker container.

## Building this tarball

The build process is borrowed from [jpetazzo/busybox](https://github.com/jpetazzo/docker-busybox)

    ./mkrootfs tarmaker-buildroot
    # Wait an hour
    docker build -t socketplane/busybox .
 
