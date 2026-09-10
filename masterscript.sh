#!/bin/bash
ANSWER="0"
arg1="0"
arg2="0"
arg3="0"
echo "Hello, this is the master script"
echo "========================"
echo "     BASH TOOLKIT"
echo "========================"
echo "1. Service Health Check"
echo "2. Log Check"
echo "3. Backup"
echo "4. Disk Check"
echo "5. Exit"
echo ""
read -r -p "Choose an option: " ANSWER
case "$ANSWER" in 
1)
echo "You have selected the script for checking and restoring services"
sudo ./service-healthcheck/service-healthcheck.sh
;;
2)
echo "Please enter the details as set out in the following instructions"
echo "Please enter the following details <logfile.log> <problemtype>"
echo "Problem type looks like ERR|FAIL|CRITICAL|etc."
read arg1 arg2
 ./logscript/scriptlog.sh "$arg1" "$arg2"
;;
3)
echo "Please enter the details as set out in the following instructions"
echo "Please enter the following details <source> <backup_directory> <number>"
echo "ATTENTION! Number represents the number of days; all backup archives created before the specified date will be deleted. For example, if you enter 7, all backups older than 7 days will be deleted."
read arg1 arg2 arg3
sudo ./backupS/backupscriptf "$arg1" "$arg2" "$arg3"
;;
4)
echo "Please enter the details as set out in the following instructions"
echo "Please enter the following details <directory>"
echo "The ‘directory’ value refers to the folder whose weight you wish to check "
read arg1
sudo ./diskscript/discheck.sh "$arg1"
;;
5)
exit 0
;;
*)
echo "The script has finished running. Wrong input."
exit 2
;;
esac
echo "The script has finished running. See you soon."
