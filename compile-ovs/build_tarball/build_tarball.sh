#!/bin/bash

# Script Config Options
# Set OVS_VERSION in Environment
# OVS_VERSION
BUILD_DEST_DIR="/openvswitch/build"
BUILD_INSTALL_DIR="$BUILD_DEST_DIR/output/install"
TAR_DEST_DIR="$BUILD_DEST_DIR/output/images"
CONFIG_OPTIONS=""
FILE_LST_DEST_DIR="$BUILD_DEST_DIR/ovs-build-files$OVS_VERSION.lst"

# Script Actions
echo	"-------> Configuring OVS Build with -- $CONFIG_OPTIONS "
./configure $CONFIG_OPTIONS
echo	"-------> Cleaning OVS Build DIR "
make clean
echo	"-------> Building OVS with -- $CONFIG_OPTIONS "
make
echo	"-------> Installing OVS Build to -- $TAR_DEST_DIR "
make DESTDIR=$BUILD_INSTALL_DIR install
echo	"-------> Creating OVS Build file list at -- $FILE_LST_DEST_DIR "
cd $BUILD_INSTALL_DIR
find . -type f -print > $FILE_LST_DEST_DIR
echo	"-------> Creating OVS Build tarball -- $TAR_DEST_DIR/openvswitch-$OVS_VERSION.tar.gz "
ls -al $TAR_DEST_DIR/
tar zcvf $TAR_DEST_DIR/openvswitch-$OVS_VERSION.tar.gz `cat $FILE_LST_DEST_DIR`
