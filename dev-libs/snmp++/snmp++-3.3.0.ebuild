# @author Merder Kim
# Distributed under the terms of the Apache license
# SNMP++ (http://www.agentpp.com/) ebuild script 

EAPI=5

inherit autotools-utils eutils

DESCRIPTION="SNMP++v3.x is based on SNMP++v2.8 from HP* and extends it by support for SNMPv3 and a couple of bug fixes. SNMP++v3.x is a C++ API which supports SNMP v1, v2c, and v3"
HOMEPAGE="http://www.agentpp.com/snmp_pp3_x/snmp_pp3_x.html"
SRC_URI="http://www.agentpp.com/${PN}v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
S="${WORKDIR}/${PN}"
LICENSE="Apache"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

RDEPEND="dev-libs/openssl"
DEPEND="sys-devel/autoconf
        sys-devel/automake
        sys-devel/libtool
        dev-util/pkgconfig
        ${RDEPEND}"

# bug 123456
AUTOTOOLS_IN_SOURCE_BUILD=1

src_prepare()
{
	autoreconf -i --force
}

src_configure()
{
	if use static-libs; then
		econf \
			--docdir="\$(datarootdir)/doc/${PF}/html" \
			--enable-shared \
			--enable-static
	else
		econf \
			--docdir="\$(datarootdir)/doc/${PF}/html" \
			--enable-shared \
			--disable-static
	fi
	emake || die "emake failed"
}

src_install()
{
	emake DESTDIR="${D}" install || die "emake install failed"
}

