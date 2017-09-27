# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3 bash-completion-r1 toolchain-funcs

DESCRIPTION="Ponymix is a command line mixer for PulseAudio."
HOMEPAGE="https://github.com/falconindy/ponymix"
SRC_URI=""
EGIT_REPO_URI="https://github.com/falconindy/ponymix.git"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="bash-completion zsh-completion"

DEPEND="${RDEPEND}
virtual/pkgconfig"
RDEPEND="media-sound/pulseaudio
x11-libs/libnotify"

src_prepare() {
    sed -i -e 's/^\(base_CXXFLAGS\s*=\).*/\1 -std=c++14 -DPONYMIX_VERSION=\\"\$(V)\\" /' \
        Makefile || die "sed failed"
    sed -i "s/pkg-config/$(tc-getPKG_CONFIG)/g" Makefile || die "sed failed"
}

src_compile() {
    emake
}

pkg_install() {
    dobin ponymix
    doman ponymix.1
    if use bash-completion; then
        newbashcomp bash-completion ponymix
    fi
    if use zsh-completion; then
        insinto /usr/share/zsh/site-functions
        donewins zsh-completion _ponymix
    fi
}
