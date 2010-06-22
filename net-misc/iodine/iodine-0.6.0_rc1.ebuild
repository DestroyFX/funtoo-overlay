# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/iodine/iodine-0.6.0_rc1.ebuild,v 1.1 2010/03/16 17:41:28 vostorga Exp $

inherit linux-info eutils

MY_P="${P/_/-}"

DESCRIPTION="IP over DNS tunnel"
HOMEPAGE="http://code.kryo.se/iodine/"
SRC_URI="http://code.kryo.se/${PN}/${MY_P}.tar.gz"

CONFIG_CHECK="TUN"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="sys-libs/zlib"
DEPEND="${RDEPEND}
	test? ( dev-libs/check )"

S="${WORKDIR}/${MY_P}"

src_compile() {
	emake CC="$(tc-getCC)" || die "make failed"
}

src_install() {
	dobin bin/iodine bin/iodined || die "binaries failed"
	dodoc README CHANGELOG || die "docs failed"
	doman man/iodine.8 || die "man failed"

	newinitd "${FILESDIR}"/iodined.init iodined || die "initd failed"
	newconfd "${FILESDIR}"/iodined.conf iodined || die "confd failed"
	keepdir /var/empty
}