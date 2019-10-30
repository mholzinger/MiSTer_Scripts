#!/bin/bash

STATUS_FILE=/media/fat/status.txt

while inotifywait -q -e modify /var/log/CORENAME >/dev/null
do
  CORENAME=$(cat /var/log/CORENAME)
  MISTER_VER=$(grep -s VER /media/fat/MiSTer|cut -d':' -f2)
  source /etc/os-release
  echo "MiSTer ver: $MISTER_VER | OS: $PRETTY_NAME | Loaded core: $CORENAME" > $STATUS_FILE
done

