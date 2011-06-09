#!/bin/sh
# source_release.sh - Build a source tarball of Mong
# Copyright (c) 2011-06-09 Thomas Perl <thp.io/about>
# Released under the same terms as the mong source code.

if [ $# -eq 1 -a "$1" == "release" ]; then
    echo "Building stable release for latest version."
    MODE=release
elif [ $# -eq 1 -a "$1" == "snapshot" ]; then
    echo "Building snapshot release."
    MODE=snapshot
else
    echo "Usage: $0 [release|snapshot]"
    echo "  e.g. $0 release  (build stable release)"
    echo "       $0 snapshot (build snapshot)"
    exit 1
fi

MONG_SPEC=mong.spec
CONFIG_H=src/config.h

if [ ! -f $MONG_SPEC -o ! -f $CONFIG_H ]; then
    echo "Please run from the source root ($MONG_SPEC + $CONFIG_H needed)."
    exit 1
fi

VERSION=`cat $CONFIG_H | grep '^#define MONG_VERSION' | cut -d\" -f2`

echo -n "Updating version ($VERSION) in $MONG_SPEC from $CONFIG_H..."
sed -i -e "s/^Version:.*/Version:$VERSION/" $MONG_SPEC
echo "done."

if ! git show-ref -q $VERSION; then
    echo "No Git tag found for stable release: $VERSION"
    exit 1
fi

NAME=`cat mong.spec | grep ^Name: | cut -d: -f2 | tr -d ' '`

if [ "$MODE" == "release" ]; then
    echo "Building stable release from Git tag $VERSION."
    REF=$VERSION
else
    # Make sure the version reflects the non-taggedness of the source
    VERSION="$VERSION+git`date +%Y%m%d`"

    echo "Building snapshot release from 'master' as $VERSION."
    REF=master
fi

DIRNAME="$NAME-$VERSION"

echo -n "Building tarball for version $VERSION..."
git archive --prefix=$DIRNAME/ --format=tar $REF | gzip >$DIRNAME.tar.gz
echo "done."

