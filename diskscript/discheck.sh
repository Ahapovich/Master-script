#!/bin/bash
if [ "$#" -ne 1 ] ; then
echo "ERROR: 1 argument are required"
echo "Usage: ./discheck.sh <directory>"
exit 3
fi
CHDIR="$1"
if [[ ! -f "$CHDIR" && ! -d "$CHDIR" ]]; then
	echo "ERROR: $CHDIR isnt file or directory"
	exit 3
fi
if [[ ! -r "$CHDIR" ]] ; then
	echo "ERROR: $CHDIR does not exist or you do not have permission to access it"
	exit 3
fi
size_check() {
local DIREC_SIZE DIREC_PATH
read -r DIREC_SIZE DIREC_PATH <<< "$(du -shx "$CHDIR" | awk 'NR==1 {print $1, $2}')"
echo ""
echo "====Directory / File Size===="
echo ""
echo "Path: $DIREC_PATH"
echo "Size: $DIREC_SIZE"
echo ""
echo "============================="
echo ""
}
echo_disc() {
echo "==== Filesystem Usage ===="
echo ""
echo "Filesystem: $DISC_FILE"
echo "Mount point: $DISC_MOUNT"
echo "Total: $DISC_TOTAL"
echo "Used: $DISC_USED"
echo "Available: $DISC_AVAIL"
echo "Usage :$DISC_PERCENT""%"
echo ""
echo "========================="
}
disc_check() {
read -r DISC_FILE DISC_TOTAL DISC_USED DISC_AVAIL DISC_PERCENT DISC_MOUNT <<< "$(df -h "$CHDIR" 2>/dev/null | awk 'NR==2 {gsub(/%/, ""); print $1, $2, $3, $4, $5, $6}')"
if ((DISC_PERCENT <= 70)) ; then
echo_disc
exit 0
elif ((DISC_PERCENT <=85)) ; then
echo "=====ATTENTION===="
echo "The storage is more them 70% full"
echo ""
echo_disc
exit 1
else
echo "=====CRITICAL===="
echo "The storage is more than 85% full"
echo "Please check these directories and free up some space"
du -axh "$DISC_MOUNT" 2>/dev/null | sort -rh | head -n 10
echo_disc
exit 2
fi
}
wait=("." ".." "...")
size_check &
FUNC_PID=$!
while kill -0 $FUNC_PID 2>/dev/null ; do
for i in "${wait[@]}" ; do
echo -ne "Processing$i \r"
sleep 0.1
done
done
disc_check
