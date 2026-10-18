#!/bin/bash

downloadPath="$HOME/zig-docs"
mkdir -p "$downloadPath"


wget -O "$downloadPath/zig-language-reference.html" https://ziglang.org/documentation/0.17.0/
wget -O "$downloadPath/zig-stdlib.html" https://ziglang.org/documentation/0.17.0/std/
wget -O "$downloadPath/zig-release-notes.html" https://ziglang.org/download/0.17.0/release-notes.html
wget -O "$downloadPath/zig-build-system.html" https://ziglang.org/learn/build-system/
wget -O "$downloadPath/zig-overview.html" https://ziglang.org/learn/overview/
wget -O "$downloadPath/zig-why.html" https://ziglang.org/learn/why_zig_rust_d_cpp/
wget -O "$downloadPath/zig-samples.html" https://ziglang.org/learn/samples/
wget -O "$downloadPath/zig-tools.html" https://ziglang.org/learn/tools/
wget -O "$downloadPath/zig-getting-started.html" https://ziglang.org/learn/getting-started/
