#!/bin/sh
[ "$1" ] || {
echo "Specify Open vSwitch Version like '2.4.0':"
    exit 1
}
# Add version of OVS to Dockerfile
sed -i "s/ENV OVS_VERSION/ENV OVS_VERSION $1/" build_tarball/Dockerfile
# Add patches in patch directory to a patches file
cd build_tarball/patch && \
find . -type f -print > patches && \
cd ../..
# Build tarball
docker build -t tarmaker build_tarball || {
    echo "Something went wrong when building. Aborting."
    exit 1
}

docker run tarmaker cat /openvswitch-$1.tar.gz > build_tarball/openvswitch-$1.tar.gz
# We use cp rather than ln because ln doesn't work well on VBox shared folders.
cp build_tarball/openvswitch* .
# Reset OVS Version to nothing
sed -i "s/ENV OVS_VERSION $1/ENV OVS_VERSION/" build_tarball/Dockerfile
