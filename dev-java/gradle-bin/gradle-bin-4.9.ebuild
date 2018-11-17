# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

MY_PN=${PN%%-bin}
MY_P="${MY_PN}-${PV/_rc/-rc-}"

DESCRIPTION="A project automation and build tool with a Groovy based DSL"
HOMEPAGE="https://gradle.org/"
SRC_URI="https://services.gradle.org/distributions/${MY_P}-all.zip"

LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/zip"
RDEPEND=">=virtual/jdk-1.6"

IUSE="doc examples source"

S="${WORKDIR}/${MY_P}"

src_install() {
	local gradle_dir="${EPREFIX}/usr/share/${PN}-${SLOT}"

	dodoc docs/release-notes.html getting-started.html

	insinto "${gradle_dir}"

	# source
	if use source ; then
		java-pkg_dosrc src/*
	fi

	# docs
	if use doc ; then
		java-pkg_dojavadoc docs/javadoc
	fi

	# examples
	if use examples ; then
		java-pkg_doexamples samples
	fi

	insinto "${gradle_dir}"
	doins -r bin/ lib/
	fperms 755 "${gradle_dir}/bin/gradle"
	dosym "${gradle_dir}/bin/gradle" "/usr/bin/${MY_PN}-${SLOT}"
}
