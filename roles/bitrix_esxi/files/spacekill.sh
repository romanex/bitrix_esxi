#!/bin/bash
while true 
do

freespace=1048576
date=`date +%y%m%d%H%M%S`
#
 disk=$(df -P | awk '$NF == "/" { print $1 }')
 aval=$(df -P | awk '$NF == "/" { if($5 == "/") print $3; else print $4 }')
 used=$(df -P | awk '$NF == "/" { if($5 == "/") print $2; else print $3 }')
 total=$(df -P | awk '$NF == "/" { print $2 }')
 filesize=$(($total-$used-$freespace))


 if (( $aval >= 921600 && $aval <= 1126400 ))
  then
   echo All is ok
  elif [ $aval -lt $freespace ]
then
       tmpfile=$(ls -t | grep temp | head -n2) && rm -f $tmpfile
       disk=$(df -P | awk '$NF == "/" { print $1 }')
       aval=$(df -P | awk '$NF == "/" { if($5 == "/") print $3; else print $4 }')
       used=$(df -P | awk '$NF == "/" { if($5 == "/") print $2; else print $3 }')
       total=$(df -P|awk 'NR == 2 {print $2}')
       filesize=$(($total-$used-$freespace))
   else
    dd if=/dev/zero of=/root/temp$date bs=1024 count=$filesize
fi

sleep 10
done