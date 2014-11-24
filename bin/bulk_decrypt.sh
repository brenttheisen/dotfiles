#!/bin/bash

read -rsp "Enter passphrase: " PASSPHRASE

for FILE in *.*.pgp; do
    echo "Extracting $FILE to ${FILE%.pgp}."
    echo "$PASSPHRASE" | gpg --passphrase-fd 0 --batch -d --output "${FILE%.pgp}" "$FILE"
done
