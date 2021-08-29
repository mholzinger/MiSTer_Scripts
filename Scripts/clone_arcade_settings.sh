#!/bin/bash

# Step one: make a pattern file
# grep -hrs '<rom index="0" zip="' _Arcade/_Sega16\ \(Jotego\)/|awk '{print $3}'|sed -e 's/zip//g' -e 's/=//g' -e 's/\"//g' -e 's/\.//g'|tr '|' '\n'|sort -u > /tmp/pattern
# step two: create a good working config file. this will be the clone template
# example
# find /media/fat/config/ -iname "*goldnaxe3*
# step three, after confirming this works, clone the files using the pattern file
# cat /tmp/pattern |xargs -L1 sh src/clone_settings.sh goldnaxe3

source="$1"
uncloned="$2"

config_path=/media/fat/config
controller_id=045e_028e_v3

# Config files to copy
declare -a config_patterns=(\
_scaler.cfg \
.CFG \
_volume.cfg \
_gamma.cfg \
_afilter.cfg \
)

# Test we are not copying to self, then run commands
if [[ "${source}" != "${uncloned}" ]];then
  for target in "${config_patterns[@]}"
  do
    # Test source file exists
    if [[ -f ${config_path}/${source}${target} ]]; then
      echo cp ${config_path}/\{"${source}","${uncloned}"\}${target} |sh
      sed -i "s/${source}/${uncloned}/g" ${config_path}/${uncloned}${target}
    fi
  done

  # Copy and edit controller config
  echo cp ${config_path}/inputs/\{${source},${uncloned}\}_input_${controller_id}.map |sh
  sed -i "s/${source}/${uncloned}/g" ${config_path}/inputs/${uncloned}_input_${controller_id}.map
fi
