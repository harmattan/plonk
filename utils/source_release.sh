#!/bin/sh

if [ ! -f mong.spec ]; then
    echo "mong.spec not found. wrong directory?"
    exit 1
fi

VERSION=`cat mong.spec | grep ^Version: | cut -d: -f2`

echo -n "Building tarball for version $VERSION..."

git archive --prefix=mong-$VERSION/ --format=tar master | gzip >mong-$VERSION.tar.gz

echo "done."

