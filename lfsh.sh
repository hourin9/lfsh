#!/bin/bash

make_dir() {
    mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin}
    for i in bin lib sbin; do
        ln -sv usr/$i $LFS/$i
    done

    mkdir -pv $LFS/{tools,src}

    case $(uname -m) in
        x86-64) mkdir -pv $LFS/lib64 ;;
    esac
}

ready() {
    export LFS=/mnt/lfs
    export LC_ALL=C
    export LFS_TGT=$(uname -m)-lfs-linux-gnu
    export CONFIG_SITE=$LFS/usr/share/config.site
    export MAKEFLAGS=-j$(nproc)
}

"$1"

