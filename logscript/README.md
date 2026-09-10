# Log Check — Bash Log Analyzer

A simple Bash script for analyzing log files and searching for specific keywords.

The script accepts a log file and a search keyword as command-line arguments, checks the input, and uses `grep` to find and display matching log entries.

This project was created as a practical Bash/Linux exercise focused on file handling, command-line arguments, input validation, exit codes, and text searching.

## Features

* Accepts a log file as a command-line argument
* Accepts a search keyword as a command-line argument
* Checks whether the specified log file exists
* Checks whether the log file is readable
* Validates that the search keyword is not empty
* Searches the log file using `grep`
* Displays every matching log entry
* Supports partial keyword searches

## Requirements

* Linux or another Unix-like operating system
* Bash
* `grep`
* A readable log file

## Usage

Make the script executable:

```bash
chmod +x ./scriptlog.sh
```

Run the script with a log file and a keyword:

```bash
./scriptlog.sh <logfile> <keyword>
```

### Example

```bash
./scriptlog.sh example.log ERROR
```

Example output:

```text
2026-09-03T18:43:10.512Z [ERROR] [db] Query timeout after 5000ms: SELECT * FROM heavy_logs;
2026-09-03T18:43:16.005Z [ERROR] [db] Connection refused by database host 127.0.0.1:5432
```

The script can also search for partial keywords:

```bash
./scriptlog.sh example.log ERR
```

This matches entries containing `ERR`, including `ERROR`.

Another example:

```bash
./scriptlog.sh example.log CR
```

This matches entries containing `CR`, including `CRITICAL`.

## Project Structure

```text
logcheck/
├── scriptlog.sh
├── example.log
├── README.md
└── .gitignore
```

`scriptlog.sh` — main Bash script.

`example.log` — sample log file used for testing.

`README.md` — project documentation.

`.gitignore` — files that should not be uploaded to the repository.

## How It Works

The script expects exactly two arguments:

```text
$1 → log file
$2 → search keyword
```

For example:

```bash
./scriptlog.sh example.log ERROR
```

The arguments are stored in variables:

```bash
LOGFILE="$1"
LOGKEY="$2"
```

The script then performs several input checks.

First, it verifies that exactly two arguments were provided:

```bash
if [ "$#" -ne 2 ]; then
    ...
    exit 2
fi
```

It checks whether the specified file exists:

```bash
if [[ ! -f "$LOGFILE" ]]; then
    ...
    exit 1
fi
```

It also checks whether the file can be read:

```bash
if [[ ! -r "$LOGFILE" ]]; then
    ...
    exit 1
fi
```

Finally, it verifies that the search keyword is not empty:

```bash
if [[ -z "$LOGKEY" ]]; then
    ...
    exit 2
fi
```

After the input validation is complete, `grep` searches the log file for the requested keyword:

```bash
grep "$LOGKEY" "$LOGFILE"
```

## Bash Concepts Practiced

This project was built to practice several Bash concepts:

* Positional parameters: `$1`, `$2`
* Argument count: `$#`
* `if` statements
* File tests with `[[ -f ]]`
* Readability tests with `[[ -r ]]`
* Empty string checks with `[[ -z ]]`
* Exit codes with `exit`
* Variables
* Command-line arguments
* Text searching with `grep`
* Basic input validation

## Error Handling

The script validates the user's input before searching the log file.

If the wrong number of arguments is provided, the script exits with status code `2`:

```bash
if [ "$#" -ne 2 ]; then
    echo "ERROR: 2 arguments are required"
    exit 2
fi
```

If the log file does not exist, the script exits with status code `1`:

```bash
if [[ ! -f "$LOGFILE" ]]; then
    echo "ERROR, file not found: $LOGFILE"
    exit 1
fi
```

If the file exists but cannot be read, the script also exits with status code `1`.

An empty search keyword is treated as invalid input and results in exit status `2`.

## Future Improvements

Possible improvements for future versions:

* Count the number of matching log entries
* Add different log severity levels such as `ERROR`, `WARNING`, and `CRITICAL`
* Add a summary of detected problems
* Add colored terminal output
* Add options using `getopts`
* Allow case-insensitive searches
* Add support for multiple keywords
* Export results to a separate report file
* Add more advanced log parsing

## Learning Goal

The main goal of this project is to build practical Bash skills by creating a small but useful Linux command-line tool.

The project will be extended as new Bash concepts are learned.
