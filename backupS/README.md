# Bash Backup Utility

A simple Bash script for creating compressed backups of files or directories with automatic cleanup of old backup archives.

This project was created as a Bash/Linux practice project with a focus on file management, error handling, command-line arguments, functions, archiving, and backup retention.

## Features

* Creates `.tar.gz` backups of files or directories
* Accepts source and backup directory as command-line arguments
* Automatically creates the backup directory if it does not exist
* Validates source existence and read permissions
* Validates the retention period
* Generates timestamped backup filenames
* Displays the size of the created archive
* Automatically removes old backup archives
* Uses exit codes to indicate errors

## Requirements

* Linux or another Unix-like operating system
* Bash
* `tar`
* `find`
* `du`
* `date`

## Usage

```bash
./backup.sh <source> <backup_directory> <retention_days>
```

### Example

```bash
./backup.sh /etc ./backup 7
```

This command:

1. Creates a compressed backup of `/etc`
2. Stores the archive in `./backup`
3. Keeps backup archives according to the specified retention period
4. Removes backup archives older than the specified number of days

Example output:

```text
Backup ready
Backup name: backup_2026-08-26_22_30_15.tar.gz
Backup dir is located: ./backup

Archive size: 12M
```

## Backup Filename

Each backup receives a timestamp-based filename:

```text
backup_YYYY-MM-DD_HH_MM_SS.tar.gz
```

Example:

```text
backup_2026-08-26_22_30_15.tar.gz
```

This prevents backups from overwriting each other.

## Retention

The third argument specifies the retention period in days.

For example:

```bash
./backup.sh /etc ./backup 7
```

The script will remove matching backup archives older than the specified retention period.

Only files matching the following pattern are affected:

```text
backup_*.tar.gz
```

## Error Handling

The script validates:

* The number of arguments
* Source existence
* Source read permissions
* Retention period format
* Backup creation success
* Old backup deletion

The script returns a non-zero exit code when an error occurs.

Example:

```bash
./backup.sh /nonexistent ./backup 7
```

Output:

```text
ERROR: Source '/nonexistent' not found
```

## Project Structure

```text
.
├── backup.sh
└── README.md
```

## What I Practiced

This project helped practice:

* Bash scripting
* Positional parameters
* Argument validation
* Conditional expressions
* Regular expressions
* Functions
* Exit codes
* File and directory tests
* File permissions
* `tar` archives
* `find`
* `du`
* `date`
* Command substitution
* Error handling
* Backup retention
* Basic Linux automation

## Possible Future Improvements

Potential improvements for future versions:

* Add `--help` and command-line options
* Add logging
* Add configurable backup filename prefixes
* Add backup verification
* Add checksum generation
* Add exclusion rules
* Add automated testing
* Add cron/systemd integration
* Prevent the backup directory from being included when backing up a parent directory

## License

This project is intended for educational and portfolio purposes.
