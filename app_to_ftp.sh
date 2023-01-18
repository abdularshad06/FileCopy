#Created By Arshad

#!/bin/sh

#Create directory in FTP-Path
echo "Enter Incident ID :"
read inc_id
sudo mkdir -p /ftpvolume/FileUpload/$inc_id
echo "Directory Created"


echo "Enter Source Directory :"
read source_directory
echo oracle@10.125.243.5:$source_directory

destination="/ftpvolume/FileUpload/"$inc_id"/"
echo $destination


#Copy Files
sudo sshpass -f pass scp -r oracle@10.125.243.5:$source_directory  $destination
echo "Files Copied..."

sudo chown -R wipro-user.ftpgroup $destination
echo "Ownership Changed..."
