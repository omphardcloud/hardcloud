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
  curl --retry 999 -O http://download.altera.com/akdlm/software/acdsinst/16.0/211/ib_tar/Quartus-16.0.0.211-linux.tar; \
  tar xvf /tmp/Quartus-16.0.0.211-linux.tar; \
  rm -f /tmp/Quartus-16.0.0.211-linux.tar; \
  bash setup.sh --installdir /opt/altera/16.0/ --disable-components modelsim_ase --mode unattended; \
  cd /tmp/components/; \
  ./ModelSimSetup-16.0.0.211-linux.run --installdir /opt/altera/16.0 --mode unattended --modelsim_edition modelsim_ae; \
  rm -rf /tmp/components/ /tmp/setup.sh tmp/readme.txt

# install i686 packages
RUN yum install -y libgcc.i686 \
  glibc-devel*i686 \
  libXft-devel*i686 \
  libXext-devel*i686 \
  ncurses-devel*i686

# taf!
