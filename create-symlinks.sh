#!/bin/bash

path=$(pwd)
this=$(basename $0)
do_not_copy=("$this" "." ".." ".git" ".gitignore" "install-desktop.sh"
             "install-server.sh" "server-apt-packages.txt"
             "server-pip-packages.txt" "desktop-apt-packages.txt"
             "desktop-pip-packages.txt")

for file in .* * .config/*; do
    allowed=yes
    for not_allowed in ${do_not_copy[@]}; do
        if [ "$not_allowed" = "$file" ]; then
            allowed=no
        fi
    done

    if [ $allowed = "no" ]; then
        echo "*** Ignoring file '$file'"
    else
        if [ ! -e ~/$file ]; then
            ln -s "$path/$file" ~/$file
            echo "*** Created link to '$file'"
        else
            echo "*** Link to '$file' NOT created! File already exists."
        fi
    fi
done
