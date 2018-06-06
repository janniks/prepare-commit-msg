#!/bin/sh

# defaults
PLACEHOLDER_REGEX_COMMIT_ISSUE_NUMBER="^\s*\[[\-\w]*\d\]"
PLACEHOLDER_REGEX_BRANCH_ISSUE_NUMBER="[.]*\/([\-\w]*?\-\d+)"
PLACEHOLDER_REGEX_GIT_COMMIT_MESSAGES="(Merge\sbranch\s\'|\#\sRebase\s|This\sreverts\scommit\s)"
PLACEHOLDER_LOGGING_VERBOSE="true"

GITHUB_SCRIPT_URL="https://raw.githubusercontent.com/janniks/prepare-commit-msg/master/scripts/prepare-commit-msg"

PATH_GIT_GLOBAL="${HOME}/.git-template/"
PATH_GIT_LOCAL="./.git/"

HOOK_NAME="prepare-commit-msg"
HOOK_DIR="hooks/"
HOOK_FILE=""

# colors
RESET="\e[0m"
BLACK="\e[0;30m"
RED="\e[0;31m"
GREEN="\e[0;32m"
YELLOW="\e[0;33m"
BLUE="\e[0;34m"
PURPLE="\e[0;35m"
CYAN="\e[0;36m"
WHITE="\e[0;37m"

# escapes
LINE_UP="\e[1A"
LINE_CLEAR="\e[2K"

# helper method
clear_n_lines () {
	for ((n=0; n < $1; n++)); do printf -- "${LINE_CLEAR}${LINE_UP}${LINE_CLEAR}"; done
}

# show initial message
printf -- "\n${GREEN}Installing git hook...${RESET}\n\n"

# advanced options
printf -- "Would you like to install globally for all future repositories? ${BLUE}(y/n)${RESET}\n"
printf -- " - This will set up a git-template at \'${YELLOW}~/.git-template${RESET}\'\n${BLUE}>${RESET} "
read answer

clear_n_lines 4
if [ "$answer" != "${answer#[Yy]}" ]; then
	printf -- "\n - ${BLUE}Setting location to global${RESET}\n\n"
	OPTION_GLOBAL_TEMPLATE=true
else
	printf -- "\n - ${BLUE}Setting location to local${RESET}\n\n"
	OPTION_GLOBAL_TEMPLATE=false
fi

# advanced options
printf -- "Would you like to install with advanced options? ${BLUE}(y/n)${RESET}\n${BLUE}>${RESET} "
read answer

if [ "$answer" != "${answer#[Yy]}" ]; then
	# advanced options

	clear_n_lines 3
	printf -- " - ${BLUE}Using advanced options${RESET}\n\n"

	printf -- "Would you like to enable logging for the git hook? ${BLUE}(y/n)${RESET}\n"
	printf -- " - This will log activity of the git hook to the terminal output.\n${BLUE}>${RESET} "
	read answer

	clear_n_lines 4
	if [ "$answer" != "${answer#[Yy]}" ]; then
		printf -- " - ${BLUE}Enabling logging${RESET}\n\n"
		PLACEHOLDER_LOGGING_VERBOSE=true
	else
		printf -- " - ${BLUE}Disabling logging${RESET}\n\n"
		PLACEHOLDER_LOGGING_VERBOSE=false
	fi

	printf -- "Set a custom regex for parsing issue numbers from commit messages:\n"
	printf -- " - To use default value, leave empty and press return\n\n"
	printf -- "Default: ${BLUE}${PLACEHOLDER_REGEX_COMMIT_ISSUE_NUMBER}${RESET}\n${BLUE}>${RESET} "
	read answer

	if [ ! -z "$answer" ]; then
		PLACEHOLDER_REGEX_COMMIT_ISSUE_NUMBER=answer
	fi

	clear_n_lines 5
	printf -- "Set a custom regex for parsing issue numbers from branch names:\n"
	printf -- " - To use default value, leave empty and press return\n\n"
	printf -- "Default: ${BLUE}${PLACEHOLDER_REGEX_BRANCH_ISSUE_NUMBER}${RESET}\n${BLUE}>${RESET} "
	read answer

	if [ ! -z "$answer" ]; then
		PLACEHOLDER_REGEX_BRANCH_ISSUE_NUMBER=answer
	fi

	clear_n_lines 5
	printf -- "Set a custom regex for parsing commit messages to be ignored:\n"
	printf -- " - To use default value, leave empty and press return\n\n"
	printf -- "Default: ${BLUE}${PLACEHOLDER_REGEX_GIT_COMMIT_MESSAGES}${RESET}\n${BLUE}>${RESET} "
	read answer

	if [ ! -z "$answer" ]; then
		PLACEHOLDER_REGEX_GIT_COMMIT_MESSAGES=answer
	fi

	clear_n_lines 5
