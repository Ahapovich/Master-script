# Network Health Check

A Bash script for checking basic network connectivity and identifying common network configuration problems on Linux systems.

The script performs several diagnostic checks, starting with the local network interface and default gateway, followed by internet connectivity, DNS resolution, and HTTPS connectivity.

## Features

* 🌐 **Network Interface Check**
  * Checks for an active network interface with a global IPv4 address.
  * Detects whether the system has an IPv4 network configuration.

* 🚪 **Default Gateway Check**
  * Detects the configured default gateway using the routing table.
  * Checks whether the gateway responds to ICMP requests.

* 🌍 **Internet Connectivity Check**
  * Tests external connectivity by sending ICMP requests to `1.1.1.1`.
  * Helps identify basic internet connectivity problems.

* 🔎 **DNS Resolution Check**
  * Verifies DNS resolution using `getent`.
  * Uses `google.com` as the test hostname.

* 🔒 **HTTPS Connectivity Check**
  * Tests an HTTPS connection to `google.com`.
  * Uses `curl` with a five-second connection timeout.

* 📊 **Diagnostic Summary**
  * Displays individual test results.
  * Counts failed checks.
  * Returns an exit code depending on the overall result.

## Requirements

* Linux
* Bash
* `ip` (iproute2)
* `grep`
* `awk`
* `ping` (iputils)
* `getent`
* `curl`

Most of these utilities are available by default on common Linux distributions.

On Ubuntu, missing packages can be installed with:

```bash
sudo apt update
sudo apt install iproute2 iputils-ping curl
```

## Installation

Clone the repository:

```bash
git clone https://github.com/Ahapovich/Master-script.git
cd Master-script
```

Make the script executable:

```bash
chmod +x network-healthcheck/network-check.sh
```

## Usage

Run the script directly:

```bash
./network-healthcheck/network-check.sh
```

Alternatively, launch the main toolkit:

```bash
sudo ./masterscript.sh
```

Then select:

```text
1. Network Health Check
```

The network checker does not require Telegram configuration or root privileges for its standard checks.

## Diagnostic Checks

The script performs five main checks.

### 1. Network Interface

Checks whether the system has at least one network interface with a global IPv4 address.

Example:

```text
[OK] Network interface is active
```

If no global IPv4 address is found:

```text
[FAIL] No active network interface with IPv4 address
```

### 2. Default Gateway

Retrieves the default gateway from the system routing table and tests its reachability using `ping`.

Example:

```text
[OK] Default gateway: 192.168.1.1
[OK] Default gateway is reachable
```

### 3. Internet Connectivity

Sends two ICMP requests to the public IP address `1.1.1.1`.

Example:

```text
[OK] Internet connection is available
```

This check tests IP connectivity without relying on DNS resolution.

### 4. DNS Resolution

Uses `getent ahostsv4` to check whether the hostname `google.com` can be resolved to an IPv4 address.

Example:

```text
[OK] DNS resolution is working
```

### 5. HTTPS Connectivity

Uses `curl` to establish an HTTPS connection to `google.com`.

The connection attempt has a five-second timeout.

Example:

```text
[OK] HTTPS connection is working
```

## Example Output

Successful diagnostic run:

```text
========================
   NETWORK HEALTH CHECK
========================

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

If one or more checks fail, the script displays the corresponding `[FAIL]` messages and finishes with:

```text
The network check failed
```

## Exit Codes

| Exit code | Meaning |
|---|---|
| `0` | All network checks passed |
| `1` | One or more network checks failed |

The script counts failed checks internally and returns `1` if at least one diagnostic test fails.

## Technologies

* Bash
* Linux networking
* IP routing
* ICMP / `ping`
* DNS resolution
* HTTPS
* `iproute2`
* `curl`
* `getent`
* `grep`
* `awk`

## What I Practiced

This module was created to practice basic network diagnostics and Linux command-line tools.

It helped practice:

* Reading the Linux routing table
* Identifying network interfaces
* Working with IPv4 addresses
* Checking default gateway configuration
* Testing connectivity with `ping`
* Understanding the difference between IP connectivity and DNS resolution
* Testing HTTPS connectivity with `curl`
* Using `getent` for hostname resolution
* Conditional statements and arithmetic operations in Bash
* Functions and exit codes
* Combining Linux utilities through pipes

## Project Goal

The goal of this module is to automate basic network diagnostics using Bash and Linux networking utilities.

It is designed to identify common connectivity problems and provide a quick overview of the system's network status.

## Future Improvements

Possible improvements include:

* Add configurable test IP addresses and hostnames
* Add IPv6 connectivity checks
* Add network interface details
* Improve diagnostic messages to identify possible causes of failure
* Add configurable timeouts and retry counts
* Add optional logging
* Integrate additional network tests

## Status

🟢 **Active development**

This module is part of the [Bash Toolkit](https://github.com/Ahapovich/Master-script), a collection of Bash scripts for Linux system administration and monitoring.

---

**Author:** [Ahapovich](https://github.com/Ahapovich)

**Repository:** [Master-script](https://github.com/Ahapovich/Master-script)
