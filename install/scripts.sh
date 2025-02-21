#!/bin/bash

path="$HOME/.local/bin/lsofgraph"
wget -O "$path" https://raw.githubusercontent.com/zevv/lsofgraph/refs/heads/master/lsofgraph
chmod +x "$path"
