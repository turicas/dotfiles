#!/bin/bash

mkdir -p ~/projects
cat repositories.txt | while read repo; do
	if [[ -d ~/projects/$(basename $repo) ]]; then
		echo $repo already exists;
	else
		cd ~/projects/
		git clone git@github.com:${repo}.git
		cd -
	fi
done
