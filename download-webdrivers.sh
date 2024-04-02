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
	| sort -r \
	| head -1
)
wget -O chromedriver.zip "$chromedriver_url"
unzip chromedriver.zip chromedriver-linux64/chromedriver
mv chromedriver-linux64/chromedriver .
rmdir chromedriver-linux64
rm chromedriver.zip

# Download latest geckodriver available and put the executable on `~/.local/bin`
geckodriver_url=$(
	wget --quiet -O - https://github.com/mozilla/geckodriver/releases \
	| grep -oE --color=no 'href="(/[^ ]+-linux64.tar.gz)"' \
	| sed 's|href="|https://github.com|; s|"$||'
)
wget -O geckodriver.tar.gz "$geckodriver_url"
tar xfvz geckodriver.tar.gz
rm geckodriver.tar.gz

popd  # Go back to the directory we were in
