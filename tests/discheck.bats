#!/usr/bin/env bats
setup() {
    export PATH="$BATS_TEST_DIRNAME/mocks:$PATH"
}
@test "discheck requires exactly one argument" {
    run bash "$BATS_TEST_DIRNAME/../diskscript/discheck.sh"

    [ "$status" -eq 3 ]
    [[ "$output" == *"ERROR: 1 argument are required"* ]]
}

@test "discheck rejects a nonexistent path" {
    run bash "$BATS_TEST_DIRNAME/../diskscript/discheck.sh" "$BATS_TEST_TMPDIR/nonexistent"

    [ "$status" -eq 3 ]
    [[ "$output" == *"isnt file or directory"* ]]
}

@test "discheck accepts an existing directory" {
    mkdir -p "$BATS_TEST_TMPDIR/test-directory"

    run bash "$BATS_TEST_DIRNAME/../diskscript/discheck.sh" "$BATS_TEST_TMPDIR/test-directory"

    [ "$status" -eq 0 ]
    [[ "$output" == *"Filesystem Usage"* ]]
}

@test "discheck rejects multiple arguments" {
	run bash "$BATS_TEST_DIRNAME/../diskscript/discheck.sh" "/tmp" "/var"

	[ "$status" -eq 3 ]
	[[ "$output" == *"ERROR: 1 argument are required"* ]]
}

@test "discheck accepts an existing file" {
	touch "$BATS_TEST_TMPDIR/testfile.txt"
	run bash "$BATS_TEST_DIRNAME/../diskscript/discheck.sh" "$BATS_TEST_TMPDIR/testfile.txt"

	[ "$status" -eq 0 ]
	[[ "$output" == *"Directory / File Size"* ]]
}
