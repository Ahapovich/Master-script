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
echo "Welcome to Bash Toolkit!"
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
		echo "Starting Network Health Check..."
		"$SCRIPT_DIR/network-healthcheck/network-check.sh"
		re-turningf
	;;

	2)
		echo "Starting Service Health Check..."
		echo "Service configuration files are located in ./service-healthcheck/services"
		echo "Telegram reports are also available. Configure them using ./service-healthcheck/CHATID.txt and ./service-healthcheck/TOKEN.txt"
		echo "For more information, refer to ./service-healthcheck/README.md"
		"$SCRIPT_DIR/service-healthcheck/service-healthcheck.sh"
		re-turningf
	;;
	
	3)
		echo "Log Check requires two arguments:"
		echo "<log_file> <pattern>"
		echo "Example patterns: ERR, FAIL, CRITICAL"
		read -r arg1 arg2
		"$SCRIPT_DIR/logscript/scriptlog.sh" "$arg1" "$arg2"
		re-turningf
	;;
	
	4)
		echo "Backup requires three arguments:"
		echo "<source> <backup_directory> <retention_days>"
		echo "ATTENTION: Archives older than the specified retention period will be deleted."
		echo "For example, setting the retention period to 7 days will delete backup archives older than 7 days."
		read -r arg1 arg2 arg3
		"$SCRIPT_DIR/backupS/backupscriptf" "$arg1" "$arg2" "$arg3"
		re-turningf
	;;
	
	5)
		echo "Disk Check requires one argument:"
		echo "<directory>"
		echo "Specify the directory whose disk usage you want to check."
		read -r arg1
		"$SCRIPT_DIR/diskscript/discheck.sh" "$arg1"
		re-turningf
	;;
	
	0)
		echo "Exiting BASH TOOLKIT..."
	;;

	*)
		echo "Invalid input. Please choose an option from 0 to 5."
		echo "Enter 0 to exit."
		re-turningf
	;;
	
esac
done
echo ""
echo "Bash Toolkit has finished. Goodbye!"
echo ""
