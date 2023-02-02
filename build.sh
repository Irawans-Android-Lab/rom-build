# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/LineageOS/android.git -b lineage-20.0 -g default,-mips,-darwin,-notdefault
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j16
git clone https://github.com/Irawans-Android-Lab/device_realme_RMX1801.git -b lineage-20.0 device/realme/RMX1801 --depth=1
git clone https://github.com/Irawans-Android-Lab/kernel_realme_sdm660.git kernel/realme/sdm660 --depth=1
git clone https://github.com/Irawans-Android-Lab/vendor_realme.git -b lineage-20.0 vendor/realme --depth=1
git clone https://scm.osdn.net/gitroot/gengkapak/clang-GengKapak.git prebuilts/clang/host/linux-x86/gengkapak-clang --depth=1

# build rom
source $CIRRUS_WORKING_DIR/script/config
timeStart

. build/envsetup.sh
lunch lineage_RMX1801-userdebug
mkfifo reading
tee "${BUILDLOG}" < reading &
build_message "Building Started"
progress &
brunch RMX1801 > reading & sleep 95m

retVal=$?
timeEnd
statusBuild
# end
