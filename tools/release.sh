#!/bin/sh

if [ "$(git rev-parse --abbrev-ref HEAD)" != "main" ]; then
  echo "You must be on the main branch to create a new release."
  exit 1
fi

if [ -n "$(git status --porcelain)" ]; then
  echo "There are uncommitted changes in the working directory."
  exit 1
fi

FULL_VERSION=$(awk '/version: ([0-9]+\.[0-9]+.[0-9]+\+[0-9]+)/{ print $2}' pubspec.yaml)
TAG=$(printf 'v%s\n' "$(echo $FULL_VERSION | cut -d+ -f1)")
VERSION_NUM=$(echo $FULL_VERSION | cut -d+ -f2)

if $(git tag --list | grep -q $TAG); then
  echo "The tag $TAG already exists."
  exit 1
fi

git-cliff --tag $TAG
git add CHANGELOG.md

dart run ./flathub/render_metadata.dart --current
git add flathub/

git commit -m "chore(release): prepare for $TAG"

git tag --sign $TAG --file fastlane/metadata/android/en-US/changelogs/$VERSION_NUM.txt
