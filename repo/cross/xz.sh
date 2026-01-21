NAME=xz
VERSION=5.8.1
URL="https://github.com//tukaani-project/xz/releases/download/v$VERSION/xz-$VERSION.tar.xz"

unpack() {
    tar xf "$NAME-$VERSION.tar.xz"
}

pkg_build() {
    cd $NAME-$VERSION

    mkdir -pv build && cd build
    ../configure \
        --prefix=/usr \
        --host=$LFS_TGT \
        --build=$(../build-aux/config.guess) \
        --disable-static \
        --docdir=/usr/share/doc/xz-5.8.1

    make
}

pkg_install() {
    cd "$NAME-$VERSION/build"
    make DESTDIR=$LFS install
    rm -v $LFS/usr/lib/liblzma.la
}

