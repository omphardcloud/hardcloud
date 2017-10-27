#!/bin/sh

echo '----------------------------------------------------------------------------'
echo 'Welcome to HardCloud Setup Wizard.'
echo ''
echo 'For more information about HardCloud, go to http://www.hardcloud.org.'
echo '----------------------------------------------------------------------------'

BASE_DIR=$PWD

# read command line args
USER='sudo '
INSTALL_PATH='/usr/local/'
JOBS=''

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
  echo '-j=N, --jobs=N       specifies the number of jobs to run simultaneously'
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
  -j=*|--jobs=*)
  JOBS="-j${i#*=}"
  shift # past argument=value
  ;;
  *)
  # unknown option
  echo ''
  echo 'scripts/install.sh: invalid option!'
  echo ''
  echo "Try: 'bash scripts/install.sh --help' for more information."
  exit 1
  ;;
esac
done

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
make ${JOBS}
echo ''
${IS_SUDO} make install
rm -rf ${BASE_DIR}/opae-sdk/build/
cd ${BASE_DIR}
${IS_SUDO} cp -r opae-sdk/ ${INSTALL_PATH}

echo ''
echo '[HardCloud] installing Intel BBB cci mpf'
echo ''

cd ${BASE_DIR}
mkdir intel-fpga-bbb/BBB_cci_mpf/sw/build
cd intel-fpga-bbb/BBB_cci_mpf/sw/build
cmake -DOPAELIB_INC_PATH=${INSTALL_PATH}/include \
  -DOPAELIB_LIBS_PATH=${INSTALL_PATH}/lib \
  -DCMAKE_INSTALL_PREFIX=${INSTALL_PATH} ..
make ${JOBS}
echo ''
${IS_SUDO} make install

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
make ${JOBS}
echo ''
${IS_SUDO} make install

# taf!
