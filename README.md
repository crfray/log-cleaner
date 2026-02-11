# Foreword

A simple Bash script to find and optionally delete `.log` files older than a specified number of days.  
This is a small practice project for learning Bash scripting, file management, and command-line arguments.

---

## Features

- Accepts a directory path and a number of days as arguments.
- Finds all `.log` files older than the specified number of days.
- Lists the files and asks for confirmation before deleting.
- Shows usage instructions if arguments are missing or invalid.

---

## Requirements

- Bash (tested on Bash 5+)
- Linux / macOS (or any system with Bash and `find`)
- Basic knowledge of terminal commands

---

## Usage

```bash
./clean_old_logs.sh /path/to/logs N
```
