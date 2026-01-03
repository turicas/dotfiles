# dotfiles

This repository contains:
- The list of APT packages I generally install on servers
- The list of APT packages I generally install on my desktop machines
- The config files ("dot" files) for most of the software I use

Use [GNU `stow`](https://www.gnu.org/software/stow/) to create symlinks.

## To do

- Do not include these files on `create-symlinks.sh`:
  - `.gitignore`
  - `.gitmodules`
  - `.tags`
- Install auto complete to all bash aliases using [complete-alias](https://github.com/cykerway/complete-alias/)
