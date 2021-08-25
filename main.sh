#!/usr/bin/env bash
# Description - this file does <...>
#[] Usage: ./main.sh "we stand on the shoulders of giants"
# Change permissions
# chmod +x main.sh

#TODO: Set preferred flags to handle errors.
# set -o xtrace   # to trace what gets executed. Useful for debugging.
set -o errexit  # to make your script exit when a command fails.
set -o nounset  # to exit when your script tries to use undeclared variables.
set -o pipefail # to catch mysqldump fails in e.g. mysqldump |gzip. The exit status of the last command that threw a non-zero exit code is returned.

# Set magic variables for current file & dir
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename "${__file}.sh")"
__root="$(cd "$(dirname "${__dir}")" && pwd)" # <-- change this as it depends on your app
echo "__dir: ${__dir}"
echo "__file: ${__file}"
echo "__base: ${__base}"
echo "__root: ${__root}"

# Exit codes
readonly EX_SUCCESS=0
# 65-125 for specific script defined errors
readonly EX_GENERAL_SCRIPT_ERROR=65
readonly EX_SOURCE_SH_ERROR=66

source "main_config.sh" # API_FULL_URL = http://127.0.0.1:5000/user
source_return_val=$?

if [[ $source_return_val  -ne 0 ]]; then
    echo "Failed to source script."
    exit $EX_SOURCE_SH_ERROR
else
    echo "Add/modify config in main_config.sh"
    echo "API_FULL_URL sourced: $API_FULL_URL"
fi

CURRENT_DATE=$(date +"%Y%m%d")

# Create one log file per day and write all log messages to LOG_FILE using 'logger "<message"'
LOG_FOLDER="./logs"
LOG_FILE="${LOG_FOLDER}/main_${CURRENT_DATE}.log"
BAD_FOLDER="./bad"
BAD_FILE="${BAD_FOLDER}/main_${CURRENT_DATE}.bad"
SUCCESSFUL_FOLDER="./successful"
SUCCESSFUL_FILE="${SUCCESSFUL_FOLDER}/main_${CURRENT_DATE}.successful"

main() {
    readonly INPUT=$1
    echo "$INPUT"

    # Make directories if they do not exist
    mkdir -p "$LOG_FOLDER"
    # TODO: uncomment if needed
    # mkdir -p "$BAD_FOLDER"
    # mkdir -p "$SUCCESSFUL_FOLDER"
    
    # Call Functions
    transform_data
    backup_files
    echo "Logs written to './logs/...'"

    exit $EX_SUCCESS
}

logger() {
    
    TYPE="$1"
    MESSAGE="$2"
    CURRENT_TIME=$(date +"%Y%m%d %H:%M:%S")

    echo "$CURRENT_TIME - $TYPE - $MESSAGE" >> "$LOG_FILE"
}


transform_data() {
    logger "INFO" "transform_data run"
}
backup_files() {
    logger "INFO" "backup_files run"
}

# Pass args to main - https://www.gnu.org/software/bash/manual/html_node/Special-Parameters.html
main "$@"
