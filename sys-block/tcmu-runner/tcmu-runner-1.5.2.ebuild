# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils linux-info

DESCRIPTION="A daemon that handles the userspace side of the LIO TCM-User backstore"
HOMEPAGE="https://www.open-iscsi.com/"
SRC_URI="https://github.com/open-iscsi/${PN}/archive/v${PVR}.tar.gz -> ${PF}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+fbo +glfs +qcow rbd +systemd +tcmalloc +zbc"

RDEPEND="
	dev-libs/glib:2
	dev-libs/libnl:3
	glfs? ( sys-cluster/glusterfs )
	rbd? ( sys-cluster/ceph )
	sys-apps/kmod
	sys-libs/zlib
	systemd? ( sys-apps/systemd )"
BDEPEND="
	glfs? ( sys-cluster/glusterfs )
	rbd? ( sys-cluster/ceph )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PF}"

pkg_setup() {
	linux-info_pkg_setup

	CONFIG_CHECK_MODULES="TCM_USER2"
	if linux_config_exists; then
		for module in ${CONFIG_CHECK_MODULES}; do
			linux_chkconfig_module ${module} || \
				ewarn "${module} needs to be built as module (builtin doesn't work)"
		done
	fi
}

src_configure() {
	local mycmakeargs

	mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX=/usr
		-DSUPPORT_SYSTEMD=$(usex systemd)
		-Dwith-fbo=$(usex fbo)
		-Dwith-glfs=$(usex glfs)
		-Dwith-qcow=$(usex qcow)
		-Dwith-rbd=$(usex rbd)
		-Dwith-tcmalloc=$(usex tcmalloc)
		-Dwith-zbc=$(usex zbc)
	)

	cmake-utils_src_configure
}
