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
wget -O duckdb.zip "$duckdb_url"
unzip duckdb.zip duckdb
rm duckdb.zip
chmod +x duckdb
popd
