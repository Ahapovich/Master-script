#!/bin/bash
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 2
fi
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
ANSWER="999"
re-turningf () {
	echo ""
	echo "========================"
	echo "Returning to main menu..."
	echo "========================"
	echo ""
}
echo "Hello, this is the master script"
while [ "$ANSWER" != "0" ]
do
echo "========================"
echo "     BASH TOOLKIT"
echo "========================"
echo "1. Network Health Check"
echo "2. Service Health Check"
echo "3. Log Check"
echo "4. Backup"
echo "5. Disk Check"
echo "0. Exit"
echo ""
if ! read -r -p "Choose an option: " ANSWER; then
    echo "Input closed. Exiting..."
    break
fi
case "$ANSWER" in 
	1)
		echo "You have selected the script for checking network connection"
		"$SCRIPT_DIR/network-healthcheck/network-check.sh"
		re-turningf
	;;

	2)
		echo "You have selected a script to test the operation of services on your Linux Ubuntu machine."
		echo "Please note that the script operates based on the services you have selected. The file with services are located in directory ./service-healthcheck/services"
		echo "The script can also send you report data via Telegram; to do this, use the files ./service-healthcheck/CHATID.txt and ./service-healthcheck/TOKEN.txt"
		echo "For more information, refer to the instructions in the ./service-healthcheck/README.md file."
		"$SCRIPT_DIR/service-healthcheck/service-healthcheck.sh"
		re-turningf
	;;
	
	3)
		echo "Please enter the details as set out in the following instructions"
		echo "Please enter the following details <logfile.log> <problemtype>"
		echo "Problem type looks like ERR|FAIL|CRITICAL|etc."
		read -r arg1 arg2
		"$SCRIPT_DIR/logscript/scriptlog.sh" "$arg1" "$arg2"
		re-turningf
	;;
	
	4)
		echo "Please enter the details as set out in the following instructions"
		echo "Please enter the following details <source> <backup_directory> <number>"
		echo "ATTENTION! Number represents the number of days; all backup archives created before the specified date will be deleted. For example, if you enter 7, all backups older than 7 days will be deleted."
		read -r arg1 arg2 arg3
		"$SCRIPT_DIR/backupS/backupscriptf" "$arg1" "$arg2" "$arg3"
		re-turningf
	;;
	
	5)
		echo "Please enter the details as set out in the following instructions"
		echo "Please enter the following details <directory>"
		echo "The ‘directory’ value refers to the folder whose weight you wish to check "
		read -r arg1
		"$SCRIPT_DIR/diskscript/discheck.sh" "$arg1"
		re-turningf
	;;
	
	0)
		echo "Exiting BASH TOOLKIT..."
	;;

	*)
		echo "Wrong input. Please choose an option from 1 to 5."
		echo "Wrong input. Please chose 0 if you want exit"
		re-turningf
	;;
	
esac
done
echo ""
echo "The script has finished running. See you soon."
echo ""
