#!/bin/sh -x

cd "$(dirname $0)"

# remove non-breaking space from subtitle to please App Store Connect
sed -i '' 's/ / /' fastlane/metadata/fr-FR/subtitle.txt

fastlane deliver

git checkout fastlane/metadata/fr-FR/subtitle.txt
