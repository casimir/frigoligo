#!/bin/bash -e

script_path="$(readlink -f $0)"
tps_dir="$(dirname $script_path)"
isar_version=$(awk '/isar_version: /{print $3}' $tps_dir/../pubspec.yaml)
checked_out_version=$(git -C $tps_dir/isar describe --tags)

if [ "$isar_version" == "$checked_out_version" ]; then
  echo "Version $isar_version is up-to-date."
  exit 0
fi
echo "Updating from version $checked_out_version to $isar_version."

git -C $tps_dir/isar checkout "$isar_version"
cargo generate-lockfile --manifest-path $tps_dir/isar/Cargo.toml
mv $tps_dir/isar/Cargo.lock $tps_dir/isar-Cargo.lock
