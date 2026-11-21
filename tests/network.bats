#!/usr/bin/env bats

setup() {
    export PATH="$BATS_TEST_DIRNAME/mocks:$PATH"
    export MOCK_IP_SERVICE=true
    export MOCK_PING_GATEWAY=true
	export MOCK_PING_INTERNET=true
	export MOCK_DNS=true
	export MOCK_CURL=true
}

@test "Network script detects an active IPv4 interface" {

	cd "$BATS_TEST_TMPDIR"
    run bash "$BATS_TEST_DIRNAME/../network-healthcheck/network-check.sh"
    echo "$output"
    [ "$status" -eq 0 ]
    [[ "$output" == *"Network interface is active"* ]]
    
}

@test "Network script detects missing IPv4 interface" {
	cd "$BATS_TEST_TMPDIR"
	export MOCK_IP_SERVICE=false
	touch "$BATS_TEST_TMPDIR/IPWORK"
    run bash "$BATS_TEST_DIRNAME/../network-healthcheck/network-check.sh"
    echo "$output"
    [ "$status" -eq 1 ]
    [[ "$output" == *"No active network interface with IPv4 address"* ]]
    
}

@test "Network script detects a missing default gateway" {
	cd "$BATS_TEST_TMPDIR"
	export MOCK_IP_SERVICE=false
	touch "$BATS_TEST_TMPDIR/GATEWAYWORK"
    run bash "$BATS_TEST_DIRNAME/../network-healthcheck/network-check.sh"
    echo "$output"
    [ "$status" -eq 1 ]
    [[ "$output" == *"Default gateway not found"* ]]
}


@test "Network script detects an unreachable default gateway" {
	cd "$BATS_TEST_TMPDIR"
	export MOCK_PING_GATEWAY=false
    run bash "$BATS_TEST_DIRNAME/../network-healthcheck/network-check.sh"
    echo "$output"
    [ "$status" -eq 1 ]
    [[ "$output" == *"Default gateway is not responding"* ]]
}


@test "Network script detects unavailable internet connectivity" {
	cd "$BATS_TEST_TMPDIR"
	export MOCK_PING_INTERNET=false
    run bash "$BATS_TEST_DIRNAME/../network-healthcheck/network-check.sh"
    echo "$output"
    [ "$status" -eq 1 ]
    [[ "$output" == *"Internet connection is unavailable"* ]]
}

@test "Network script detects DNS resolution failure" {
	cd "$BATS_TEST_TMPDIR"
	export MOCK_DNS=false
    run bash "$BATS_TEST_DIRNAME/../network-healthcheck/network-check.sh"
    echo "$output"
    [ "$status" -eq 1 ]
    [[ "$output" == *"DNS resolution failed"* ]]
}

@test "Network script detects HTTPS connection failure" {
	cd "$BATS_TEST_TMPDIR"
	export MOCK_CURL=false
    run bash "$BATS_TEST_DIRNAME/../network-healthcheck/network-check.sh"
    echo "$output"
    [ "$status" -eq 1 ]
    [[ "$output" == *"HTTPS connection failed"* ]]
}
