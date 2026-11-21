
#!/usr/bin/env bats

@test "backup script required 3 arguments" {
    run bash "$BATS_TEST_DIRNAME/../backupS/backupscriptf"

    [ "$status" -eq 3 ]
    [[ "$output" == *"ERROR: 3 arguments are required"* ]]
}

@test "backup script rejects a nonexistent source" {
	mkdir -p "$BATS_TEST_TMPDIR/backup" 
    run bash "$BATS_TEST_DIRNAME/../backupS/backupscriptf" "$BATS_TEST_TMPDIR/nonex.txt" "$BATS_TEST_TMPDIR/backup" "7"

    [ "$status" -eq 3 ]
    [[ "$output" == *"not found"* ]]
}

@test "backup script rejects a nonexistent directory" {
	touch "$BATS_TEST_TMPDIR/nonex.txt"
    run bash "$BATS_TEST_DIRNAME/../backupS/backupscriptf" "$BATS_TEST_TMPDIR/nonex.txt" "$BATS_TEST_TMPDIR/backup1" "7"

    [ "$status" -eq 3 ]
    [[ "$output" == *"does not exist"* ]]
}

@test "backup script requires number in retention days" {
	mkdir -p "$BATS_TEST_TMPDIR/backup" 
	touch "$BATS_TEST_TMPDIR/nonex.txt"
    run bash "$BATS_TEST_DIRNAME/../backupS/backupscriptf" "$BATS_TEST_TMPDIR/nonex.txt" "$BATS_TEST_TMPDIR/backup" "abc"

    [ "$status" -eq 3 ]
    [[ "$output" == *"Retention days must be a number"* ]]
}

@test "backup script successful create archive" {
	mkdir -p "$BATS_TEST_TMPDIR/backup" 
	touch "$BATS_TEST_TMPDIR/nonex.txt"
    run bash "$BATS_TEST_DIRNAME/../backupS/backupscriptf" "$BATS_TEST_TMPDIR/nonex.txt" "$BATS_TEST_TMPDIR/backup" "7"

    [ "$status" -eq 0 ]
    [ -n "$(find "$BATS_TEST_TMPDIR/backup" -name "backup_*.tar.gz" -print -quit)" ]
    [[ "$output" == *"Archive size"* ]]
}
