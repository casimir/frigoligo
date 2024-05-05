#!/bin/bash -e

SCRIPT_PATH="$(readlink -f $0)"
TPS_DIR="$(dirname $SCRIPT_PATH)"

if [ ! -d "$PUB_CACHE" ]; then
  echo "PUB_CACHE not set"
  exit 1
fi

echo "> Building Isar native libs..."
ISAR_VERSION=$(awk '/isar_version: /{print $3}' $TPS_DIR/../pubspec.yaml)
ISAR_LIBS_DIR=$PUB_CACHE/hosted/isar-community.dev/isar_flutter_libs-$ISAR_VERSION/android/src/main/jniLibs

echo "before patching:"
file $ISAR_LIBS_DIR/*/libisar.so

pushd $TPS_DIR/isar
bash ./tool/build_android.sh x86
mv libisar_android_x86.so $ISAR_LIBS_DIR/x86/libisar.so
bash ./tool/build_android.sh x64
mv libisar_android_x64.so $ISAR_LIBS_DIR/x86_64/libisar.so
bash ./tool/build_android.sh armv7
mv libisar_android_armv7.so $ISAR_LIBS_DIR/armeabi-v7a/libisar.so
bash ./tool/build_android.sh arm64
mv libisar_android_arm64.so $ISAR_LIBS_DIR/arm64-v8a/libisar.so
popd

echo "after patching:"
file $ISAR_LIBS_DIR/*/libisar.so

echo "> DONE"
