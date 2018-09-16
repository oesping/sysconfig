#!/bin/bash
 
# module load cmake/3.4.3
 
export SW_NAME=geant4
export PACKAGE_VERSION=10.04
export PACKAGE_NAME=$SW_NAME.$PACKAGE_VERSION
export PACKAGE_DIR=/opt/geant4
export PACKAGE_FILE=$PACKAGE_DIR/$PACKAGE_NAME.tar.gz
export URL=http://geant4.cern.ch/support/source/$PACKAGE_NAME.tar.gz
export INSTALL_DIR=/opt/$SW_NAME
 
export MAKE_PROCESSES=4     # Change according to your wish :-)
 
if [ ! -d $PACKAGE_DIR ]; then
    mkdir -p $PACKAGE_DIR
fi
 
cd $PACKAGE_DIR
if [ ! -f $PACKAGE_FILE ]; then
    wget $URL
fi
 
export BUILD_DIR=`mktemp -d`
cd $BUILD_DIR
echo $PACKAGE_FILE
file $PACKAGE_FILE
tar vxf $PACKAGE_FILE
 
mkdir build
cd build
##using cmake3 
cmake3 -DGEANT4_USE_GDML=ON -DCMAKE_BUILD_TYPE=Debug -DGEANT4_USE_OPENGL_X11=ON -DGEANT4_USE_XM=ON -DGEANT4_FORCE_QT4=ON -DGEANT4_USE_QT=ON -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR -DGEANT4_BUILD_MULTITHREADED=ON -DGEANT4_INSTALL_DATA=ON  ../$PACKAGE_NAME
 
make -j$MAKE_PROCESSES install && rm -rf $BUILD_DIR
