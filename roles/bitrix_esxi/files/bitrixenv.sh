#!/bin/bash

filedir=/etc/php.d/
filename=bitrixenv.ini
file="$filedir$filename"

if [ -s $file ]; then
        # The file is not-empty.
        cp $file $file.bak
else
        # The file is empty.
        rm  $file
        cp $file.bak $file
fi

