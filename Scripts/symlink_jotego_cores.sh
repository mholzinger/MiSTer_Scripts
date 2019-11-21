#!/bin/bash

# This script creates symlinks with friendly names for the Jotego cores
# jotego cores found at: https://github.com/jotego/jtbin/blob/master/mister/update/mister_updater_jtcores.sh
# Support Jose Tejada on patreon https://www.patreon.com/topapate

ARCADE=/media/fat/_Arcade

# Remove previous jotego symlinks

for symlink in $(ls -lH $ARCADE | grep -E "(\->|jt*.rbf)"|awk '{print $8}')
do
  unlink $ARCADE/$symlink
done

# Write new symlinks!
(
  cd $ARCADE

  find $ARCADE -name "jt*.rbf" | while read -r core
  do
    newcore=$(echo `basename "$core"` | sed -e 's/jt//g')
    newcore="$(tr '[:lower:]' '[:upper:]' <<< ${newcore:0:1})${newcore:1}"
    ln -s "$core" "$newcore"
  done
)

