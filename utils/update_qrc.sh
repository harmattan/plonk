#!/bin/sh
# update_qrc.sh - Recursively create a .qrc file from a directory
# Copyright (c) 2011-05-28 Thomas Perl <thp.io/about>
# Released under the same terms as the mong source code.

QRC_FILE=mong.qrc
SRC_DIRS=qml/

echo -n "Updating $QRC_FILE from files in $SRC_DIRS ... "
(
cat <<EOF
<RCC>
    <qresource prefix="/">
EOF

find $SRC_DIRS -type f -exec echo "        <file>{}</file>" \; | sort

cat <<EOF
    </qresource>
</RCC>
EOF
) >$QRC_FILE
echo "done."

