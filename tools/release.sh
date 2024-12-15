#!/bin/sh

# Prepare a new release by doing the following:
# 1. Update CHANGELOG.md.
# 2. Create a new git tag.
# 3. Push the new tag to the remote repository.
# 4. (optional) Create a new release on GitHub.

TAG=$1

if [ -z "$TAG" ]; then
  echo "Usage: $0 <tag>"
  exit 1
fi

if [ "$(git rev-parse --abbrev-ref HEAD)" != "main" ]; then
  echo "You must be on the master branch to create a new release."
  exit 1
fi

if [ -n "$(git status --porcelain --untracked-files no)" ]; then
  echo "There are uncommitted changes in the working directory."
  exit 1
fi

git-cliff --tag $TAG
git add CHANGELOG.md
git commit -m "Automated changelog update"

TMPFILE=$(mktemp)
git cliff --unreleased --tag $TAG --strip all --output $TMPFILE
git tag --sign $TAG --file $TMPFILE
rm $TMPFILE

# to add when this release process has proven to work
# gh release create $TAG --notes-from-tag
