#!/bin/bash

echo "ok"


repo init -u gitolite@10.28.8.56:/tv/customer/x32a0/platform/manifest.git -b p-amlogic -m amlogic_aosp_sdk_x32a0.xml --repo-url=ssh://git@10.18.11.25/tools/repo.git

repo sync -j16

repo sync -j16

source build/envsetup.sh

lunch x32a0-userdebug

make otapackage -j16

make otapackage -j16
