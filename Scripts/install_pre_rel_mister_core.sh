#!/bin/bash

#Grab version strings for both release versions and prerelease versions of mister
MISTER_REL_VER=$(grep -s VER /media/fat/MiSTer|cut -d':' -f2)
MISTER_PRE_VER=$(grep -s VER /media/fat/MiSTer.dms|cut -d':' -f2)

# Convert date strings to unix time
todate=$(date -d $MISTER_REL_VER +%s)
cond=$(date -d $MISTER_PRE_VER +%s)

# Compare against the release version and the prerelease versions date strings
if [ $todate -ge $cond ];
  then
    echo "installed Mister binary - [$MISTER_REL_VER] newer than test binary Mister.dms - [$MISTER_PRE_VER]"
  else
    echo "Swapping in newer bleeding edge Mister binary [$MISTER_PRE_VER]"
    sudo killall MiSTer
    cp /media/fat/MiSTer /media/fat/MiSTer.backup.$MISTER_REL_VER
    cp /media/fat/MiSTer.dms /media/fat/MiSTer
    echo "Rebooting..."
    sudo reboot
fi

