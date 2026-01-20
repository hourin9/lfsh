#!/bin/bash
NAME=binutils
VERSION=2.45
URL="https://ftp.gnu.org/gnu/binutils/$NAME-$VERSION.tar.gz"

unpack() {
    tar xzf "$NAME-$VERSION.tar.gz"
}

pkg_build() {
    cd "$NAME-$VERSION"
    mkdir -pv build && cd build
    ../configure --prefix=$LFS/tools \
        --with-sysroot=$LFS \
        --target=$LFS_TGT \
        --disable-nls \
        --enable-gprofng=no \
        --disable-werror \
        --enable-new-dtags \
        --enable-default-hash-style=gnu
    make
}

pkg_install() {
    cd "$NAME-$VERSION"/build/
    make install
}

