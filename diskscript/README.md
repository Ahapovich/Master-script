# Disk Check Utility

A Bash utility for monitoring filesystem usage and checking the size of a specified file or directory.

This project was created as a practical Bash/Linux exercise for DevOps learning.

## Features

- Validates command-line arguments
- Checks whether the specified path exists
- Checks read permissions
- Displays the size of the specified file or directory
- Detects the filesystem where the target is located
- Displays filesystem information:
  - Filesystem
  - Mount point
  - Total space
  - Used space
  - Available space
  - Usage percentage
- Provides different statuses depending on disk usage
- Displays the 10 largest objects on the affected filesystem when usage is critical
- Returns different exit codes depending on the filesystem status

## Usage

Make the script executable:

    chmod +x discheck.sh

Run the script:

    ./discheck.sh <directory_or_file>

Example:

    ./discheck.sh /var

## Example Output

    ====Directory / File Size====

    Path: /var
    Size: 4.4G

    =============================

    ==== Filesystem Usage ====

    Filesystem: /dev/sda2
    Mount point: /
    Total: 50G
    Used: 15G
    Available: 34G
    Usage: 30%

    =========================

## Disk Usage Thresholds

The script uses three filesystem usage levels:

| Usage | Status | Exit Code |
|---|---|---:|
| 0–70% | OK | 0 |
| 71–85% | WARNING | 1 |
| >85% | CRITICAL | 2 |

When the filesystem reaches the CRITICAL level, the script displays the 10 largest objects on the affected filesystem.

## Error Handling

The script exits with an error when:

- The required argument is missing
- More than one argument is provided
- The specified path does not exist
- The specified path cannot be read

Example:

    ./discheck.sh /nonexistent

Output:

    ERROR: /nonexistent isnt file or directory

## Commands and Tools Used

The script uses standard Linux utilities:

- Bash
- df
- du
- awk
- sort
- head

### Bash Features

- Command-line arguments
- Conditional statements
- Functions
- Local variables
- Command substitution
- Here strings
- Pipelines
- Arithmetic comparisons
- Exit codes
- Error handling
- Variable expansion and quoting

## Project Structure

    .
    ├── discheck.sh
    └── README.md

## Purpose

The purpose of this project is to practice Bash scripting and Linux system administration concepts relevant to DevOps.

The project focuses on:

- Bash scripting
- Linux filesystem management
- Filesystem monitoring
- Working with df and du
- Parsing command output with awk
- Using Linux command pipelines
- Writing reusable Bash functions
- Implementing exit codes
- Basic error handling

## Future Improvements

Possible improvements for future versions:

- Configurable warning and critical thresholds
- JSON output for monitoring systems
- Logging results to a file
- Additional filesystem checks
- Improved handling of special filesystems
- Integration with monitoring systems
