# /bin/bash 
TIME=$(date "+%m-%d")
LOG_NAME="$TIME-build.log"
PRO_PATH="/mnt/nfsroot/jiming.cai/skyworth_server"
OPENJDK_7_PATH="/opt/java-7-openjdk-amd64/bin"
BUILD_LOG_PATH="$PRO_PATH/BuildLog"
cd $PRO_PATH

if [ $? != 0 ] ; then
echo "not in project path"
fi

if [ ! -d "$BUILD_LOG_PATH" ]; then
 mkdir -p $BUILD_LOG_PATH
fi

cd $BUILD_LOG_PATH
touch $LOG_NAME

echo -e "build in $TIME" > $BUILD_LOG_PATH/$LOG_NAME

cd $PRO_PATH

skyrepo forall -c git reset --hard HEAD >> $BUILD_LOG_PATH/$LOG_NAME
skyrepo sync -j8 >> $BUILD_LOG_PATH/$LOG_NAME

cd $PRO_PATH/build
git apply build.diff

cd $PRO_PATH
source build/envsetup.sh
lunch skyT920L_3A011-userdebug-32
make clean
#source /opt/choose_java_version.sh
export PATH=$OPENJDK_7_PATH:$PATH
make otapackage -j8
make otapackage -j8 >> $BUILD_LOG_PATH/$LOG_NAME
