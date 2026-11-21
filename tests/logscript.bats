#!/usr/bin/env bats

@test "Logcheck script required 2 arguments" {
    run bash "$BATS_TEST_DIRNAME/../logscript/scriptlog.sh"

    [ "$status" -eq 3 ]
    [[ "$output" == *"ERROR: 2 arguments are required"* ]]
}

@test "Logcheck script rejects a nonexistent file" {
    run bash "$BATS_TEST_DIRNAME/../logscript/scriptlog.sh" "$BATS_TEST_TMPDIR/nonex.txt" "TEST"
    [ "$status" -eq 3 ]
    [[ "$output" == *"ERROR, file not found"* ]]
}

@test "logscript finds an existing search term" {
	touch "$BATS_TEST_TMPDIR/nonex.txt"
	echo "TEST" >> "$BATS_TEST_TMPDIR/nonex.txt"
    run bash "$BATS_TEST_DIRNAME/../logscript/scriptlog.sh" "$BATS_TEST_TMPDIR/nonex.txt" "TEST"

    [ "$status" -eq 0 ]
    [[ "$output" == *"TEST"* ]]
}

@test "logscript returns no matches when term is absent" {
	touch "$BATS_TEST_TMPDIR/nonex.txt"
	echo "TEST" >> "$BATS_TEST_TMPDIR/nonex.txt"
    run bash "$BATS_TEST_DIRNAME/../logscript/scriptlog.sh" "$BATS_TEST_TMPDIR/nonex.txt" "HELLO"
    
    [ "$status" -eq 1 ]
    [ -z "$output" ]
}

@test "logscript rejects an empty search term" { 
	touch "$BATS_TEST_TMPDIR/nonex.txt"
    run bash "$BATS_TEST_DIRNAME/../logscript/scriptlog.sh" "$BATS_TEST_TMPDIR/nonex.txt" ""

    [ "$status" -eq 3 ]
    [[ "$output" == *"cannot be empty"* ]]
}


