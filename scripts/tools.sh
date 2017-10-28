#!/bin/sh

echo '----------------------------------------------------------------------------'
echo 'Welcome to HardCloud - Tools Setup Wizard.'
echo ''
echo 'For more information about HardCloud, go to http://www.hardcloud.org.'
echo '----------------------------------------------------------------------------'

# read command line args
USER='sudo '
INSTALL_PATH='/opt/altera/16.0/'

for i in "$@"
do
case $i in
  -h|--help)
  echo ''
  echo 'Usage: bash scripts/install.sh [OPTION]'
  echo ''
  echo '-h  , --help         show arguments'
  echo '      --prefix=PATH  override default install location'
  echo '      --non-root     root user is not necessary to install the applications'
  exit 0
  shift # past argument=value
  ;;
  --prefix=*)
  INSTALL_PATH="${i#*=}"
  shift # past argument=value
  ;;
  --non-root)
  USER=''
  shift # past argument with no value
  ;;
  *)
  # unknown option
  echo ''
  echo 'scripts/tools.sh: invalid option!'
  echo ''
  echo "Try: 'bash scripts/tools.sh --help' for more information."
  exit 1
  ;;
esac
done

echo ''
echo '[tools] IntelFPGA Quartus 16.0'
echo ''

cd /tmp/
curl --retry 999 -O http://download.altera.com/akdlm/software/acdsinst/16.0/211/ib_tar/Quartus-16.0.0.211-linux.tar
tar xvf /tmp/Quartus-16.0.0.211-linux.tar
rm -f /tmp/Quartus-16.0.0.211-linux.tar
${USER} bash setup.sh --installdir ${INSTALL_PATH} --disable-components modelsim_ase --mode unattended

echo ''
echo '[tools] ModelSim Altera Edition 16.0'
echo ''

cd /tmp/components/
${USER} ./ModelSimSetup-16.0.0.211-linux.run --installdir ${INSTALL_PATH} --mode unattended --modelsim_edition modelsim_ae

echo ''
echo '[tools] clean'
echo ''

rm -rf /tmp/components/ /tmp/setup.sh tmp/readme.txt

# taf!
