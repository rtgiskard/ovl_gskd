# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils xdg-utils meson

DESCRIPTION="A simple GTK+ frontend for mpv"
HOMEPAGE="https://celluloid-player.github.io/"
SRC_URI="https://github.com/celluloid-player/celluloid/releases/download/v${PV}/celluloid-${PV}.tar.xz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64"

RDEPEND=">=dev-libs/glib-2.44
	>=x11-libs/gtk+-3.22.23:3
	>=media-video/mpv-0.27[libmpv]
	media-libs/libepoxy"
DEPEND="${RDEPEND}
	dev-util/glib-utils
	virtual/pkgconfig"

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
	gnome2_schemas_update
}
