#!/bin/bash

mkdir -p ~/.local/bin ~/.local/man
# TODO: check new version
VERSION="1.72.1"
FILENAME="rclone-v${VERSION}-linux-amd64.zip"
wget "https://downloads.rclone.org/v${VERSION}/${FILENAME}"
unzip "$FILENAME"
mv rclone-v${VERSION}-linux-amd64/rclone ~/.local/bin/
mv rclone-v${VERSION}-linux-amd64/rclone.1 ~/.local/man/
rm -rf "rclone-v${VERSION}-linux-amd64/" "$FILENAME"
