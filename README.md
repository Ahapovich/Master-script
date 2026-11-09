# Bash Toolkit

A collection of Bash scripts for basic Linux system administration, monitoring, and maintenance.

The project combines several independent Bash scripts into one **Master Script** with an interactive menu. Each module performs a specific system administration task, including service monitoring, log analysis, backup management, disk usage monitoring, and network diagnostics.

## Features

* 🔧 **Service Health Check**
  * Checks the status of selected system services
  * Detects inactive or failed services
  * Attempts to restart failed services
  * Supports optional Telegram notifications
  * Allows configuration of monitored services

* 📋 **Log Check**
  * Searches log files for specified keywords
  * Supports keywords such as `ERR`, `FAIL`, and `CRITICAL`
  * Checks whether the specified log file exists and is readable
  * Helps identify potential issues in system logs

* 💾 **Backup**
  * Creates compressed `.tar.gz` backups
  * Allows the user to specify the source directory
  * Supports configurable backup retention
  * Removes old backup archives according to the selected retention period

* 💿 **Disk Check**
  * Displays disk usage information
  * Checks filesystem usage against predefined thresholds
  * Identifies filesystems with high disk utilization
  * Displays the largest directories and files for investigation

* 🌐 **Network Health Check**
  * Checks active network interfaces
  * Detects the default gateway
  * Tests gateway connectivity
  * Checks internet connectivity using ICMP
  * Verifies DNS resolution
  * Tests HTTPS connectivity

## Project Structure

The project is organized into separate directories for each system administration module.

```text
Master-script/
├── .github/
│   └── workflows/
│       └── bash-check.yml
├── backupS/
│   └── backupscriptf
├── diskscript/
│   └── discheck.sh
├── logscript/
│   └── scriptlog.sh
├── network-healthcheck/
│   ├── network-check.sh
│   ├── README.md
│   └── services/
├── service-healthcheck/
│   ├── service-healthcheck.sh
│   ├── README.md
│   └── services/
└── masterscript.sh
```

The `masterscript.sh` file provides an interactive menu:

```text
========================
      BASH TOOLKIT
========================

1. Network Health Check
2. Service Health Check
3. Log Check
4. Backup
5. Disk Check
0. Exit
```

## Requirements

* Linux
* Bash 4+
* `systemd` for service monitoring
* Standard GNU/Linux utilities:
  * `grep`
  * `df`
  * `du`
  * `tar`
  * `systemctl`
  * `find`
* Network utilities:
  * `ip` (iproute2)
  * `ping` (iputils)
  * `curl`
  * `getent`

Some operations may require elevated privileges depending on the services, log files, or directories being accessed.

## Installation

Clone the repository:

```bash
git clone https://github.com/Ahapovich/Master-script.git
cd Master-script
```

Make the scripts executable:

```bash
chmod +x masterscript.sh
chmod +x backupS/backupscriptf
chmod +x diskscript/discheck.sh
chmod +x logscript/scriptlog.sh
chmod +x network-healthcheck/network-check.sh
chmod +x service-healthcheck/service-healthcheck.sh
```

Run the toolkit:

```bash
sudo ./masterscript.sh
```

## Usage

After starting the Master Script, select one of the available modules from the interactive menu and follow the instructions displayed in the terminal.

### 1. Network Health Check

The network checker performs several tests to identify common connectivity problems.

It checks:

* Whether an active network interface with an IPv4 address exists
* Whether the default gateway is configured and reachable
* Whether an external IP address is reachable
* Whether DNS resolution works
* Whether an HTTPS connection can be established

Example output:

```text
Checking network interface...
[OK] Network interface is active

[OK] Default gateway: 192.168.1.1
[OK] Default gateway is reachable

Checking internet connectivity...
[OK] Internet connection is available

Checking DNS resolution...
[OK] DNS resolution is working

Checking HTTPS connectivity...
[OK] HTTPS connection is working

The network check was successful
```

### 2. Service Health Check

The service checker verifies the status of configured system services.

It detects inactive or failed services and attempts to restart them.

Example:

```text
Checking services...

docker: active
ssh: active
nginx: failed

Attempting to restart nginx...
```

The list of monitored services is configurable through files located in `service-healthcheck/services/`.

The module also supports optional Telegram notifications.

### 3. Log Check

The log checker accepts:

1. A log file
2. A keyword to search for

Example:

```text
Enter log file: /var/log/syslog
Enter keyword: ERR
```

Supported examples:

```text
ERR
FAIL
CRITICAL
```

The search is performed using `grep`.

### 4. Backup

The backup module creates compressed archives of selected directories.

The user can specify:

* Source directory
* Backup directory
* Retention period in days

Example output:

```text
Creating backup...

Backup completed successfully:
backup_2026-09-10.tar.gz
```

Backups are stored as compressed `.tar.gz` archives.

### 5. Disk Check

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

## Input Validation and Error Handling

The project includes basic input validation and error handling to prevent common errors.

Examples include:

* Checking the number of arguments
* Verifying that files exist
* Checking whether files are readable
* Checking whether directories exist
* Validating user input
* Handling missing parameters
* Using exit codes to indicate success or failure

The goal is to make the scripts safer and more predictable when used from the command line.

## CI — GitHub Actions

The project includes a GitHub Actions workflow for automatic Bash syntax validation.

Workflow location:

```text
.github/workflows/bash-check.yml
```

The workflow:

* Runs automatically on every push
* Uses an Ubuntu 24.04 runner
* Checks out the repository
* Finds Bash scripts by their shebang
* Validates script syntax using `bash -n`
* Fails the workflow if a syntax error is detected

This provides an automated way to catch syntax errors before integrating changes into the main branch.

## Technologies

* **Bash**
* Linux
* Git and GitHub
* GitHub Actions
* GNU Core Utilities
* `systemd` / `systemctl`
* `grep`
* `tar`
* `df`
* `du`
* `iproute2`
* `curl`
* `ping`

## What I Practiced

This project was created as a practical Linux administration and Bash scripting exercise.

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
* Process substitution
* `grep`
* `df` and `du`
* `tar`
* `systemctl`
* Network diagnostics
* Git branching and remote repositories
* CI automation with GitHub Actions
* YAML workflow configuration

## Project Goal

The main goal of the project is to build practical Linux administration skills through small, reusable automation tasks.

The project is also part of my transition toward **Linux / DevOps / Infrastructure Engineering**, with a focus on learning how to automate common system administration tasks using Bash.

## Future Improvements

Possible future improvements include:

* Add logging to the toolkit itself
* Add colored terminal output
* Improve error handling
* Add command-line arguments in addition to the interactive menu
* Improve configuration file support
* Expand network diagnostics
* Add CPU and RAM monitoring
* Add Docker health checks
* Add system resource monitoring
* Expand CI checks with ShellCheck and automated tests

## Status

🟢 **Active development**

The current version contains five system administration modules combined into one interactive Bash toolkit, along with an automated Bash syntax check using GitHub Actions.

The project will continue to evolve as I progress with Linux, networking, Docker, CI/CD, cloud infrastructure, and DevOps.

---

**Author:** [Ahapovich](https://github.com/Ahapovich)

**Repository:** [Master-script](https://github.com/Ahapovich/Master-script)
