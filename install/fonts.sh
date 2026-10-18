#!/bin/bash

mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts

for nerdfont in DejaVuSansMono.zip UbuntuMono.zip; do
	rm -rf "$nerdfont"
	wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/$nerdfont"
	unzip -o "$nerdfont"
	rm -f "$nerdfont" README.md LICENSE.txt
done
fc-cache -fv
fc-list | grep -i "nerd"
