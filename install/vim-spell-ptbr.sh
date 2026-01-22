#!/bin/bash
# Downloads LibreOffice's pt_BR dictionary, uses vim to compiles it into a `.spl` file and moves it to the vim spell
# folder.

url="https://pt-br.libreoffice.org/assets/Uploads/PT-BR-Documents/VERO/VeroptBR3215AOC.oxt"
filename="VeroptBR3215AOC.oxt"

mkdir -p ~/.local/tmp
pushd ~/.local/tmp
mkdir vero-ptbr
pushd vero-ptbr
wget "$url" -O "$filename"
unzip "$filename"
vim -u NONE -c "mkspell pt pt_BR" -c q
mkdir -p ~/.vim/spell/
mv pt.utf-8.spl ~/.vim/spell/
popd
rm -rf vero-ptbr
popd
