NAME=file
VERSION=5.46
URL="https://astron.com/pub/file/$NAME-$VERSION.tar.gz"

unpack() {
    tar xf "$NAME-$VERSION.tar.gz"
}

pkg_build() {
    cd $NAME-$VERSION

    mkdir -pv build
    pushd build
        ../configure \
            --disable-bzlib \
            --disable-libseccomp \
            --disable-xzlib \
            --disable-zlib
        make
    popd

    ./configure \
        --prefix=/usr \
        --host=$LFS_TGT \
        --build=$(./config.guess)

    make FILE_COMPILE=$(pwd)/build/src/file
}

pkg_install() {
    cd "$NAME-$VERSION"
    make DESTDIR=$LFS install
    rm -v $LFS/usr/lib/libmagic.la
}

