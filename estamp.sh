#Created By Arshad

echo "Enter FTP Source :"
read source
echo $source

ls -l $source

echo "Enter APP Destination :"
read destination
echo $destination

cd $source  && sudo unzip *.zip && scp EStamp.PDF oracle@10.125.243.5:$destination

echo "Files Copied..."
