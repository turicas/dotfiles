#!/bin/bash

set -e

pushd ~/.local/bin
treesitter_url=$(
	wget --quiet -O - https://github.com/tree-sitter/tree-sitter/releases \
	| grep -oE --color=no 'href="(/[^ ]+-linux-x64.gz)"' \
	| sed 's|href="|https://github.com|; s|"$||'
)
wget -O tree-sitter.gz "$treesitter_url"
gunzip -f tree-sitter.gz
chmod +x tree-sitter
popd

mkdir -p ~/.local/opt/tree-sitter
pushd ~/.local/opt/tree-sitter
# TODO: php and typescript were not working =/
for lang in bash c cpp css go html java javascript json python regex ruby rust; do
	rm -rf tree-sitter-${lang}
	git clone --depth 1 https://github.com/tree-sitter/tree-sitter-${lang}.git
	cd tree-sitter-${lang}
	~/.local/bin/tree-sitter build
	cd ..
done
popd

# TODO: configure vim to generate tags on each save, like https://gist.github.com/romainl/f2d0727bdb9bde063531cd237f47775f
# rm -rf .tags; touch .tags
# git ls-files | while read filename; do
# 	tree-sitter tags $filename | sed "s/\t/\t${filename}\t/" >> .tags
# done
# TODO: may use https://github.com/npezza93/ttags/
