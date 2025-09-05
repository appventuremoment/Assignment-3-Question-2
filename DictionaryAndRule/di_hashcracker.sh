#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <md5_hash>"
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

HASH="$1"
WORDLIST="$SCRIPT_DIR/rockyou.txt"
RULEFILE="$SCRIPT_DIR/OneRuleToRuleThemStill.rule"
OUTPUT_FILE="output.txt"

START_TIME=$(date +%s)
rm -f "$OUTPUT_FILE"
TMP_HASH_FILE=$(mktemp)
echo "$HASH" > "$TMP_HASH_FILE"
hashcat -m 0 -a 0 "$TMP_HASH_FILE" "$WORDLIST" -r "$RULEFILE" -o "$OUTPUT_FILE"
END_TIME=$(date +%s)
DURATION=$((END_TIME - START_TIME))
echo "Duration: $DURATION seconds"
cat "$OUTPUT_FILE"
rm "$TMP_HASH_FILE"

