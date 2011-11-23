#!/bin/bash

path=$(pwd)
this=$(basename $0)
for file in $(ls -a); do
    if [ "$file" != "$this" ] && [ "$file" != "." ] && [ "$file" != ".." ]; then
        if [ ! -e ~/$file ]; then
            ln -s "$path/$file" ~/"$file"
        else
            echo "*** Link to $file NOT created! File already exists."
        fi
    fi
done
