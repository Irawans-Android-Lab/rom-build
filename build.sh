# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/LineageOS/android.git -b lineage-20.0 -g default,-mips,-darwin,-notdefault
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j16
git clone https://github.com/eartinity24/device_realme_r5x.git -b Los device/realme/r5x --depth=1
git clone https://github.com/mcdofrenchfreis/biofrost-kernel-realme-trinket.git -b inline/dynamic kernel/realme/r5x --depth=1
git clone https://github.com/eartinity24/vendor_realme_r5x.git -b thirteen vendor/realme/r5x --depth=1
git clone https://github.com/ArrowOS-Devices/android_prebuilts_clang_host_linux-x86_clang-r416183b1.git -b arrow-11.0 prebuilts/clang/host/linux-x86/clang-r416183b1 --depth=1

# build rom
source $CIRRUS_WORKING_DIR/script/config
timeStart

. build/envsetup.sh
lunch lineage_r5x-userdebug
mkfifo reading
tee "${BUILDLOG}" < reading &
build_message "Building Started"
progress &
brunch RMX1801 > reading & sleep 95m

retVal=$?
timeEnd
statusBuild
# end
