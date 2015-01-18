# @author Merder Kim
# Distributed under the terms of the Apache license
# SNMP++ (http://www.agentpp.com/) ebuild script 

EAPI=5

inherit autotools-utils eutils

DESCRIPTION="SNMP++v3.x is based on SNMP++v2.8 from HP* and extends it by support for SNMPv3 and a couple of bug fixes. SNMP++v3.x is a C++ API which supports SNMP v1, v2c, and v3"
HOMEPAGE="http://www.agentpp.com/agentpp3_5/agentpp3_5.html"
SRC_URI="http://www.agentpp.com/${PN}-${PV}.tar.gz"
LICENSE="Apache"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

RDEPEND="dev-libs/snmp++"
DEPEND="${RDEPEND}"
RDEPEND="${RDEPEND}"

# bug 123456
AUTOTOOLS_IN_SOURCE_BUILD=1

src_configure()
{
	if use static-libs; then
		econf \
			--enable-shared \
			--enable-static
	else
		econf \
			--enable-shared \
			--disable-static
	fi
	emake || die "emake failed"
}

src_install()
{
	emake DESTDIR="${D}" install || die "emake install failed"
}

