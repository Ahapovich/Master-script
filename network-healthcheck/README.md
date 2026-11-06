# Linux Service Health Check

A simple Bash-based Linux service health check and self-healing script.

The script monitors user-defined system services, organizes them into configurable categories, attempts to restart failed services, and optionally sends an alert to Telegram when a service cannot be restored.

This project was created as a Bash/Linux/DevOps learning project and demonstrates working with loops, arrays, conditional statements, files, `systemctl`, `curl`, and the Telegram Bot API.

## Features

- Checks multiple Linux services using `systemctl`
- Organizes services into configurable categories
- Reads services from separate `.txt` configuration files
- Ignores empty lines and comments
- Counts failed services
- Groups failed services by category
- Automatically attempts to restart failed services
- Configurable number of restart attempts
- Verifies service status after each restart attempt
- Sends Telegram alerts when a service cannot be restored
- Keeps Telegram credentials outside the main script
- Allows service lists to be customized without modifying the Bash script
- Uses separate configuration files for different service categories

## Project Structure

```text
.
├── for.sh
├── README.md
├── .gitignore
└── services/
    ├── web.txt
    ├── docker.txt
    ├── database.txt
    ├── security.txt
    └── network.txt
```

> `TOKEN.txt` and `CHATID.txt` are created locally and are intentionally excluded from Git.

## Service Configuration

Each file inside the `services/` directory contains the names of systemd services that should be monitored.

### Example

`services/web.txt`

```text
nginx
apache2
httpd
```

`services/docker.txt`

```text
docker
containerd
```

`services/database.txt`

```text
mysql
mariadb
postgresql
redis
```

You can add, remove, or replace services according to your Linux system.

Comments are supported:

```text
# Web servers
nginx
apache2
```

Empty lines are ignored automatically.

## Service Groups

The monitored groups are defined in the script:

```bash
GROUP=(web docker database security network)
```

The script automatically looks for the corresponding files:

```text
services/web.txt
services/docker.txt
services/database.txt
services/security.txt
services/network.txt
```

To add another category, create a new `.txt` file and add its name to the `GROUP` array.

For example:

```bash
GROUP=(web docker database security network monitoring)
```

Then create:

```text
services/monitoring.txt
```

and add the services you want to monitor.

## Requirements

The script requires:

- Linux
- Bash
- systemd / `systemctl`
- `curl`
- Standard Linux utilities

The monitored services must be managed by systemd.

Some distributions use different service names.

For example:

```text
Ubuntu/Debian: ssh
RHEL/CentOS/Fedora: sshd
```

Make sure the service names in your configuration files match the names used by your system.

## Installation

Clone the repository:

```bash
git clone <repository-url>
cd <repository-directory>
```

Make the script executable:

```bash
chmod +x for.sh
```

Create the Telegram configuration files if you want to use Telegram notifications:

```bash
touch TOKEN.txt
touch CHATID.txt
```

Add your Telegram Bot Token to `TOKEN.txt`:

```text
123456789:ABCdefGhIJKlmNoPQRsTUVwxyZ123456789
```

Add your Telegram Chat ID to `CHATID.txt`:

```text
987654321
```

Configure the service lists inside the `services/` directory.

## Telegram Notifications

Telegram notifications are optional.

If a monitored service is down, the script attempts to restart it. If the service remains unavailable after all restart attempts, it is added to the alert report.

### 1. Create a Telegram Bot

Open Telegram and search for:

```text
@BotFather
```

Use:

```text
/newbot
```

Follow the instructions and save the Bot Token provided by BotFather.

### 2. Configure the Bot Token

Create:

```text
TOKEN.txt
```

Put your bot token inside the file.

### 3. Configure the Chat ID

Create:

```text
CHATID.txt
```

Put your Telegram Chat ID inside the file.

For a private conversation, start the bot first by sending it a message.

## Security

**Never commit your Telegram Bot Token or Chat ID to Git.**

Add the following files to `.gitignore`:

```text
TOKEN.txt
CHATID.txt
```

The files contain sensitive credentials and should remain only on the local system.

If you are sharing the project, users should create their own `TOKEN.txt` and `CHATID.txt` files locally.

## Running the Script

Run the script with:

```bash
sudo ./for.sh
```

or:

```bash
sudo bash for.sh
```

`sudo` is required because the script may attempt to restart system services.

The script will process every service listed in the configured service files.

## Example Output

```text
------ WEB SERVICES ------

nginx is working
apache2 is down. Attempting to restore...
  Attempt 1 of 2...
  apache2 successfully restored!

------ DOCKER SERVICES ------

docker is working
containerd is working

------ DATABASE SERVICES ------

postgresql is working
redis is down. Attempting to restore...
  Attempt 1 of 2...
  Attempt 2 of 2...
```

If a service cannot be restored, it is added to the alert report.

Example Telegram notification:

```text
ALERT! These services are not working:

WEB:
  - apache2

DATABASE:
  - redis
```

## Self-Healing

The script includes a basic self-healing mechanism.

When a monitored service is detected as inactive, the script attempts to restart it automatically.

The number of restart attempts is controlled by:

```bash
MAX_ATTEMPTS=2
```

After every restart attempt, the script waits and checks the service status again.

If the service becomes active, it is considered successfully restored.

If all attempts fail, the service is added to the Telegram alert.

### Recovery Flow

```text
Service check
      ↓
Service is down
      ↓
Attempt restart
      ↓
Wait 3 seconds
      ↓
Check service again
      ↓
 ┌───────────────┐
 │               │
 OK              FAIL
 ↓               ↓
Continue       Retry
                  ↓
             MAX_ATTEMPTS
                  ↓
               Alert
```

## How It Works

The script processes the configured service groups:

```text
GROUP
  ↓
services/<group>.txt
  ↓
Read service name
  ↓
systemctl is-active
  ↓
Working / Not working
  ↓
Attempt restart if necessary
  ↓
Verify service status
  ↓
Collect failed services
  ↓
Send Telegram alert if recovery fails
```

The script uses:

- a `for` loop to process service categories
- a `while` loop to read individual service files
- arrays to store groups and failed services
- `if` statements to check service status
- `systemctl` to manage services
- `curl` to communicate with the Telegram Bot API

## Bash Concepts Demonstrated

This project demonstrates:

- Variables
- Arrays
- `for` loops
- `while` loops
- `if` statements
- Regular expressions with `=~`
- `continue`
- Arithmetic operations
- File existence checks
- Reading files with `read`
- Input redirection
- Command substitution
- Array expansion
- String manipulation
- `systemctl`
- `curl`
- Telegram Bot API
- Basic configuration management
- `.gitignore`
- Basic secret management
- Service recovery logic

## Future Improvements

Possible improvements for future versions:

- Add disk and RAM monitoring
- Add CPU usage monitoring
- Add service recovery notifications
- Add logging
- Add command-line arguments
- Add configurable alert thresholds
- Improve error handling
- Add support for different notification methods
- Add more detailed service statistics
- Improve configuration validation
- Add a dry-run mode
- Add more robust handling of `sudo` permissions

## Disclaimer

This is a learning project created to practice Bash scripting and basic Linux/DevOps concepts.

It is **not intended to replace a production monitoring or service management system**.

Use the self-healing functionality with caution, especially on production systems.
