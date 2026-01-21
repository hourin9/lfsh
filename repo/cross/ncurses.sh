NAME=ncurses
VERSION=6.5-20250809
URL="https://invisible-mirror.net/archives/$NAME/current/$NAME-$VERSION.tgz"

unpack() {
    tar xf "$NAME-$VERSION.tgz"
}

pkg_build() {
    cd $NAME-$VERSION

    mkdir -pv $NAME-build && cd $NAME-build

    # FIXME: I used a workaround here. As the LFS book told
    # me not to build shared libs for GCC, libgcc_s.so.1 will
    # not be available and therefore I can't build shared C++
    # bindings.
    ../configure \
        --prefix=/usr \
        --host=$LFS_TGT \
        --build=$(../config.guess) \
        --mandir=/usr/share/man \
        --with-manpage-format=normal \
        --with-shared \
        --without-normal \
        --without-cxx-binding \
        --without-debug \
        --without-ada \
        --disable-stripping \
        AWK=gawk

    make
}

pkg_install() {
    cd "$NAME-$VERSION/$NAME-build"
    make DESTDIR=$LFS install
    ln -sv libncursesw.so $LFS/usr/lib/libncurses.so
    sed -e 's/^#if.*XOPEN.*$/#if 1/' \
        -i $LFS/usr/include/curses.h
}

