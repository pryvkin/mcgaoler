#!/bin/bash
# osx_cp_bin.sh - gets the lib deps of a binary and puts them in a chroot jail

# Copyright (C) 2013 Paul Ryvkin
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License 
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# NOTE: run as root

if [ $# -lt 2 ]; then
    echo "USAGE: $0 binary dest" >&2
    exit 1
fi

binary=$1
shift
dest=$1    # root of jail
shift

# copy the dependencies in
for dep in `otool -L $binary | tail -n+2 | grep -o '/[^ ][^ ]*'`; do
  depdir=`dirname $dep`
  mkdir -p ${dest}/${depdir}
  cp -p $dep ${dest}/${depdir}/
done

# copy the binary in
bindir=`dirname $binary`
mkdir -p ${dest}/${bindir}
cp -p $binary ${dest}/${bindir}/
