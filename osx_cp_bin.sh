#!/bin/bash
# gets the lib deps of a binary and puts them in a chroot jail
# must run as root

if [ $# -lt 2 ]; then
    echo "USAGE: $0 binary dest" >&2
    exit 1
fi

binary=$1
shift
dest=$1    # destination root
shift

for dep in `otool -L $binary | tail -n+2 | grep -o '/[^ ][^ ]*'`; do
  depdir=`dirname $dep`
  mkdir -p ${dest}/${depdir}
  cp -p $dep ${dest}/${depdir}/
done

bindir=`dirname $binary`
mkdir -p ${dest}/${bindir}
cp -p $binary ${dest}/${bindir}/
