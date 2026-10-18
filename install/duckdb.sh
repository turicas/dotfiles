#!/bin/bash

set -e

mkdir -p ~/.local/bin
pushd ~/.local/bin
duckdb_url=$(
	wget --quiet -O - https://github.com/duckdb/duckdb/releases \
	| grep -oE --color=no 'href="(/[^ ]+-linux-amd64.zip)"' \
	| sed 's|href="|https://github.com|; s|"$||' \
	| head -1
)
filename="duckdb.zip"
rm -rf "$filename"
wget -O "$filename" "$duckdb_url"
unzip "$filename" duckdb
rm "$filename"
chmod +x duckdb
popd
