#!/bin/bash

path=$(pwd)
for filename in .*; do
    if [ ! -e "$HOME/$filename" ]; then
        ln -s "$path/$filename" "$HOME/$filename"
        echo "*** Created link to '$filename'"
    else
        echo "*** Link to '$filename' NOT created! File already exists."
    fi
done
