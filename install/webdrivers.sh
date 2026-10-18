#!/bin/bash

set -e

mkdir -p ~/.local/bin
pushd ~/.local/bin

# Download latest chromedriver available and put the executable on `~/.local/bin`
chromedriver_url=$(
	wget --quiet -O - https://googlechromelabs.github.io/chrome-for-testing/ \
	| grep -oE --color=no '(https://[^ ]+\.zip)' \
	| grep --color=no chromedriver \
	| grep --color=no linux64 \
	| sort \
	| head -1
)
filename="chromedriver.zip"
rm -rf "$filename"
wget -O "$filename" "$chromedriver_url"
unzip "$filename" chromedriver-linux64/chromedriver
mv chromedriver-linux64/chromedriver .
rmdir chromedriver-linux64
rm "$filename"

# Download latest geckodriver available and put the executable on `~/.local/bin`
geckodriver_url=$(
	wget --quiet -O - https://github.com/mozilla/geckodriver/releases \
	| grep -oE --color=no 'href="(/[^ ]+-linux64.tar.gz)"' \
	| sed 's|href="|https://github.com|; s|"$||'
)
filename="geckodriver.tar.gz"
wget -O "$filename" "$geckodriver_url"
tar xfvz "$filename"
rm "$filename"

popd  # Go back to the directory we were in
