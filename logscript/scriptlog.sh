#!/bin/bash
if [ "$#" -ne 2 ] ; then
echo "ERROR: 2 arguments are required"
echo "Usage: ./logscript.sh <logfile.log> <problemtype>"
echo "Problem type looks lige ERR|FAIL|CRITICAL|etc."
exit 2
fi
LOGFILE="$1"
LOGKEY="$2"
if [[ ! -f "$LOGFILE" ]] ; then
	echo "ERROR, file not found: $LOGFILE"
	exit 1
fi
if [[ ! -r "$LOGFILE" ]] ; then
    echo "ERROR: cannot read file: $LOGFILE"
    exit 1
fi
if [[ -z "$LOGKEY" ]] ; then 
    echo "ERROR: problem type cannot be empty"
    exit 2
fi
grep "$LOGKEY" "$LOGFILE" 
