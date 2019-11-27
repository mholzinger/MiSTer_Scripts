#!/bin/bash

# Script to install latest rbf build of intellivision from Grabulosaure 
# Github project at https://github.com/Grabulosaure/Intv_MiSTer
# Compiled project file for MiSTer - http://temlib.org/pub/mister/Intv.rbf

REMOTE_FILE="http://temlib.org/pub/mister/Intv.rbf"
LOCALFILE=$(\ls -1tr /media/fat/_Console/[Ii]ntv*.rbf|tail -1)

# Do stuff in a tmp path, copy installed file over and test to see if newer available
WORKING_DIR=$(mktemp -d)
cd "$WORKING_DIR"
cp  --preserve "$LOCALFILE" `basename "$REMOTE_FILE"`

checksum_local_intv=$(sha1sum "$LOCALFILE"|awk '{print $1}')
echo "Installed: `basename $LOCALFILE` - $checksum_local_intv"

# Cheap, works
wget --no-check-certificate -N $REMOTE_FILE

# Copy new file to _Console
cp --preserve `basename $REMOTE_FILE` /media/fat/_Console/Intv_`stat -c %Y Intv.rbf | awk '{print strftime("%Y%m%d", $1)}'`.rbf
