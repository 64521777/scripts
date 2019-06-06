#!/usr/bin/env bash
#usage: $0 inputFile outputFile

while read i; do echo "$RANDOM;$i"; done<$1|sort -k2n|cut -d";" -f2 >> $2