#!/bin/sh

APKSIGNER_BIN=${APKSIGNER_BIN:-apksigner}
VALID_HASH=5ac383c981bb53ea5a873cf6086d0a6a0a2f557420694ed5ae4c495677aafd5c

for f in "${@:1}"; do
    fingerprint=$($APKSIGNER_BIN verify --print-certs $f 2>/dev/null | sed -n 's/^Signer #1 certificate SHA-256 digest: \(.*\)/\1/p')
    [ "$fingerprint" = "$VALID_HASH" ] || (echo "$f: bad certificate: $fingerprint" && exit 1)
done