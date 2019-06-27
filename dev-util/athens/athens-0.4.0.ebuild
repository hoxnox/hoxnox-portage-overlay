# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils user

DESCRIPTION="Proxy server for the Go Modules download API"
HOMEPAGE="https://docs.gomods.io/"
SRC_URI="https://github.com/gomods/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"

RDEPEND="
	dev-vcs/git
	>=dev-lang/go-1.11.0
"

DEPEND="
	${RDEPEND}
"

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /var/lib/athens ${PN}
}

src_compile() {
	GOPATH="${WORKDIR}" emake build-ver VERSION="{PV}"
}

src_install() {
	dobin athens
	insinto /etc/athens
	doins config.dev.toml
	keepdir /var/log/athens /var/lib/athens
	fowners -R ${PN}:${PN} /var/log/${PN}
	newinitd "${FILESDIR}"/athens.initd athens
	newconfd "${FILESDIR}"/athens.confd athens
}
