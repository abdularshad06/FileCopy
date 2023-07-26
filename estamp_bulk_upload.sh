#!/bin/sh
##Created By Arshad
#set -xe

cat << "EOF"

 _____       _____ _____ ___  ___  _________  ______       _ _      _   _       _                 _ 
|  ___|     /  ___|_   _/ _ \ |  \/  || ___ \ | ___ \     | | |    | | | |     | |               | |
| |__ ______\ `--.  | |/ /_\ \| .  . || |_/ / | |_/ /_   _| | | __ | | | |_ __ | | ___   __ _  __| |
|  __|______|`--. \ | ||  _  || |\/| ||  __/  | ___ \ | | | | |/ / | | | | '_ \| |/ _ \ / _` |/ _` |
| |___      /\__/ / | || | | || |  | || |     | |_/ / |_| | |   <  | |_| | |_) | | (_) | (_| | (_| |
\____/      \____/  \_/\_| |_/\_|  |_/\_|     \____/ \__,_|_|_|\_\  \___/| .__/|_|\___/ \__,_|\__,_|
                                                                         | |                        
                                                                         |_|                        
EOF

# Include files.

. ${PWD}/support/variables.sh

ip=10.125.243.5
user=oracle
dest=""
src=""
filename="entries.txt"
echo -e "${GREEN}Estamp Uploading is in progress Please be Patience... For check Live logs please use ==> \" tail -f ${PWD}/logs.txt \" ${NOCOLOR}"
echo
sleep 10
while read -r line; do
    name="$line"
    if [[ $name =~ /shared ]]
    then
        dest=$name
	
	if sshfs ${user}@${ip}:/ /home/${user}/scripts/sshfs
	then
		if [[ ! -d /home/${user}/scripts/sshfs/${dest}  ]]
		then
		echo "${dest} ==> Destination Directory is not Exist..."  >> logs.txt 2>&1
		mkdir -p /home/${user}/scripts/sshfs${dest} && echo "${dest} ==> Destination Directory Created Successfully..."  >> logs.txt 2>&1
		fi
	fusermount -u /home/${user}/scripts/sshfs
	sleep 1
	fi
	
    elif [[ $name =~ /ftpvolume ]]
    then
        src=$name
	current_date=$(date +'%d-%b-%Y--%H:%M:%S')
	echo "${current_date} - scp $src/EStamp.PDF ${user}@${ip}:$dest/EStamp.PDF"  >> logs.txt 2>&1
        scp "$src/EStamp.PDF" "${user}@${ip}:$dest/EStamp.PDF"  >> logs.txt 2>&1
	if [[ $? -eq 0 ]]
	then
		echo -e "Uploaded Sucessfully..." >> logs.txt 2>&1
	elif [[ $? -ne 0 ]]
	then
        	echo -e "scp $src/EStamp.PDF ${user}@${ip}:$dest/EStamp.PDF"
		echo
               	echo -e "${RED}Something Went Wrong Please Check Log File For Actual Root Cause...${NOCOLOR}"
		echo

	fi
    fi
    sleep 1
done< "$filename"
echo
echo -e "${GREEN}Script Executed Successfully... For check logs please open file. \" cat ${PWD}/logs.txt \" ${NOCOLOR}"
echo
echo -e "${GREEN}Success Status  ==> $(cat logs.txt | grep -i "Uploaded Sucessfully" | wc -l)${NOCOLOR}"
echo "Success Status  ==> $(cat logs.txt | grep -i "Uploaded Sucessfully" | wc -l)" >> logs.txt 2>&1
echo
echo -e "${RED}Failure Status  ==> $(cat logs.txt | grep -i "No Such File or Directory" | wc -l)${NOCOLOR}"
echo "Failure Status  ==> $(cat logs.txt | grep -i "No Such File or Directory" | wc -l)" >> logs.txt 2>&1

echo
cat ${PWD}/logs.txt | grep -i "No such file or directory"
echo

if cat logs.txt | grep -i "scp: /shared" | grep -i "No such file or directory" && echo -e "\n This is for destination End"
then
	echo
	#cat logs.txt | grep -i "scp: /shared" | grep -i "No such file or directory"
        echo -e "${RED}Please Create Above Directories Manually... It is not Created Automatically Due to Some Issue...${NOCOLOR}"
	echo

else
	echo > entries.txt
fi

exit 0
