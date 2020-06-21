#!/bin/sh
DIR=$(basename $1)
mkdir -p $DIR
cd $DIR
lynx -dump -listonly $1 | \
while read i ; do if [[ $i == *.?[a-zA-Z0-9] ]]; then wget $i; else echo $i >> not.download.links; fi  ; done
