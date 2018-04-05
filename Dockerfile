from centos:7.3.1611

MAINTAINER Ciro Ceissler <ciro.ceissler@gmail.com>

USER root

# install apps/libs
RUN yum install -y git \
  sudo \
  make \
  tmux \
  gcc \
  gcc-c++ \
  perl-Data-Dumper \
  libelf* \
  elfutils-libelf-devel \
  libffi \
  libffi-devel \
  libuuid-devel \
  libjson-c* \
  json-c-devel \
  boost-devel; \
  cd /tmp; \
  curl -O https://cmake.org/files/v3.8/cmake-3.8.2-Linux-x86_64.sh; \
  chmod 755 cmake-3.8.2-Linux-x86_64.sh; \
  ./cmake-3.8.2-Linux-x86_64.sh --skip-license --prefix=/usr/local; \
  rm /tmp/cmake-3.8.2-Linux-x86_64.sh

# install HardCloud
RUN git clone --recursive https://www.github.com/ciroceissler/hardcloud/ /tmp/hardcloud; \
  cd /tmp/hardcloud; \
  bash scripts/install.sh --prefix=/usr/local/; \
  cp -r /tmp/hardcloud/samples ~/samples/; \
  cp /tmp/hardcloud/scripts/setup.hardcloud ~/setup.hardcloud; \
  rm -rf /tmp/hardcloud

# install quartus
RUN cd tmp; \
  curl --retry 999 -O http://download.altera.com/akdlm/software/acdsinst/17.1/240/ib_installers/QuartusProSetup-17.1.0.240-linux.run \
  chmod +x QuartusProSetup-17.1.0.240-linux.run \
  ./QuartusProSetup-17.1.0.240-linux.run --installdir /opt/altera/17.1 --disable-components modelsim_ase --mode unattended --accept_eula 1 \
  rm -f /tmp/QuartusProSetup-17.1.0.240-linux.run

# install modelsim
RUN cd tmp; \
  curl --retry 999 -O http://download.altera.com/akdlm/software/acdsinst/17.1/240/ib_installers/ModelSimProSetup-17.1.0.240-linux.run \
  chmod +x ModelSimProSetup-17.1.0.240-linux.run \
  ./ModelSimProSetup-17.1.0.240-linux.run --installdir /opt/altera/17.1 --mode unattended --modelsim_edition modelsim_ae --accept_eula 1 \
  rm -f ModelSimProSetup-17.1.0.240-linux.run

# install i686 packages
RUN yum install -y libgcc.i686 \
  glibc-devel*i686 \
  libXft-devel*i686 \
  libXext-devel*i686 \
  ncurses-devel*i686

# libpng for the examples
RUN yum install libpng-devel

# taf!
