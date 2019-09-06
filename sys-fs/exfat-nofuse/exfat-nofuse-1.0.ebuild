# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit linux-mod

DESCRIPTION="Non-fuse kernel driver for exFat and VFat file systems"
HOMEPAGE="https://github.com/dorimanx/exfat-nofuse"
SRC_URI="https://github.com/dorimanx/exfat-nofuse/archive/01c30ad52625a7261e1b0d874553b6ca7af25966.zip -> ${P}.zip"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

MODULE_NAMES="exfat(kernel/fs:${S})"
BUILD_TARGETS="all"

src_unpack() {
	unpack ${A}
	mv "exfat-nofuse-01c30ad52625a7261e1b0d874553b6ca7af25966" "${S}"
}

src_prepare(){
	sed -i -e "/^KREL/d" Makefile || die
	epatch "${FILESDIR}"/01-timespec.patch
}

src_compile(){
	BUILD_PARAMS="KDIR=${KV_OUT_DIR} M=${S}"
	linux-mod_src_compile
}
