#!/bin/bash

IFS=$'\n'

MRA_FILES=/media/fat/_Arcade/

# List the files, stash in an array
find "$MRA_FILES" -type f -iname "*mra" |\
    sed -e 's_.*/__' | sort | uniq -d |\
    while
      read -r fileName
      do
        # loop through the array and determine duplicate file names
        duplicateList=($(find _Arcade/ -type f | sed /_Alternatives/d |grep "$fileName"))

        #  Test for more than one found file in our array
        if [ "${#duplicateList[@]}" -ge "1" ];then

          # Let's sort by oldest to newest file in an array called 'sortedList'
          sortedList=($( for fileCopy in "${duplicateList[@]}"
            do
              echo $(stat -c %Y -- "$fileCopy")$'\t'"$fileCopy"
                done |\
                  sort -nk1,1 | cut -d $'\t' -f2- ))

          originalFile="${sortedList[0]}"
          newFile=($( echo "${sortedList[-1]}" ))

          echo "Newer: [$newFile]" 
          echo "Older: [$originalFile]"
          echo

          # finally, clean up these files
          # Uncomment line below to do destructive stuff!
#          \mv -f "$newFile" "$originalFile"
        fi
    done
