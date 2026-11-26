#!/usr/bin/env bats

setup() {
    export PATH="$BATS_TEST_DIRNAME/mocks:$PATH"
    export MOCK_SERVICE_RECOVERY=true
    export MOCK_CURL=true
}

@test "Service script required TOKEN in TOKEN.txt for TELEGRAM notification" {
	cd "$BATS_TEST_TMPDIR"
	touch "$BATS_TEST_TMPDIR/TOKEN.txt"
    run bash "$BATS_TEST_DIRNAME/../service-healthcheck/service-healthcheck.sh"

    [ "$status" -eq 0 ]
    [[ "$output" == *"TOKEN.txt is empty"* ]]
}

@test "Service script required CHATID in CHATID.txt for TELEGRAM notification" {
	cd "$BATS_TEST_TMPDIR"
	echo "TESTTOKEN" > "$BATS_TEST_TMPDIR/TOKEN.txt"
	touch "$BATS_TEST_TMPDIR/CHATID.txt"
    run bash "$BATS_TEST_DIRNAME/../service-healthcheck/service-healthcheck.sh"

    [ "$status" -eq 3 ]
    [[ "$output" == *"CHATID.txt is empty"* ]]
}

@test "Service script starts with valid TOKEN and CHATID" {
	cd "$BATS_TEST_TMPDIR"
	
	touch "$BATS_TEST_TMPDIR/TOKEN.txt"
	touch "$BATS_TEST_TMPDIR/CHATID.txt"
	echo "TESTTOKEN" > "$BATS_TEST_TMPDIR/TOKEN.txt"
	echo "TESTCHATID" > "$BATS_TEST_TMPDIR/CHATID.txt"
    run bash "$BATS_TEST_DIRNAME/../service-healthcheck/service-healthcheck.sh"

    [ "$status" -eq 0 ]
    [[ "$output" == *"WEB SERVICES"* ]]
}

@test "Service script trying to restart test service" {
	cd "$BATS_TEST_TMPDIR"
	
	touch "$BATS_TEST_TMPDIR/TOKEN.txt"
	touch "$BATS_TEST_TMPDIR/CHATID.txt"
	echo "TESTTOKEN" > "$BATS_TEST_TMPDIR/TOKEN.txt"
	echo "TESTCHATID" > "$BATS_TEST_TMPDIR/CHATID.txt"
	
	mkdir -p "$BATS_TEST_TMPDIR/services"
	echo "TESTSERVICE" > "$BATS_TEST_TMPDIR/services/web.txt"
    run bash "$BATS_TEST_DIRNAME/../service-healthcheck/service-healthcheck.sh"

    [ "$status" -eq 0 ]
    [[ "$output" == *"Attempting to restore"* ]]
}

@test "Service script restarted test service" {
	cd "$BATS_TEST_TMPDIR"
	
	touch "$BATS_TEST_TMPDIR/TOKEN.txt"
	touch "$BATS_TEST_TMPDIR/CHATID.txt"
	echo "TESTTOKEN" > "$BATS_TEST_TMPDIR/TOKEN.txt"
	echo "TESTCHATID" > "$BATS_TEST_TMPDIR/CHATID.txt"
	mkdir -p "$BATS_TEST_TMPDIR/services"
	echo "TESTSERVICE" > "$BATS_TEST_TMPDIR/services/web.txt"
    run bash "$BATS_TEST_DIRNAME/../service-healthcheck/service-healthcheck.sh"
	
    [ "$status" -eq 0 ]
    [[ "$output" == *"successfully restored"* ]]
}

@test "Service script failed to restart test service" {
	cd "$BATS_TEST_TMPDIR"
	
	touch "$BATS_TEST_TMPDIR/TOKEN.txt"
	touch "$BATS_TEST_TMPDIR/CHATID.txt"
	echo "TESTTOKEN" > "$BATS_TEST_TMPDIR/TOKEN.txt"
	echo "TESTCHATID" > "$BATS_TEST_TMPDIR/CHATID.txt"
	mkdir -p "$BATS_TEST_TMPDIR/services"
	echo "TESTSERVICE" > "$BATS_TEST_TMPDIR/services/web.txt"
	export MOCK_SERVICE_RECOVERY=false
    run bash "$BATS_TEST_DIRNAME/../service-healthcheck/service-healthcheck.sh"
    [ "$status" -eq 1 ]
    [[ "$output" == *"isn't working"* ]]
}

@test "Service script sent telegram test notification by mock curl" {
	cd "$BATS_TEST_TMPDIR"
	
	touch "$BATS_TEST_TMPDIR/TOKEN.txt"
	touch "$BATS_TEST_TMPDIR/CHATID.txt"
	echo "TESTTOKEN" > "$BATS_TEST_TMPDIR/TOKEN.txt"
	echo "TESTCHATID" > "$BATS_TEST_TMPDIR/CHATID.txt"
	mkdir -p "$BATS_TEST_TMPDIR/services"
	echo "TESTSERVICE" > "$BATS_TEST_TMPDIR/services/web.txt"
	export MOCK_SERVICE_RECOVERY=false
    run bash "$BATS_TEST_DIRNAME/../service-healthcheck/service-healthcheck.sh"
    [ "$status" -eq 1 ]
    [[ "$output" == *"isn't working"* ]]
    [[ "$output" == *"MOCK CURL CALLED"* ]]
}
