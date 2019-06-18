# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )
PYTHON_REQ_USE="sqlite"

inherit eutils distutils-r1 user

DESCRIPTION="Distributed C/C++ package manager"
HOMEPAGE="http://conan.io/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

RDEPEND="
	>=dev-python/bottle-0.12.8[${PYTHON_USEDEP}]
	>=dev-python/colorama-0.3.3[${PYTHON_USEDEP}]
	>=dev-python/distro-1.0.2[${PYTHON_USEDEP}]
	>=dev-python/fasteners-0.14.1[${PYTHON_USEDEP}]
	>=dev-python/passlib-1.6.5[${PYTHON_USEDEP}]
	=dev-python/patch-1.16[${PYTHON_USEDEP}]
	>=dev-python/pyjwt-1.4[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-3.11[${PYTHON_USEDEP}]
	>=dev-python/requests-2.8.1[${PYTHON_USEDEP}]
	>=dev-python/six-1.10[${PYTHON_USEDEP}]
	>=dev-python/node-semver-0.6.1[${PYTHON_USEDEP}]
	>=dev-python/pluginbase-0.5[${PYTHON_USEDEP}]
	>=dev-python/future-0.16[${PYTHON_USEDEP}]
	>=dev-python/pylint-1.9.3[${PYTHON_USEDEP}]
	>=dev-python/astroid-1.6.5[${PYTHON_USEDEP}]
	>=dev-python/pygments-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/deprecation-2.0[${PYTHON_USEDEP}]
	>=dev-python/tqdm-4.28.1[${PYTHON_USEDEP}]
	>=dev-python/packaging-16.8[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.6.1[${PYTHON_USEDEP}]
	>=dev-python/jinja-2.3[${PYTHON_USEDEP}]
"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		  ${RDEPEND}
		  dev-lang/go
		  >=dev-python/mock-1.3.0[${PYTHON_USEDEP}]
		  >=dev-python/nose-1.3.7[${PYTHON_USEDEP}]
		  >=dev-python/nose-parameterized-0.5.0[${PYTHON_USEDEP}]
		  >=dev-python/webtest-2.0.18[${PYTHON_USEDEP}]
		  dev-util/cmake
	  )
"
src_prepare() {
	epatch "${FILESDIR}"/1.16.1-01-future-version.patch
	eapply_user
}

python_test() {
	cd "${BUILD_DIR}"/lib || die
	PYTHONPATH=. nosetests -v . || die
}
