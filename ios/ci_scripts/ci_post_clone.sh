#!/bin/sh -xe

# The default execution directory of this script is the ci_scripts directory.
cd $CI_PRIMARY_REPOSITORY_PATH # change working directory to the root of your cloned repo.

FLUTTER_VERSION=$(awk '/"flutter":/{print $2}' .fvmrc | tr -d '"')
git clone https://github.com/flutter/flutter.git --depth 1 -b $FLUTTER_VERSION $HOME/flutter
export PATH="$PATH:$HOME/flutter/bin"

flutter config --no-analytics --no-cli-animations
flutter --version
flutter precache --ios
flutter pub get

HOMEBREW_NO_AUTO_UPDATE=1 
brew install cocoapods

cd ios && pod install
