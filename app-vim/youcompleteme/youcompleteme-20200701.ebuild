# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )

inherit eutils cmake-utils multilib python-single-r1 vim-plugin

DESCRIPTION="vim plugin: a code-completion engine for Vim"
HOMEPAGE="http://valloric.github.io/YouCompleteMe/"
KEYWORDS="~amd64 ~x86"
SRC_URI="http://misc.hoxnox.com/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
IUSE="clang doc test rust"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

COMMON_DEPEND="
	${PYTHON_DEPS}
	clang? ( >=sys-devel/clang-10.0.0 )
	dev-libs/boost[python,threads]
	|| (
		app-editors/vim[python]
		app-editors/gvim[python]
	)
"
RDEPEND="
	${COMMON_DEPEND}
	dev-python/bottle
	dev-python/future
	dev-python/jedi
	dev-python/requests
	dev-python/sh
	dev-python/waitress
	dev-python/urllib3
	dev-python/watchdog
"
DEPEND="
	${COMMON_DEPEND}
	rust? (
		|| ( dev-lang/rust dev-lang/rust-bin )
		|| ( dev-util/cargo dev-util/cargo-bin )
	)
	test? (
		>=dev-python/mock-1.0.1
		>=dev-python/nose-1.3.0
		dev-cpp/gmock
		dev-cpp/gtest
	)
"

CMAKE_IN_SOURCE_BUILD=1
CMAKE_USE_DIR=${S}/third_party/ycmd/cpp

VIM_PLUGIN_HELPFILES="${PN}"

src_prepare() {
	default

	if ! use test ; then
		sed -i '/^add_subdirectory( tests )/d' third_party/ycmd/cpp/ycm/CMakeLists.txt || die
	fi
	for third_party_module in bottle waitress cregex watchdog_deps jedi_deps; do
		rm -r "${S}"/third_party/ycmd/third_party/${third_party_module} || die "Failed to remove third party module ${third_party_module}"
	done
	#rm -r "${S}"/third_party/ycmd/third_party/JediHTTP/vendor || die "Failed to remove third_party/ycmd/third_party/JediHTTP/vendor"
	rm -r "${S}"/third_party/ycmd/cpp/BoostParts || die "Failed to remove bundled boost"
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DUSE_CLANG_COMPLETER="$(usex clang)"
		-DUSE_SYSTEM_LIBCLANG="$(usex clang)"
		-DUSE_SYSTEM_BOOST=ON
		-DUSE_SYSTEM_GMOCK=ON
		-DUSE_PYTHON2=OFF
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile

	if use rust ; then
		cd "${S}"/third_party/ycmd/third_party/racerd || die "Failed to move to racerd directory"
		cargo build --release || die "Failed to build racerd"
	fi
}

src_test() {
	cd "${S}/third_party/ycmd/cpp/ycm/tests"
	LD_LIBRARY_PATH="${EROOT}"/usr/$(get_libdir)/llvm \
		./ycm_core_tests || die

	cd "${S}"/python/ycm

	local dirs=( "${S}"/third_party/*/ "${S}"/third_party/ycmd/third_party/*/ )
	local -x PYTHONPATH=${PYTHONPATH}:$(IFS=:; echo "${dirs[*]}")

	nosetests --verbose || die
}

src_install() {
	use doc && dodoc *.md third_party/ycmd/*.md
	rm -r *.md *.sh *.py* *.ini *.yml COPYING.txt third_party/ycmd/cpp third_party/ycmd/ci third_party/ycmd/ycmd/tests third_party/ycmd/examples/samples
	rm -r third_party/ycmd/{*.md,*.sh,*.yml,.coveragerc,.gitignore,.gitmodules,.travis.yml,build.*,*.txt,run_tests.*,*.ini,update*}
	find python -name *test* -exec rm -rf {} + || die

	vim-plugin_src_install

	python_optimize "${ED}"
	python_fix_shebang "${ED}"
}