else
	clear_n_lines 3
fi

if [ "$OPTION_GLOBAL_TEMPLATE" = true ]; then
	if [ -d "$PATH_GIT_GLOBAL" ]; then
		printf -- " - Template directory already exists...\n"
	else
		if [ -d "${PATH_GIT_GLOBAL}/hooks" ]; then
			printf -- " - Template hooks directory already exists...\n"
		else
			mkdir -p "${PATH_GIT_GLOBAL}/hooks"
		fi
	fi

	if [ -e "${PATH_GIT_GLOBAL}${HOOK_DIR}${HOOK_NAME}" ]
	then
	    printf -- " - A global \'${BLUE}${HOOK_NAME}${RESET}\' git hook already exists. ${RED}Aborting...${RESET}\n\n"
	    exit
	fi
    
	HOOK_FILE="${PATH_GIT_GLOBAL}${HOOK_DIR}${HOOK_NAME}"

	printf -- " - Setting global git-template...\n"
    git config --global init.templatedir "$PATH_GIT_GLOBAL"
else
	if [ -e "${PATH_GIT_LOCAL}${HOOK_DIR}${HOOK_NAME}" ]
	then
	    printf -- " - A local \'${BLUE}${HOOK_NAME}${RESET}\' git hook already exists. ${RED}Aborting...${RESET}\n\n"
	    exit
	fi

	HOOK_FILE="${PATH_GIT_LOCAL}${HOOK_DIR}${HOOK_NAME}"
fi

printf -- " - Downloading git hook...\n"
curl -s "$GITHUB_SCRIPT_URL" > "$HOOK_FILE"

printf -- " - Replacing placeholders...\n"
PLACEHOLDER_REGEX_COMMIT_ISSUE_NUMBER=$(printf -- "$PLACEHOLDER_REGEX_COMMIT_ISSUE_NUMBER" | sed 's/\\/\\\\/g')
printf -v PLACEHOLDER_REGEX_COMMIT_ISSUE_NUMBER "%q" "$PLACEHOLDER_REGEX_COMMIT_ISSUE_NUMBER"
PLACEHOLDER_REGEX_COMMIT_ISSUE_NUMBER=$(printf -- "$PLACEHOLDER_REGEX_COMMIT_ISSUE_NUMBER" | sed 's/\//\\\//g')
PLACEHOLDER_REGEX_BRANCH_ISSUE_NUMBER=$(printf -- "$PLACEHOLDER_REGEX_BRANCH_ISSUE_NUMBER" | sed 's/\\/\\\\/g')
printf -v PLACEHOLDER_REGEX_BRANCH_ISSUE_NUMBER "%q" "$PLACEHOLDER_REGEX_BRANCH_ISSUE_NUMBER"
PLACEHOLDER_REGEX_BRANCH_ISSUE_NUMBER=$(printf -- "$PLACEHOLDER_REGEX_BRANCH_ISSUE_NUMBER" | sed 's/\//\\\//g')
PLACEHOLDER_REGEX_GIT_COMMIT_MESSAGES=$(printf -- "$PLACEHOLDER_REGEX_GIT_COMMIT_MESSAGES" | sed 's/\\/\\\\/g')
printf -v PLACEHOLDER_REGEX_GIT_COMMIT_MESSAGES "%q" "$PLACEHOLDER_REGEX_GIT_COMMIT_MESSAGES"
PLACEHOLDER_REGEX_GIT_COMMIT_MESSAGES=$(printf -- "$PLACEHOLDER_REGEX_GIT_COMMIT_MESSAGES" | sed 's/\//\\\//g')

sed -i '' "s/PLACEHOLDER_REGEX_COMMIT_ISSUE_NUMBER/\/${PLACEHOLDER_REGEX_COMMIT_ISSUE_NUMBER}\//g" "$HOOK_FILE"
sed -i '' "s/PLACEHOLDER_REGEX_BRANCH_ISSUE_NUMBER/\/${PLACEHOLDER_REGEX_BRANCH_ISSUE_NUMBER}\//g" "$HOOK_FILE"
sed -i '' "s/PLACEHOLDER_REGEX_GIT_COMMIT_MESSAGES/\/${PLACEHOLDER_REGEX_GIT_COMMIT_MESSAGES}\//g" "$HOOK_FILE"
sed -i '' "s/PLACEHOLDER_LOGGING_VERBOSE/${PLACEHOLDER_LOGGING_VERBOSE}/g" "$HOOK_FILE"

printf -- " - Requesting permission to execute git hook...\n"
chmod a+x "$HOOK_FILE"

printf -- "\n${GREEN}Successfully installed git hook!${RESET}\n\n"

if [ "$OPTION_GLOBAL_TEMPLATE" = true ]; then
	printf -- " - You will have to run ${BLUE}git init${RESET} manually in all existing git repositories...\n\n"
fi
