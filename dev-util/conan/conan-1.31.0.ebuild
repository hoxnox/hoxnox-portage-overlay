# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7} )
PYTHON_REQ_USE="sqlite"

inherit distutils-r1

DESCRIPTION="Distributed C/C++ package manager"
HOMEPAGE="https://conan.io/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

# overly strict requirements?
# https://github.com/conan-io/conan/blob/develop/conans/requirements.txt
RDEPEND="
	>=dev-python/pyjwt-1.4[${PYTHON_USEDEP}]
	>=dev-python/requests-2.8.1[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
	>=dev-python/colorama-0.3.3[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-3.11[${PYTHON_USEDEP}]
	>=dev-python/patch-ng-1.17.3[${PYTHON_USEDEP}]
	>=dev-python/fasteners-0.14.1[${PYTHON_USEDEP}]
	>=dev-python/six-1.10[${PYTHON_USEDEP}]
	>=dev-python/node-semver-0.6.1[${PYTHON_USEDEP}]
	>=dev-python/distro-1.0.2[${PYTHON_USEDEP}]
	>=dev-python/pylint-2.3.1[${PYTHON_USEDEP}]
	>=dev-python/future-0.16.0[${PYTHON_USEDEP}]
	>=dev-python/pygments-2.0[${PYTHON_USEDEP}]
	>=dev-python/astroid-1.6.5[${PYTHON_USEDEP}]
	>=dev-python/deprecation-2.0[${PYTHON_USEDEP}]
	>=dev-python/tqdm-4.28.1[${PYTHON_USEDEP}]
	>=dev-python/jinja-2.3[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.7.0[${PYTHON_USEDEP}]
	>=dev-python/typed-ast-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/pluginbase-0.5[${PYTHON_USEDEP}]
	>=dev-python/packaging-16.8[${PYTHON_USEDEP}]
	>=dev-python/bottle-0.12.8[${PYTHON_USEDEP}]
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
	default
	# Fix strict dependencies
	sed -i \
		-e "s:patch-ng>=1.17.4, <1.18:patch-ng>=1.17.3, <1.18:g" \
		-e "s:node-semver==0.6.1:node-semver>=0.6.1:g" \
		-e "s:distro>=1.0.2, <1.2.0:distro>=1.0.2:g" \
		-e "s:six>=1.10.0,<=1.14.0:six>=1.10.0:g" \
		conans/requirements.txt
}

python_test() {
	cd "${BUILD_DIR}"/lib || die
	PYTHONPATH=. nosetests -v . || die
}
