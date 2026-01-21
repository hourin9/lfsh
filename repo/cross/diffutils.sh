NAME=diffutils
VERSION=3.12
URL="https://ftp.gnu.org/gnu/$NAME/$NAME-$VERSION.tar.xz"

unpack() {
    tar xf "$NAME-$VERSION.tar.xz"
}

pkg_build() {
    cd $NAME-$VERSION

    mkdir -pv build && cd build
    ../configure \
        --prefix=/usr \
        --host=$LFS_TGT \
        gl_cv_func_strcasecmp_works=y \
        --build=$(../build-aux/config.guess)

    make
}

pkg_install() {
    cd "$NAME-$VERSION/build"
    make DESTDIR=$LFS install
}

