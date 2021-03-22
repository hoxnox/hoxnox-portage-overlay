# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8} )
PYTHON_REQ_USE="sqlite"

inherit distutils-r1 git-r3

DESCRIPTION="Distributed C/C++ package manager"
HOMEPAGE="http://conan.io/"
EGIT_REPO_URI="https://github.com/conan-io/conan"
SRC_URI=""
LICENSE="MIT"
SLOT="0"
KEYWORDS="**"
IUSE="test"

RDEPEND="
	>=dev-python/bottle-0.12.8[${PYTHON_USEDEP}]
	>=dev-python/colorama-0.3.3[${PYTHON_USEDEP}]
	>=dev-python/distro-1.0.2[${PYTHON_USEDEP}]
	>=dev-python/fasteners-0.14.1[${PYTHON_USEDEP}]
	>=dev-python/passlib-1.6.5[${PYTHON_USEDEP}]
	>=dev-python/patch-1.16[${PYTHON_USEDEP}]
	>=dev-python/pyjwt-1.4[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-3.11[${PYTHON_USEDEP}]
	>=dev-python/requests-2.7[${PYTHON_USEDEP}]
	>=dev-python/six-1.10[${PYTHON_USEDEP}]
	>=dev-python/node-semver-0.2.0[${PYTHON_USEDEP}]
	>=dev-python/pluginbase-0.5[${PYTHON_USEDEP}]
	>=dev-python/future-0.16[${PYTHON_USEDEP}]
	>=dev-python/pylint-1.8.1[${PYTHON_USEDEP}]
	>=dev-python/astroid-1.5[${PYTHON_USEDEP}]
	>=dev-python/pygments-2.0[${PYTHON_USEDEP}]
	>=dev-python/deprecation-2.0[${PYTHON_USEDEP}]
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

python_test() {
	cd "${BUILD_DIR}"/lib || die
	PYTHONPATH=. nosetests -v . || die
}
