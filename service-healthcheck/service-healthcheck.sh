#!/bin/bash
GROUP=(web docker database security network)
if [ ! -s "TOKEN.txt" ] ; then
echo "TOKEN.txt is empty, please enter your bot token before starting"
exit 3
fi
if [ ! -s "CHATID.txt" ] ; then
echo "CHATID.txt is empty, please enter your chat ID before starting"
exit 3
fi
TOKEN=$(cat TOKEN.txt | tr -d '[:space:]')
CHAT_ID=$(cat CHATID.txt | tr -d '[:space:]')
alert="0"
BADTYPE=()
MAX_ATTEMPTS=2

for G in "${GROUP[@]}"
	do
		FILE="services/${G}.txt"
		echo ""
		echo "------ ${G^^} SERVICES ------"
		echo ""
				if [[ ! -f "$FILE" ]]
					then
   					 echo "File not found: $FILE"
   					 continue
				fi
				GROUP_HAS_ERRORS=0
while IFS= read -r SERVICE || [[ -n "$SERVICE" ]]; do
        [[ -z "$SERVICE" || "$SERVICE" =~ ^# ]] && continue 
        
        if systemctl is-active --quiet "$SERVICE" 2>/dev/null; then
            echo "$SERVICE is working"
        else
            echo "$SERVICE is down. Attempting to restore..."
            SUCCESS=false
          
            for ((attempt=1; attempt<=MAX_ATTEMPTS; attempt++)); do
                echo "  Attempt $attempt of $MAX_ATTEMPTS..."
                sudo systemctl restart --quiet "$SERVICE" 2>/dev/null
                sleep 3
                
                if systemctl is-active --quiet "$SERVICE" 2>/dev/null; then
                    echo "  $SERVICE successfully restored!"
                    SUCCESS=true
                    break
                fi
            done
            
            if [ "$SUCCESS" = false ]; then
                echo "$SERVICE isn't working"
                ((alert++))
                
                if [[ $GROUP_HAS_ERRORS -eq 0 ]]; then
                    BADTYPE+=("${G^^}:")
                    GROUP_HAS_ERRORS=1
                fi
                BADTYPE+=("  - $SERVICE")
            fi
        fi
    done < "$FILE"
done

IFS=$'\n'
MESSEAGET="ALERT! This services not working:${IFS}${BADTYPE[*]}"
if [ "$alert" -ge 1 ]
then 
curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" \
     -d "chat_id=$CHAT_ID" \
     -d "text=$MESSEAGET"
fi
