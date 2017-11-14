EAPI=6

inherit eutils

KEYWORDS="~x86 ~amd64"
DESCRIPTION="Modern Jabber/XMPP Client using GTP+/Vala"
HOMEPAGE="https://github.com/dino/dino"
SRC_URI="https://github.com/okbob/pspg/archive/v0.3.tar.gz -> ${P}.tar.gz"
# S=${WORKDIR}/${PN}
LICENSE="BSD"
SLOT="0"

DEPEND=""
RDEPEND=$DEPEND

src_configure()
{
	econf
}

src_compile() {
	emake
}

