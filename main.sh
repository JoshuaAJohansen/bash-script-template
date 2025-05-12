#!/usr/bin/env bash
# Description - this file does <...>
# Usage: ./main.sh "we stand on the shoulders of giants"
# Change permissions: chmod +x main.sh


#==================================================
# Strict Mode: safer scripting
#==================================================
# Trace commands (optional; useful for debugging)
# set -o xtrace

# Exit immediately if a command exits with a non-zero status.
set -o errexit

# Treat unset(undeclared) variables as an error and exit immediately.
set -o nounset

# Fail if any part of a pipeline fails
# Example: `mysqldump mydb | gzip > backup.gz`
# - Without pipefail: gzip might succeed even if mysqldump fails
# - With pipefail: the script fails correctly on mysqldump failure
set -o pipefail

#==================================================
# Environment Setup: magic variables
#==================================================

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename "${__file}.sh")"
__root="$(cd "$(dirname "${__dir}")" && pwd)"   # Adjust based on app structure

echo "__dir: ${__dir}"
echo "__file: ${__file}"
echo "__base: ${__base}"
echo "__root: ${__root}"


#==================================================
# Exit Codes
#==================================================

readonly EX_SUCCESS=0
# 65-125 reserved for script-specific errors
readonly EX_GENERAL_SCRIPT_ERROR=65
readonly EX_SOURCE_SH_ERROR=66



#==================================================
# Configuration
#==================================================

# Source configuration file
if ! source "${__dir}/main_config.sh"; then
    echo "Failed to source main_config.sh."
    exit $EX_SOURCE_SH_ERROR
else
    echo "Config loaded. API_FULL_URL: ${API_FULL_URL}"
fi

#==================================================
# Log Setup
#==================================================
readonly CURRENT_DATE
CURRENT_DATE=$(date +"%Y%m%d")

# Create one log file per day and write all log messages to LOG_FILE using 'logger "<message"'
readonly LOG_FOLDER="./logs"
readonly LOG_FILE="${LOG_FOLDER}/main_${CURRENT_DATE}.log"
readonly BAD_FOLDER="./bad"
readonly BAD_FILE="${BAD_FOLDER}/main_${CURRENT_DATE}.bad"
readonly SUCCESSFUL_FOLDER="./successful"
readonly SUCCESSFUL_FILE="${SUCCESSFUL_FOLDER}/main_${CURRENT_DATE}.successful"

#==================================================
# Functions
#==================================================

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
    local TYPE="$1"
    local MESSAGE="$2"
    local CURRENT_TIME
    # If you need UTC
    # CURRENT_TIME=$(date -u +"%Y%m%d %H:%M:%S")
    CURRENT_TIME=$(date +"%Y%m%d %H:%M:%S")

    case "$TYPE" in
        INFO|ERROR|WARN|DEBUG) ;; # expected types
        *) TYPE="INFO" ;;          # fallback
    esac

    echo "$CURRENT_TIME - $TYPE - $MESSAGE" >> "$LOG_FILE"
}

transform_data() {
    logger "INFO" "transform_data run"
}
backup_files() {
    logger "INFO" "backup_files run"
}

#==================================================
# Entrypoint
#==================================================

main "$@"
