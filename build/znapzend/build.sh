#!/usr/bin/bash
#
# {{{ CDDL HEADER
#
# This file and its contents are supplied under the terms of the
# Common Development and Distribution License ("CDDL"), version 1.0.
# You may only use this file in accordance with the terms of version
# 1.0 of the CDDL.
#
# A full copy of the text of the CDDL should have accompanied this
# source. A copy of the CDDL is also available via the Internet at
# http://www.illumos.org/license/CDDL.
# }}}
#
# Copyright 1995-2013 OETIKER+PARTNER AG  All rights reserved.
# Copyright 2024 OmniOS Community Edition (OmniOSce) Association.

. ../../lib/build.sh

PROG=znapzend
VER=0.23.2
PKG=ooce/system/znapzend
SUMMARY="A ZFS-aware backup script"
DESC="Take snapshots and transfer them to a second pool, "
DESC+="potentially on a different box"

OPREFIX=$PREFIX
PREFIX+="/$PROG"

set_arch 64

XFORM_ARGS="
    -DPREFIX=${PREFIX#/}
    -DOPREFIX=${OPREFIX#/}
    -DPROG=$PROG
    -DPKGROOT=$PROG
"

CONFIGURE_OPTS[amd64]="
    --prefix=$PREFIX
"

# Some perl modules have started using GNU extensions when packaging their
# distributions, so we need GNU tar first in the path.
PATH=$GNUBIN:$PATH

init
download_source $PROG $PROG $VER
patch_source
prep_build
build
install_smf system system-$PROG.xml
make_package
clean_up

# Vim hints
# vim:ts=4:sw=4:et:fdm=marker
