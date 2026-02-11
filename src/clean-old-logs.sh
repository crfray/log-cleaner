#!/usr/bin/env bash

set -euo pipefail
usage()
{
    echo "Usage: $0 /path/to/logs N"
    echo "(e.g: /var/log 7)"
}

if [[ $# != 2 ]]; then
    usage
    exit 1
fi

DIR="$1"
DAYS="$2"

if [[ ! -d "$DIR" ]]; then # I used -d to check if the DIR variable is a directory
    echo "Error: $DIR is not a directory"
    exit 1
fi

if ! [[ "$DAYS" =~ ^[1-9][0-9]*$ ]]; then # here [ ... ] is used for the first character
                                          # ensures that the first character is not 0
                                          # the second [ ... ] can be 0
    echo "Error: N must be a positive integer"
    exit 1
fi

mapfile -d '' LOG_FILES < <(find "$DIR" -type f -name "*.log" -mtime +"$DAYS" -print0)
                                          # -type f means only files, flag for find
                                          # -name search only for files ending with .log
                                          # -mtime filters files by modification time

if (( ${#LOG_FILES[@]} == 0 )); then
    echo "No .log files older than $DAYS days found in $DIR"
    exit 0
fi

echo "Found the following .log files older than $DAYS days:"
for file in "${LOG_FILES[@]}"; do
    echo "$file"
done

read -r -p "Delete these files? (y/n) " ANSWER 
ANSWER="${ANSWER,,}"

if [[ "$ANSWER" == "y" ]]; then
    rm -f -- "${LOG_FILES[@]}"
    echo "Files deleted."
    exit 0
elif [[ "$ANSWER" == "n" ]]; then
    echo "Operation cancelled!"
    exit 0
else
    echo "Invalid input, please enter Y/n"
    exit 1
fi
