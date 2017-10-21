#!/bin/sh

echo '----------------------------------------------------------------------------'
echo 'Welcome to HardCloud Setup Wizard.'
echo ''
echo 'For more information about HardCloud, go to http://www.hardcloud.org.'
echo '----------------------------------------------------------------------------'
echo ''
read -p "Installation Directory[/usr/local/]: " x
echo ''

BASE_DIR=$PWD

if [ $x ]
then
  INSTALL_PATH=$x
else
  INSTALL_PATH='/usr/local/'
fi

echo '[HardCloud] checking libraries'
echo ''

CHECK_LIBUUID=$(ldconfig -p | grep 'libuuid.so$')
CHECK_LIBJSON_C=$(ldconfig -p | grep 'libjson-c.so$')
CHECK_LIBBOOST_PROGRAM_OPTIONS=$(ldconfig -p | grep 'libboost_program_options.so$')

if [[ ${CHECK_LIBUUID} != *'libuuid.so'* ]]
then
  tput setaf 1; echo '[HardCloud][error] libuuid.so is not installed!'
  exit 1
fi

if [[ ${CHECK_LIBJSON_C} != *'libjson-c.so'* ]]
then
  tput setaf 1; echo '[HardCloud][error] libjson-c.so is not installed!'
  exit 1
fi

if [[ ${CHECK_LIBBOOST_PROGRAM_OPTIONS} != *'libboost_program_options'* ]]
then
  tput setaf 1; echo '[HardCloud][error] libboost_program_options.so is not installed!'
  exit 1
fi

echo ''
echo '[HardCloud] installing Intel BBB cci mpf'
echo ''

cd ${BASE_DIR}
mkdir intel-fpga-bbb/BBB_cci_mpf/sw/build
cd intel-fpga-bbb/BBB_cci_mpf/sw/build
cmake -DCMAKE_INSTALL_PREFIX=${INSTALL_PATH} ..
make
echo ''
sudo make install

echo ''
echo '[HardCloud] installing Intel OPAE SDK'
echo ''

cd ${BASE_DIR}
mkdir opae-sdk/build
cd opae-sdk/build
cmake -DCMAKE_INSTALL_PREFIX=${INSTALL_PATH} ..
make
echo ''
sudo make install

echo '\n[HardCloud] installing LLVM/Clang LSC-OpenMP\n'

cd $BASE_DIR

# create sym links
ln -s $BASE_DIR/clang  llvm/tools/
ln -s $BASE_DIR/openmp llvm/projects/

mkdir llvm/build
cd llvm/build
cmake -DOPENMP_ENABLE_LIBOMPTARGET=ON -DCMAKE_BUILD_TYPE="release" -DCMAKE_INSTALL_PREFIX={INSTALL_PATH} ..
make
sudo make install

# taf!
