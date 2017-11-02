# Prefix Issue Number - Git Hook
This is a git hook for lazy people. :sleeping:

## Description :books:
This hook prepends a parsed issue number in front of your commit messages.
This git hook requires `ruby` to be installed _(no further external gems are necessary though)_.

## Install :rocket:
### Install Script
To install simply run the following command. This requires `curl` to be installed.
```bash
sh <(curl -s https://raw.githubusercontent.com/janniks/prepare-commit-msg/master/scripts/install.sh)
```

### Install Manually
If you prefer to install manually you can walkthrough the following steps:

1. Copy the `scripts/prepare-commit-msg` script into your local git repository inside `.git/hooks`
1. Make sure the is script executable by running `chmod +x prepare-commit-msg`
1. Enjoy! Test it by committing anything!

## Uninstall :confounded:
If you're unhappy with this git hook, simply run `rm -rf .git/hooks/prepare-commit-msg` to uninstall again. Please let me know what you didn't like!

## Usage :wrench:
> todo
