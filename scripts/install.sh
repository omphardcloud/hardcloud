#!/bin/sh

echo '----------------------------------------------------------------------------'
echo 'Welcome to HardCloud Setup Wizard.'
echo ''
echo 'For more information about HardCloud, go to http://www.hardcloud.org.'
echo '----------------------------------------------------------------------------'

BASE_DIR=$PWD

if [ $1 ]
then
  INSTALL_PATH=$1
else
  echo ''
  read -p "Installation Directory[/usr/local/]: " x

  if [ $x ]
  then
    INSTALL_PATH=$x
  else
    INSTALL_PATH='/usr/local/'
  fi
fi

echo ''
echo '[HardCloud] checking libraries'
echo ''

check_lib() {
  LIB_FILE=$1.'so'
  CHECK=$(ldconfig -p | grep ${LIB_FILE})

  if [[ ${CHECK} != *${LIB_FILE}* ]]
  then
    tput setaf 1; echo '[HardCloud][error] '${LIB_FILE}' is not installed!'
    exit 1
  fi
}

check_lib libuuid
check_lib libjson-c
check_lib libboost_program_options
check_lib libelf
check_lib libffi

echo ''
echo '[HardCloud] installing Intel OPAE SDK'
echo ''

cd ${BASE_DIR}
mkdir opae-sdk/build
cd opae-sdk/build
cmake -DBUILD_ASE=1 -DCMAKE_INSTALL_PREFIX=${INSTALL_PATH} ..
make
echo ''
sudo make install

echo ''
echo '[HardCloud] installing Intel BBB cci mpf'
echo ''

cd ${BASE_DIR}
mkdir intel-fpga-bbb/BBB_cci_mpf/sw/build
cd intel-fpga-bbb/BBB_cci_mpf/sw/build
cmake -DOPAELIB_INC_PATH=${INSTALL_PREFIX}/include \
  -DOPAELIB_LIBS_PATH=${INSTALL_PREFIX}/lib \
  -DCMAKE_INSTALL_PREFIX=${INSTALL_PATH} ..
make
echo ''
sudo make install

echo''
echo '[HardCloud] installing LLVM/Clang LSC-OpenMP'
echo''

cd $BASE_DIR

# create sym links
ln -s $BASE_DIR/clang  llvm/tools/
ln -s $BASE_DIR/openmp llvm/projects/

mkdir llvm/build
cd llvm/build
cmake -DOPENMP_ENABLE_LIBOMPTARGET=ON \
  -DCMAKE_BUILD_TYPE="release" \
  -DOPAE=${INSTALL_PATH}/ \
  -DBBB_CCI_MPF=${INSTALL_PATH} \
  -DCMAKE_INSTALL_PREFIX=${INSTALL_PATH} ..
make
echo ''
sudo make install

# taf!
