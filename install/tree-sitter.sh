#!/bin/bash

set -e

mkdir -p ~/.local/opt ~/.local/bin
pushd ~/.local/bin
treesitter_url=$(
  wget --quiet -O - https://github.com/tree-sitter/tree-sitter/releases \
    | grep -oE --color=no 'href="(/[^ ]+-linux-x64.gz)"' \
    | sed 's|href="|https://github.com|; s|"$||' \
    | head -1
)
rm -f "tree-sitter.gz" "tree-sitter"
wget -O "tree-sitter.gz" "$treesitter_url"
gunzip -f "tree-sitter.gz"
chmod +x "tree-sitter"
popd

mkdir -p ~/.local/opt/tree-sitter
pushd ~/.local/opt/tree-sitter
for lang in bash c cpp css go html javascript json php python regex rust typescript; do
  echo "-----> Compiling parser for ${lang}"
  rm -rf "tree-sitter-${lang}"
  git clone --depth 1 "https://github.com/tree-sitter/tree-sitter-${lang}.git"
  if [[ $lang == "php" || $lang == "typescript" ]]; then
    langdir="tree-sitter-${lang}/${lang}"
  else
    langdir="tree-sitter-${lang}"
  fi
  pushd "$langdir"
  ~/.local/bin/tree-sitter build
  popd
  echo
done
popd

# TODO: configure vim to generate tags on each save, like https://gist.github.com/romainl/f2d0727bdb9bde063531cd237f47775f
# rm -rf tags
# git ls-files | while read filename; do
# 	tree-sitter tags $filename 2> /dev/null \
# 	| sed 's/| //; s/[dr]ef ([0-9]\+, [0-9]\+) - ([0-9]\+, [0-9]\+) `//; s/`$//' \
# 	| awk -F '\t' '{print $1 "\t'$filename'\t/" $3 "/\t" $2}'
# done > tags
# TODO: may use https://github.com/npezza93/ttags/
