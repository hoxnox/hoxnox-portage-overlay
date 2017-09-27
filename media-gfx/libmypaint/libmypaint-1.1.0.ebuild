# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit flag-o-matic scons-utils git-r3

DESCRIPTION="library for making brushstrokes"
HOMEPAGE="https://github.com/mypaint/libmypaint"
EGIT_REPO_URI="https://github.com/mypaint/libmypaint.git"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="openmp"

DEPEND="
	dev-lang/python
	dev-libs/glib
	dev-libs/json-c
	media-libs/gegl:0.3
	openmp? ( sys-devel/gcc[openmp] )
	"
RDEPEND="${DEPEND}
	!media-gfx/mypaint
	"

_my_scons() {
	escons \
			$(use_scons openmp enable_openmp) \
			enable_gegl="true" \
			enable_shared="true" \
			prefix="/usr" \
			"$@"
}

src_compile() {
	strip-unsupported-flags
	_my_scons
}

src_install () {
	_my_scons --install-sandbox="${D}" "${D}"
}
