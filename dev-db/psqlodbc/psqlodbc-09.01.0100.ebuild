# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit postgresql

KEYWORDS="~x86 ~amd64"

DESCRIPTION="The official PostgreSQL ODBC Driver."
HOMEPAGE="http://pgfoundry.org/projects/psqlodbc/"
SRC_URI="mirror://postgresql/odbc/versions/src/${P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
IUSE="iodbc threads unicode"

DEPEND="dev-db/postgresql-base
		iodbc? ( >=dev-db/libiodbc-3.52.4 )
		!iodbc? ( dev-db/unixODBC )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Patching Makefile.am and running eautoreconf didn't work
	sed -i \
		-e 's/\(psqlodbc_la\)/lib\1/g' \
		-e 's/\(psqlodbc.la\)/lib\1/g' \
		Makefile.in || die "sed failed"

	if use iodbc ; then
		sed -i \
			-e "/^DEFAULT_INCLUDES/s:$: `iodbc-config --cflags`:" \
			Makefile.in || die "sed failed"
	fi

}

src_compile() {
	econf \
		$(use_with iodbc) \
		$(use_with !iodbc unixodbc) \
		$(use_enable threads pthreads) \
		$(use_enable unicode) \
		--enable-static \
		--enable-shared \
		PATH="$(postgresql_get_bindir):${PATH}" \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc readme.txt
	dohtml docs/*
}
