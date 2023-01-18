#!/usr/bin/bash
##Created By Arshad
dest=""
src=""
filename="test.txt"
while read -r line; do
    name="$line"
    if [[ $name =~ /shared ]]
    then
        dest=$name
    elif [[ $name =~ /ftpvolume ]]
    then
        src=$name
        echo "scp $src/EStamp.PDF oracle@10.125.243.5:$dest/EStamp.PDF"
        scp "$src/EStamp.PDF" "oracle@10.125.243.5:$dest/EStamp.PDF"
    fi
    sleep 5
done< "$filename"
