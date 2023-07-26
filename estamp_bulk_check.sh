##Created By Arshad

#!/bin/sh

# Include files.

. ${PWD}/support/variables.sh


if [[ -f logs.txt  ]]
then
	mv logs.txt /home/oracle/scripts/logs/logs.txt-$(date '+%d-%b-%Y-%T')
	echo -e "${GREEN}Old Log File is Backed Up and New Log File is Generated for You...${NOCOLOR}"	
elif [[ -f logs.txt ]] || touch logs.txt
then
	echo -e "${GREEN}Log File is not Exist, Creating Logs Files...${NOCOLOR}"
	sleep 3
fi
dest=""
src=""
filename="entries.txt"
while read -r line; do
    name="$line"
    if [[ $name =~ /shared ]]
    then
        dest=$name
    elif [[ $name =~ /ftpvolume ]]
    then
        src=$name
	echo "scp $src/EStamp.PDF oracle@10.125.243.5:$dest/EStamp.PDF"
        #scp "$src/EStamp.PDF" "oracle@10.125.243.5:$dest/EStamp.PDF"
    fi
    #sleep 1
done< "$filename"

current_date=$(date +'%d-%b-%Y--%H:%M:%S')
echo "${current_date} - Estamp Check Executed Successfully" >> logs.txt 2>&1
