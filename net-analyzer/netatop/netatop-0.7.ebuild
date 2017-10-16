# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit linux-info linux-mod

DESCRIPTION="Kernel module for atop resorce-specific network stats"
HOMEPAGE="http://www.atoptool.nl/netatop.php"
SRC_URI="http://www.atoptool.nl/download/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	>=sys-process/atop-2.0.2
	>=sys-kernel/gentoo-sources-3.14.14
"
RDEPEND=">=sys-process/atop-1.23"
MODULE_NAMES="netatop(extra:${S}:${S}/module)"

src_compile() {
	emake ARCH=x86_64 -j1
}

src_install() {
	linux-mod_src_install
	dosbin daemon/netatopd
	doinitd netatop.init
	doman man/netatop.4
	doman man/netatopd.8
}

