#!/bin/bash
NAME=libstdc++
VERSION=15.2.0
URL=

unpack() {
    :
}

pkg_build() {
    cd "gcc-$VERSION"

    mkdir -pv stdcxx-build && cd stdcxx-build
    ../libstdc++-v3/configure \
        --host=$LFS_TGT \
        --build=$(../config.guess) \
        --prefix=/usr \
        --disable-multilib \
        --disable-nls \
        --disable-libstdcxx-pch \
        --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/$VERSION

    make
}

pkg_install() {
    cd "gcc-$VERSION"/stdcxx-build
    make DESTDIR=$LFS install

    # Remove libtool archive files
    rm -v $LFS/usr/lib/lib{stdc++,{,exp,fs},supc++}.la
}

