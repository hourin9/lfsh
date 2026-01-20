#!/bin/bash
NAME=linux-headers
VERSION=6.16.1
URL="https://www.kernel.org/pub/linux/kernel/v6.x/linux-$VERSION.tar.xz"

unpack() {
    tar xf "linux-$VERSION.tar.xz"
}

pkg_build() {
    cd "linux-$VERSION"
    make mrproper
    make headers

    find usr/include -type f ! -name '*.h' -delete
}

pkg_install() {
    cd "linux-$VERSION"
    cp -rv usr/include $LFS/usr
}

