# Bash Toolkit

A collection of Bash scripts for Linux system administration, health monitoring, and routine maintenance.

The project combines several system administration utilities into one interactive menu, providing a simple way to monitor network connectivity, check system services, inspect logs, manage backups, and monitor disk usage.

## Features

### 1. Network Health Check
Checks the basic network connectivity and availability of essential network services.

- Network interface availability
- Default gateway detection and connectivity
- Internet connectivity
- DNS resolution
- HTTPS connectivity

### 2. Service Health Check
Monitors selected Linux services and helps identify service availability issues.

- Checks configured system services
- Supports service recovery actions
- Optional Telegram notifications

Service configuration files are located in `service-healthcheck/services/`.

### 3. Log Check
Searches log files for specified keywords or error patterns.

- Supports custom log file paths
- Allows searching for specific problem types
- Helps identify errors and critical events

### 4. Backup
Provides a utility for creating backups and managing old backup archives.

- Accepts a source directory
- Accepts a backup destination
- Supports automatic cleanup of old archives based on retention days

### 5. Disk Health Check
Monitors disk usage and identifies storage capacity issues.

- Displays disk usage information
- Provides configurable warning thresholds
- Identifies directories consuming significant storage space

## Project Structure

```text
Bash-Toolkit/
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
│   ├── service-healthcheck.sh
│   └── README.md
└── masterscript.sh
```

## Requirements

- Linux operating system
- Bash
- `systemd` for service monitoring
- `iproute2` for network interface and routing information
- `iputils-ping` for connectivity checks
- `curl` for HTTPS connectivity checks
- `dnsutils` or an equivalent DNS utility where required

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
chmod +x network-healthcheck/network-check.sh
chmod +x service-healthcheck/service-healthcheck.sh
chmod +x logscript/scriptlog.sh
chmod +x diskscript/discheck.sh
chmod +x backupS/backupscriptf
```

## Usage

Start the main interactive menu:

```bash
sudo ./masterscript.sh
```

The toolkit provides the following menu:

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

Select the required operation and follow the instructions displayed in the terminal.

## Telegram Notifications

The Service Health Check module supports optional Telegram notifications.

To configure notifications, provide the required Telegram bot credentials and chat ID in the configuration files:

```text
service-healthcheck/
├── CHATID.txt
└── TOKEN.txt
```

**Security note:** Never commit real bot tokens, passwords, or other sensitive credentials to a public repository.

## CI — GitHub Actions

The project includes a GitHub Actions workflow that automatically checks Bash script syntax.

Workflow location:

```text
.github/workflows/bash-check.yml
```

The workflow:

1. Runs on Ubuntu 24.04.
2. Checks out the repository.
3. Finds Bash scripts using their shebang.
4. Runs `bash -n` against each detected script.
5. Fails the workflow if a syntax error is detected.

This helps identify Bash syntax errors before changes are integrated into the main branch.

## Project Goals

This project was created as a practical exercise in Linux system administration and Bash scripting.

It demonstrates practical experience with:

- Linux command-line utilities
- Bash scripting and automation
- Process and service management
- Network diagnostics
- Log inspection
- Backup management
- Git and GitHub
- Continuous Integration with GitHub Actions

---

**Author:** [Ahapovich](https://github.com/Ahapovich)

**Repository:** [Bash Toolkit](https://github.com/Ahapovich/Master-script)
