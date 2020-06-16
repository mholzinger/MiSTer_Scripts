#!/bin/bash

# test for input
# TODO: validate integer value to set input
if [ -z "$1" ]
  then
    # Modified time in days:
    mdays=2
  else
    mdays="$1"
fi

# Modified time in days:
mdays=2

echo "Here is what's new in _Arcade in the last 48 hours:"
find /media/fat/_Arcade/ -mtime -$mdays -iname "*mra"|\
while read -r mra
  do
    echo `basename "$mra"`
  done

echo
echo "Here is what's new in compiled Mister Cores in the last 48 hours:"
find /media/fat/ -mtime -$mdays -iname "*rbf"|\
  while read -r rbf
    do
      echo Core in `dirname "$rbf"` : `basename "$rbf"`
    done
