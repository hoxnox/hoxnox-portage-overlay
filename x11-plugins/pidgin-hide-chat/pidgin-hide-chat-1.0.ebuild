# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="2"

inherit eutils

DESCRIPTION="This plugin adds an entry in the context menu of every channel you have in your buddy list to allow you to hide the chat window when you join the channel."
HOMEPAGE="https://launchpad.net/pidgin-hide-chat"
SRC_URI="https://launchpad.net/pidgin-hide-chat/trunk/1.0/+download/pidgin-hide-chat-1.0.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc x86"
IUSE=""

RDEPEND="net-im/pidgin[gtk]
	x11-libs/gtk+:2"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	econf
}
src_install() {
	emake DESTDIR="${D}" install || die
}
