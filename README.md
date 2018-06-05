# Prefix Issue Number - Git Hook
This is a git hook for lazy people. :sleeping:

## Description :books:
This hook automatically prepends a parsed issue number (from the current branch) to your commit messages on every commit. _(See **Usage** for examples)_

This git hook requires `ruby`  to be installed _(everything should be pre-installed by default on macOS and most *Nix systems)_.

## Install :rocket:
### Install Script
To install simply run the following command. This requires `curl` to be installed.

```bash
sh <(curl -s https://raw.githubusercontent.com/janniks/prepare-commit-msg/master/scripts/install.sh)
```

### Install Manually
If you prefer to install manually you can walkthrough the following steps:

1. Copy the `scripts/prepare-commit-msg` script into your local git repository inside `.git/hooks`
1. Edit the placeholders in the beginning of the script
1. Make sure the is script executable by running `chmod +x prepare-commit-msg`
1. Enjoy! Test it by committing anything!

## Usage :wrench:

- If no issue number is found in the branch name, the commit message _will not be modified_.
- If the commit message already contains an issue number, the commit message _will not be modified_.

### Examples

| Branch name | Entered commit message | Updated commit message |
| ----------- | :--------------------: | :--------------------: |
| `bugfix/ABC-012-add-initial-repo` | `Set up` | `[ABC-012] Set up` |
| `feature/ABC-123-testing-something-awesome` | `Add files` | `[ABC-123] Add files` |
| `feature/ABC-123-testing-something-awesome` | `[XYZ] Do something different` | _not modified_ |

## FAQ & Problems

<details>
  <summary>I already have a global git-template set up!</summary>
  Install manually and add the git hook file to your hooks directory in your existing git-template.
</details>

## Uninstall :confounded:
If you're unhappy with this git hook:

* Simply run `rm -rf .git/hooks/prepare-commit-msg` to uninstall locally
* Or run `rm -rf ~/.git-template/hooks/prepare-commit-msg` to uninstall globally

Please let me know what you didn't like!
