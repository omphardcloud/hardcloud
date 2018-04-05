#!/bin/sh

echo '----------------------------------------------------------------------------'
echo 'Welcome to HardCloud - Tools Setup Wizard.'
echo ''
echo 'For more information about HardCloud, go to http://www.hardcloud.org.'
echo '----------------------------------------------------------------------------'

# read command line args
USER='sudo '
INSTALL_PATH='/opt/altera/17.1/'

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
echo '[tools] IntelFPGA Quartus 17.1'
echo ''

cd /tmp/
curl --retry 999 -O http://download.altera.com/akdlm/software/acdsinst/17.1/240/ib_installers/QuartusProSetup-17.1.0.240-linux.run
chmod +x QuartusProSetup-17.1.0.240-linux.run
${USER} ./QuartusProSetup-17.1.0.240-linux.run --installdir ${INSTALL_PATH} --disable-components modelsim_ase --mode unattended --accept_eula 1
rm -f /tmp/QuartusProSetup-17.1.0.240-linux.run

echo ''
echo '[tools] ModelSim Altera Edition 17.1'
echo ''
cd /tmp/
curl --retry 999 -O http://download.altera.com/akdlm/software/acdsinst/17.1/240/ib_installers/ModelSimProSetup-17.1.0.240-linux.run
chmod +x ModelSimProSetup-17.1.0.240-linux.run
${USER} ./ModelSimProSetup-17.1.0.240-linux.run --installdir ${INSTALL_PATH} --mode unattended --modelsim_edition modelsim_ae --accept_eula 1
rm -f ModelSimProSetup-17.1.0.240-linux.run

echo ''
echo '[tools] clean'
echo ''

rm -rf /tmp/components/ /tmp/setup.sh tmp/readme.txt

# taf!
