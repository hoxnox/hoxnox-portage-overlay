# @author Merder Kim
# Distributed under the terms of the BSD License
# Snappy Stream libarry ebuild

EAPI=4

inherit cmake-utils

KEYWORDS="~x86 ~amd64"

DESCRIPTION="Snappy Stream - C++ library"
HOMEPAGE="http://github.com/hoxnox/snappy-stream"
SRC_URI="https://nodeload.github.com/hoxnox/${PN}/tar.gz/${PV} -> {P}.tar.gz"
#S="${WORKDIR}"
LICENSE="BSD"
SLOT="0"
IUSE="doc"

DEPEND="app-arch/snappy
	doc? ( >=app-doc/doxygen-1.8.2 )"
RDEPEND="app-arch/snappy"

src_unpack() {
	unpack ${A}
    cd "${S}"
}

src_configure()
{
	if use doc; then
		MYCMAKEARGS="-DGENERATE_DOC=ON"
	fi
	cmake-utils_src_configure
}

src_compile() {
	if use doc; then
		cmake-utils_src_make "$@" doc 
	else
		cmake-utils_src_make
	fi
}

src_install() {
	cmake-utils_src_install
	dodoc README.md

	if use doc; then
		dohtml $CMAKE_BUILD_DIR/doc_snstrm/html/*
	fi
}

