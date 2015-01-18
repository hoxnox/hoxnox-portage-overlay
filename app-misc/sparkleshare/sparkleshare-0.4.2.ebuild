# foo

EAPI=3

inherit base mono

MY_PV="${PV/_beta/-beta}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="SparkleShare is a file sharing and collaboration tool inspired by Dropbox"
HOMEPAGE="http://www.sparkleshare.org"
SRC_URI="https://github.com/downloads/hbons/SparkleShare/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

DEPEND=">=dev-lang/mono-2.2
	>=dev-util/monodevelop-2.0
	>=dev-dotnet/gtk-sharp-2.12.7
	>=dev-dotnet/webkit-sharp-0.3
	dev-dotnet/notify-sharp"
RDEPEND="${DEPEND}
	>=dev-vcs/git-1.7
	net-misc/openssh
	>=gnome-base/gvfs-1.3
	dev-util/intltool"

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf $(use_enable doc user-help) || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README COPYING
}

