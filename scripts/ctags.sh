#!/bin/bash

if ! git clone --depth=1 https://github.com/universal-ctags/ctags.git /tmp/nvim-ctags-install; then
    echo "Unable to clone repo"
    exit 1
fi

cd /tmp/nvim-ctags-install
./autogen.sh
./configure --prefix=$HOME/.local/
make
make install
