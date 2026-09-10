# Bash Toolkit

A simple interactive Bash toolkit for basic Linux system administration and maintenance.

The project combines several Bash scripts into one **Master Script** with an interactive menu. Each module performs a specific system administration task such as checking services, analyzing logs, creating backups, and monitoring disk usage.

## Features

* 🔧 **Service Health Check**

  * Checks the status of selected system services
  * Detects inactive or failed services
  * Attempts to restart failed services

* 📋 **Log Check**

  * Searches log files for specified keywords
  * Supports keywords such as `ERR`, `FAIL`, and `CRITICAL`
  * Checks whether the specified log file exists and is readable

* 💾 **Backup**

  * Creates compressed `.tar.gz` backups
  * Allows the user to specify the source directory
  * Supports configurable backup retention

* 💿 **Disk Check**

  * Displays disk usage information
  * Checks filesystem usage against predefined thresholds
  * Identifies filesystems with high disk utilization
  * Displays the largest directories/files for investigation

## Project Structure

The project is intentionally implemented as a **single Bash script**:

```text
bash-toolkit/
└── master.sh
```

The script provides an interactive menu:

```text
========================
     BASH TOOLKIT
========================

1. Service Health Check
2. Log Check
3. Backup
4. Disk Check
5. Exit
```

## Requirements

* Linux
* Bash 4+
* Standard GNU/Linux utilities:

  * `grep`
  * `df`
  * `du`
  * `tar`
  * `systemctl`
  * `find`

Some operations may require `sudo` privileges depending on the services, log files, or directories being accessed.

## Installation

Clone the repository:

```bash
git clone <repository-url>
cd bash-toolkit
```

Make the script executable:

```bash
chmod +x master.sh
```

Run the toolkit:

```bash
./master.sh
```

If administrative privileges are required:

```bash
sudo ./master.sh
```

## Usage

After starting the script, select one of the available modules from the interactive menu.

### 1. Service Health Check

The service checker verifies the status of configured services.

Example:

```text
Checking services...

docker: active
ssh: active
nginx: failed

Attempting to restart nginx...
```

This can be useful for quickly checking whether important services are running without manually checking each one with `systemctl`.

### 2. Log Check

The log checker accepts:

1. A log file
2. A keyword to search for

Example:

```text
Enter log file: /var/log/syslog
Enter keyword: ERR
```

The script validates the input before searching the log.

Supported examples:

```text
ERR
FAIL
CRITICAL
```

The search is performed using `grep`.

### 3. Backup

The backup module creates compressed archives of selected directories.

The user can specify:

* Source directory
* Backup directory
* Retention period

Example output:

```text
Creating backup...

Backup completed successfully:
backup_2026-09-10.tar.gz
```

Backups are stored as compressed `tar.gz` archives.

### 4. Disk Check

The disk checker provides an overview of filesystem usage.

It uses `df` to check disk utilization and predefined thresholds to identify potentially problematic filesystems.

Example:

```text
Disk usage:

/      62%
/home  74%
/data  89%  WARNING
```

The script can also identify directories consuming significant amounts of disk space, helping with basic troubleshooting when a filesystem starts running out of space.

## Input Validation

The project includes basic input validation to prevent common errors.

Examples include:

* Checking the number of arguments
* Verifying that files exist
* Checking whether files are readable
* Checking whether directories exist
* Validating user input
* Handling missing parameters

The goal is to make the scripts safer and more predictable when used from the command line.

## Technologies

* **Bash**
* Linux
* GNU Core Utilities
* `systemd` / `systemctl`
* `grep`
* `tar`
* `df`
* `du`

## What I Practiced

This project was created as a practical Bash/Linux administration exercise.

It helped practice:

* Bash variables
* Command-line arguments
* `if` statements
* `case` statements
* `for` and `while` loops
* Functions
* Exit codes
* Input validation
* File and directory operations
* Pipes and command substitution
* `grep`
* `df` and `du`
* `tar`
* `systemctl`
* Basic error handling

## Project Goal

The main goal of the project is to build practical Linux administration skills through small, reusable automation tasks.

The project is also part of my transition toward **Linux / DevOps / Infrastructure engineering**, with a focus on learning how to automate common system administration tasks using Bash.

## Future Improvements

Possible future improvements include:

* Add logging to the toolkit itself
* Add colored terminal output
* Improve error handling
* Add command-line arguments in addition to the interactive menu
* Add configuration file support
* Allow users to configure which services are monitored
* Add more backup options
* Add CPU and RAM monitoring
* Add network diagnostics
* Add Docker health checks
* Add system resource monitoring

## Status

🟢 **Completed — initial version**

The current version contains four basic system administration modules combined into a single interactive Bash script.

The project will be expanded as I progress with Linux, networking, Docker, CI/CD, cloud infrastructure, and DevOps.
