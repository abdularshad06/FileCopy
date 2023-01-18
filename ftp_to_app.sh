#Created By Arshad

echo "Enter FTP Source :"
read source
echo $source

ls -l $source

echo "Enter APP Destination :"
read destination
echo $destination

scp $source/*  oracle@10.125.243.5:$destination

