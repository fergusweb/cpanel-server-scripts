#!/usr/bin/env bash

# Usage: find_error_logs.sh <MIN_SIZE> [--delete]
# Example: find_error_logs.sh 10M
#          find_error_logs.sh 10M --delete

# Ensure at least one argument (MIN_SIZE) is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <MIN_SIZE> [--delete]"
  exit 1
fi

MIN_SIZE=$1
shift

# Check if user passed --delete
DELETE_MODE=false
if [ "$1" = "--delete" ]; then
  DELETE_MODE=true
fi

if [ "$DELETE_MODE" = true ]; then
  echo "Deleting files named 'error_log' with size greater than $MIN_SIZE:"
  find /home -type f -name "error_log" -size +"$MIN_SIZE" -exec echo "Deleting: {}" \; -exec rm {} \;
else
  echo "Listing files named 'error_log' with size greater than $MIN_SIZE:"
  find /home -type f -name "error_log" -size +"$MIN_SIZE" -exec du -h {} \;
fi
