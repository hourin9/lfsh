NAME=tic
VERSION=6.5-20250809
URL="https://invisible-mirror.net/archives/ncurses/current/ncurses-$VERSION.tgz"

unpack() {
    tar xf "ncurses-$VERSION.tgz"
}

pkg_build() {
    cd ncurses-$VERSION

    mkdir -pv build && cd build
    ../configure --prefix=$LFS/tools AWK=gawk
    make -C include
    make -C progs tic
}

pkg_install() {
    cd "ncurses-$VERSION/build"
    command install progs/tic $LFS/tools/bin
}

