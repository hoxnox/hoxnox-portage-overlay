EAPI=6

inherit git-r3 eutils

KEYWORDS="~x86 ~amd64"

DESCRIPTION="Modern Jabber/XMPP Client using GTP+/Vala"
HOMEPAGE="https://github.com/dino/dino"
EGIT_REPO_URI="https://github.com/dino/dino"
# S=${WORKDIR}/${PN}
LICENSE="GPLv3"
SLOT="0"

DEPEND="dev-libs/libgee
        dev-db/sqlite
        x11-libs/gtk+
        dev-lang/vala"
RDEPEND=$DEPEND

src_unpack() {
	git-r3_fetch
	git-r3_checkout
}

src_configure()
{
	econf
}

src_compile() {
	emake
}

