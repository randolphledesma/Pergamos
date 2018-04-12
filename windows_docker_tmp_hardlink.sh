#!/bin/sh
mkdir /tmp/pergamos
cd /tmp/pergamos
find /projects/pergamos -mindepth 1 -maxdepth 1 |
while read filename
do
    ln -sv $filename $(basename $filename)
done