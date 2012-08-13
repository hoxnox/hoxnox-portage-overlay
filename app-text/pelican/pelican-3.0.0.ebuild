# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Pelican-3.0.0 20120813

EAPI=4
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="A tool to generate a static blog, with restructured text (or markdown) input files."
HOMEPAGE="http://blog.getpelican.com/"
SRC_URI="https://github.com/getpelican/pelican/tarball/3.0"
SRC_URI="https://github.com/getpelican/pelican/tarball/3.0 -> ${PN}-${PV}.tgz"
S="${WORKDIR}/getpelican-pelican-440a686"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples markdown"

DEPEND="dev-python/feedgenerator
	dev-python/jinja
	dev-python/docutils
	dev-python/pygments
	dev-python/pytz
	dev-python/unidecode
	dev-python/blinker
	markdown? ( dev-python/markdown )
	|| ( dev-lang/python:2.7 dev-python/argparse )"
RDEPEND="${DEPEND}"

DOCS="README.rst"

src_install() {
	distutils_src_install
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r samples/* || die "failed to install examples"
	fi
}
