# Copyright 2008-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_P="${PN}-v${PV}"
S=${WORKDIR}/${MY_P}

inherit font

DESCRIPTION="An open-source Chinese font derived from Fontworks' Klee One"
HOMEPAGE="https://github.com/lxgw/LxgwWenKai"
SRC_URI="https://github.com/lxgw/LxgwWenKai/releases/download/v${PV}/LxgwWenKai-v${PV}.tar.gz -> ${MY_P}.tgz"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~ppc ~riscv x86 ~ppc-macos ~x64-macos"
IUSE=""

# Only installs fonts
RESTRICT="binchecks strip test"

FONT_SUFFIX="ttf"
