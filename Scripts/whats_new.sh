#!/bin/bash

# Modified time in days:
mdays=2

echo "Here is what's new in _Arcade in the last 48 hours:"
find /media/fat/_Arcade/ -mtime -$mdays -iname "*mra"|\
while read -r mra
  do
    echo " -" `basename "$mra"` "["`date +"%a, %b %d" -r "$mra"`"]"
  done

echo
echo "Here is what's new in compiled Mister Cores in the last 48 hours:"
find /media/fat/ -mtime -$mdays -iname "*rbf"|\
  while read -r rbf
    do
      echo " - in" `dirname "$rbf"` : `basename "$rbf"`  "["`date +"%a, %b %d" -r "$rbf"`"]"
    done

