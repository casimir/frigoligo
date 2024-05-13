#!/bin/sh

VALID_HASH=5ac383c981bb53ea5a873cf6086d0a6a0a2f557420694ed5ae4c495677aafd5c

apksigner_bin=$APKSIGNER_BIN
if [ -z "$apksigner_bin" ]; then
    flutter_android_home=$(flutter config --list | awk '/android-sdk: (.+)/{print $2}')
    android_home=${ANDROID_HOME:-$flutter_android_home}
    apksigner_bin=$(ls $android_home/build-tools/*/apksigner | head -n1)
fi
apksigner_bin=${apksigner_bin:-apksigner}

$apksigner_bin >/dev/null || exit 1
>&2 echo "apksigner: $apksigner_bin"

for f in "$@"; do
    fingerprint=$($apksigner_bin verify --print-certs $f 2>/dev/null | sed -n 's/^Signer #1 certificate SHA-256 digest: \(.*\)/\1/p')
    [ "$fingerprint" = "$VALID_HASH" ] || (echo "$f: bad certificate: $fingerprint" && exit 1)
    echo "$f: OK"
done