#!/bin/bash

path=$(pwd)
this=$(basename $0)
do_not_copy=(
   "$this"
   "."
   ".."
   ".git"
   ".gitignore"
   "desktop-apt-packages.txt"
   "desktop-install.sh"
   "desktop-pip-packages.txt"
   "desktop-post-install.sh"
   "server-apt-packages.txt"
   "server-docker-images.txt"
   "server-install.sh"
   "server-pip-packages.txt"
)

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
        if [ ! -e "$HOME/$file" ]; then
            ln -s "$path/$file" "$HOME/$file"
            echo "*** Created link to '$file'"
        else
            echo "*** Link to '$file' NOT created! File already exists."
        fi
    fi
done
