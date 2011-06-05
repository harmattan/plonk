#!/bin/sh

if [ ! -f mong.spec ]; then
    echo "mong.spec not found. wrong directory?"
    exit 1
fi

NAME=`cat mong.spec | grep ^Name: | cut -d: -f2 | tr -d ' '`
VERSION=`cat mong.spec | grep ^Version: | cut -d: -f2`

echo -n "Building tarball for version $VERSION..."

DIRNAME="$NAME-$VERSION"

git archive --prefix=$DIRNAME/ --format=tar master | gzip >$DIRNAME.tar.gz

echo "done."

