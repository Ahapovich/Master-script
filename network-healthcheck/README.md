# Bash Toolkit

A collection of Bash scripts for Linux system administration, monitoring, and maintenance.

The project combines several independent Bash scripts into one **Master Script** with an interactive menu. Each module performs a specific system administration task, including service monitoring, log analysis, backup management, disk usage monitoring, and network diagnostics.

## Features

* 🔧 **Service Health Check**
  * Monitors selected Linux system services
  * Detects inactive or failed services
  * Attempts to restart failed services (up to two attempts)
  * Waits three seconds between restart attempts
  * Groups monitored services by category
  * Sends Telegram notifications when services cannot be restored

* 📋 **Log Check**
  * Searches log files for specified keywords or patterns
  * Supports keywords such as `ERR`, `FAIL`, and `CRITICAL`
  * Checks whether the specified log file exists and is readable
  * Uses `grep` for log analysis

* 💾 **Backup**
  * Creates compressed `.tar.gz` archives
  * Allows the user to specify the source directory
  * Allows the user to specify the backup destination
  * Supports configurable backup retention in days
  * Automatically deletes old archives matching `backup_*.tar.gz`

* 💿 **Disk Check**
  * Displays file or directory size
  * Displays filesystem usage information
  * Checks storage utilization against predefined thresholds
  * Shows a warning when usage exceeds 70%
  * Reports a critical state when usage exceeds 85%
  * Displays the ten largest entries on the affected filesystem

* 🌐 **Network Health Check**
  * Checks for an active network interface with an IPv4 address
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
│   └── README.md
├── service-healthcheck/
│   ├── services/
│   │   ├── web.txt
│   │   ├── docker.txt
│   │   ├── database.txt
│   │   ├── security.txt
│   │   └── network.txt
│   ├── service-healthcheck.sh
│   ├── CHATID.txt
│   └── TOKEN.txt
└── masterscript.sh
```

The `masterscript.sh` file provides the main interactive menu:

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
* `systemd` / `systemctl`
* GNU/Linux utilities:
  * `grep`
  * `df`
  * `du`
  * `tar`
  * `find`
  * `awk`
  * `sort`
  * `head`
  * `cut`
* Network utilities:
  * `ip` (iproute2)
  * `ping` (iputils)
  * `curl`
  * `getent`
* `sudo` for service restart operations

Some modules require elevated privileges to access system information or perform administrative operations.

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

## Configuration

### Service Health Check

The service checker uses five configuration files located in `service-healthcheck/services/`:

| File | Service category |
|---|---|
| `web.txt` | Web servers |
| `docker.txt` | Container platforms |
| `database.txt` | Database services |
| `security.txt` | Security services |
| `network.txt` | Network services |

Each file contains the systemd service names to monitor, one per line.

The Service Health Check also requires Telegram bot credentials:

```text
service-healthcheck/
├── CHATID.txt
└── TOKEN.txt
```

* `TOKEN.txt` — Telegram bot token
* `CHATID.txt` — Telegram chat ID

Both files must contain valid values before starting the service checker.

**Security note:** Never commit real Telegram credentials or other sensitive information to a public repository. Keep these files empty in the repository and provide your own local credentials.

## Usage

Start the toolkit with administrative privileges:

```bash
sudo ./masterscript.sh
```

Select a module from the interactive menu and follow the instructions displayed in the terminal.

### 1. Network Health Check

The network checker performs several tests to identify common connectivity problems.

It checks:

* Active IPv4 network interfaces
* Default gateway configuration and reachability
* Internet connectivity by pinging `1.1.1.1`
* DNS resolution using `google.com`
* HTTPS connectivity using `google.com`

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

The script returns exit code `0` when all checks pass and `1` when at least one check fails.

### 2. Service Health Check

The service checker monitors configured systemd services.

If a service is inactive, the script attempts to restart it up to two times, waiting three seconds between attempts.

If the service remains unavailable, it records the failure and sends a Telegram notification.

Example:

```text
------ WEB SERVICES ------

nginx is working
apache2 is down. Attempting to restore...
  Attempt 1 of 2...
  apache2 successfully restored!
```

Service categories and monitored services can be customized through the configuration files in `service-healthcheck/services/`.

### 3. Log Check

The log checker accepts two arguments:

1. A log file path
2. A keyword or pattern to search for

Example:

```text
Enter the details:

/var/log/syslog
ERR
```

The script verifies that the file exists and is readable before searching it with `grep`.

Supported examples:

```text
ERR
FAIL
CRITICAL
```

### 4. Backup

The backup module creates compressed archives of selected files or directories.

It requires three arguments:

* Source path
* Backup destination directory
* Retention period in days

Example:

```text
Source: /home/user/documents
Backup directory: /home/user/backups
Retention: 7
```

The resulting archive uses the following naming format:

```text
backup_YYYY-MM-DD_HH_MM_SS.tar.gz
```

After creating the backup, the script removes matching archives older than the configured retention period.

### 5. Disk Check

The disk checker accepts a file or directory path and displays its size along with filesystem usage information.

It uses predefined thresholds:

| Filesystem usage | Status |
|---|---|
| Up to 70% | Normal |
| Above 70% and up to 85% | Warning |
| Above 85% | Critical |

When filesystem usage exceeds 85%, the script displays the ten largest entries on the affected filesystem to help identify storage-consuming directories and files.

## Input Validation and Error Handling

The project includes basic input validation and error handling to prevent common errors.

Examples include:

* Checking the number of required arguments
* Verifying that files and directories exist
* Checking file readability and directory permissions
* Validating numeric retention values
* Handling missing configuration files
* Using exit codes to indicate success, warnings, or errors

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
* Validates syntax using `bash -n`
* Fails the workflow if a syntax error is detected

This helps catch Bash syntax errors before changes are integrated into the main branch.

## Technologies

* **Bash**
* Linux
* Git and GitHub
* GitHub Actions
* YAML
* GNU Core Utilities
* `systemd` / `systemctl`
* `grep`
* `tar`
* `df`
* `du`
* `iproute2`
* `curl`
* `ping`
* Telegram Bot API

## What I Practiced

This project was created as a practical Linux administration and Bash scripting exercise.

It helped practice:

* Bash variables
* Command-line arguments
* Conditional statements (`if`)
* `case` statements
* `for` and `while` loops
* Functions
* Exit codes
* Input validation
* File and directory operations
* Pipes and command substitution
* Process management
* `grep`, `awk`, and `find`
* `df` and `du`
* `tar`
* `systemctl`
* Network diagnostics
* HTTP requests with `curl`
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
* Improve error handling and reporting
* Add command-line arguments to the Master Script
* Improve configuration file handling
* Add CPU and RAM monitoring
* Add Docker health checks
* Add system resource monitoring
* Expand CI with ShellCheck and automated functional tests

## Status

🟢 **Active development**

The current version contains five system administration modules combined into one interactive Bash toolkit, along with automated Bash syntax validation using GitHub Actions.

The project will continue to evolve as I progress with Linux, networking, Docker, CI/CD, cloud infrastructure, and DevOps.

---

**Author:** [Ahapovich](https://github.com/Ahapovich)

**Repository:** [Master-script](https://github.com/Ahapovich/Master-script)
