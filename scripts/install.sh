#!/bin/sh

# show message
echo "\nInstalling git hook...\n"

# get git hook file
echo " - Downloading git hook..."
curl -s https://raw.githubusercontent.com/janniks/prepare-commit-msg/master/scripts/prepare-commit-msg > prepare-commit-msg

# move git hook to .git
echo " - Moving git hook..."
mv ./prepare-commit-msg ./.git/hooks/prepare-commit-msg

# modify execution permission
echo " - Requesting permission to execute git hook...\n"
chmod +x ./.git/hooks/prepare-commit-msg

# show success
echo "Successfully installed git hook!"
echo "If you're unhappy with this git hook, simply run \`rm -rf .git/hooks/prepare-commit-msg\` to uninstall again.\n"
