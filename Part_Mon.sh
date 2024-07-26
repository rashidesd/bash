#!/bin/sh
df -H /u01 | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 " " $6}' | while read output;
echo " new change"
do
  echo $output
  usep=$(echo $output | awk '{ print $1}' | cut -d'%' -f1  )
  partition=$(echo $output | awk '{ print $2 "  " $3}' )
  if [ $usep -ge 79 ]; then
    echo "Running out of space \"$partition ($usep%)\" on $(hostname) as on $(date)" |
   mail -r no.reply@efuinsurance.com -s "Alert: Almost out of disk space $usep% on $(hostname)" abdul.ghafoor@efuinsurance.com rashid.siddiqui@efuinsurance.com
  fi
done