echo This will patch boot image with magisk
echo Press Yes if you also want to flash it

PARENT_DIR= $(dirname "$0")/..

cd "$PARENT_DIR/bin"

./boot_patch.sh


