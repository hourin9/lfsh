#!/bin/bash
NAME=glibc
VERSION=2.42
URL="https://ftp.gnu.org/gnu/glibc/$NAME-$VERSION.tar.xz"

unpack() {
    tar xf "$NAME-$VERSION.tar.xz"

    cd "$NAME-$VERSION"

    # Create symlinks for LSB compliance.
    case $(uname -m) in
        i?86)   ln -sfv ld-linux.so.2 $LFS/lib/ld-lsb.so.3
        ;;
        x86_64) ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64
                ln -sfv ../lib/ld-linux-x86-64.so.2 \
                    $LFS/lib64/ld-lsb-x86-64.so.3
        ;;
    esac
}

pkg_build() {
    cd "$NAME-$VERSION"

    patch -Np1 -i $LFS/src/patches/glibc-2.42-fhs-1.patch
    mkdir -pv build && cd build

    echo "rootsbindir=/usr/sbin" > configparms

    ../configure \
        --prefix=/usr \
        --host=$LFS_TGT \
        --build=$(../scripts/config.guess) \
        --disable-nscd \
        libc_cv_slibdir=/usr/lib \
        --enable-kernel=5.4

    # Override MAKEFLAGS by explicitly set -j1
    make -j1
}

pkg_install() {
    cd "$NAME-$VERSION"/build
    make DESTDIR=$LFS install

    # Fix hardcoded path in ldd script
    sed '/RTLDLIST=/s@/usr@@g' -i $LFS/usr/bin/ldd
}

