#!/bin/bash
FAIL="0"
decor-func() {
	echo "========================"
}
echo "========================"
echo "   NETWORK HEALTH CHECK"
echo "========================"
echo ""
echo "Checking network interface..."
TEST_IP="1.1.1.1"
GATEWAY=$(ip route | grep "^default" | awk '{print $3}')
if ip -o -4 addr show scope global | grep -q .; then
decor-func
    echo "[OK] Network interface is active"
else
    echo "[FAIL] No active network interface with IPv4 address"
    ((FAIL++))
    decor-func
fi
if [ -n "$GATEWAY" ]; then
    echo "[OK] Default gateway: $GATEWAY"
    if ping -c 2 -W 2 "$GATEWAY" > /dev/null 2>&1
    then
    	echo "[OK] Default gateway is reachable"
    else
    	echo "[FAIL] Default gateway is not responding"
    	((FAIL++))
    fi
    
else
    echo "[FAIL] Default gateway not found"
    ((FAIL++))
fi
decor-func
echo "Checking internet connectivity..."
if ping -c 2 -W 2 "$TEST_IP" > /dev/null 2>&1; then
    echo "[OK] Internet connection is available"
else
    echo "[FAIL] Internet connection is unavailable"
    ((FAIL++))
fi
decor-func
echo "Checking DNS resolution..."
if getent ahostsv4 google.com > /dev/null 2>&1; then
    echo "[OK] DNS resolution is working"
else
    echo "[FAIL] DNS resolution failed"
    ((FAIL++))
fi
decor-func
echo "Checking HTTPS connectivity..."

if curl -Is --connect-timeout 5 https://google.com > /dev/null 2>&1; then
    echo "[OK] HTTPS connection is working"
else
    echo "[FAIL] HTTPS connection failed"
    ((FAIL++))
fi
decor-func
if [ "$FAIL" -ne 0 ]; then
echo "The network check failed"
exit 1
else
echo "The network check was successful"
exit 0
fi
