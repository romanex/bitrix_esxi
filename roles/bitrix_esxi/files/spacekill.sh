#!/bin/bash
freespace=1024000
error=2000
date=`date +%y%m%d%H%M%S`
disk=$(cat /proc/mounts |grep " / "|awk 'NR == 1 {print $1}')
aval=$(df -P| grep $disk|awk 'NR == 1 {print $4}')
used=$(df -P| grep $disk|awk 'NR == 1 {print $3}')
total=$(df -P|grep $disk|awk 'NR == 1 {print $2}')
filesize=$(($total-$used-$freespace))
inaccuracy=$(($aval+$error))
if [ $inaccuracy -lt $freespace ]
then rm -f /root/temp*
disk=$(cat /proc/mounts |grep " / "|awk 'NR == 1 {print $1}')
aval=$(df -P| grep $disk|awk 'NR == 1 {print $4}')
used=$(df -P| grep $disk|awk 'NR == 1 {print $3}')
total=$(df -P|grep $disk|awk 'NR == 1 {print $2}')
total2=$(($aval+$used))
filesize=$(($total-$used-$freespace))
inaccuracy=$(($aval+$error))
fi
if [ $aval -gt $freespace ]
then dd if=/dev/zero of=/root/temp$date bs=1024 count=$filesize
fi
