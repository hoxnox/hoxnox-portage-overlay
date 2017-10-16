# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils autotools-utils git-2

DESCRIPTION="LIRC"
HOMEPAGE="http://lirc.org"
EGIT_REPO_URI="git://lirc.git.sourceforge.net/gitroot/lirc/lirc"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-python/pyyaml
        media-libs/libirman"
RDEPEND="${DEPEND}"

src_prepare()
{
	./autogen.sh
}

src_configure()
{
	econf || die "econf failed"
}

src_compile()
{
	emake || die "emake failed"
}

src_install()
{
	emake DESTDIR="${D}" install || die "emeake install failed"
}
