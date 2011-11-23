#!/bin/bash

path=$(pwd)
this=$(basename $0)
for file in $(ls -a); do
    if [ "$file" != "$this" ] && [ "$file" != "." ] && [ "$file" != ".." ] && \
       [ "$file" != ".git" ]; then
        if [ ! -e ~/$file ]; then
            ln -s "$path/$file" ~/$file
        else
            echo "*** Link to '$file' NOT created! File already exists."
        fi
    else
        echo "*** Ignoring file '$file'"
    fi
done
