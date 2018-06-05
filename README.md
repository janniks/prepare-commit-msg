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
| `bugfix/ABC-012-add-initial-repo` | `Set up repository` | `[ABC-012] Set up` |
| `feature/ABC-123-something-awesome` | `Add files` | `[ABC-123] Add files` |
| `feature/ABC-123-something-awesome` | `[XYZ-123] Something different` | _not modified_ |

### Default Regular Expressions
These are the default regular expressions that are used by the script on install. They can easily be changed during install using the provided script or manually tweaked.

#### Parsing issue numbers from current branch name
`/[.]*\/([\-\w]*?\-\d+)/`

| Detects issue number | Does not detect issue number |
| :------------------: | :--------------------------: |
| `feature/ABC-123-test-message` | `abc-123-do-it` |
| `Improvement/XYZ-ABC-321-Crazy-Name` | `simple-branch-name` |

#### Checking commit messages for existing issue numbers
`/^\s*\[[\-\w]*\d\]/`

| Detects issue number | Does not detect issue number |
| :------------------: | :--------------------------: |
| `[ABC-123] Test message` | `Test message` |
| `[XYZ 312] Message test` | `[ABC] Testing stuff` |
| ` [XYZ-ABCD-321] Awesome sauce` | ` [Add ABC-123 files]` |
| `Add multiple dimensions [AA-012]` | |

#### Detecting automated commits by git
`/(Merge\sbranch\s\'|\#\sRebase\s|This\sreverts\scommit\s)/`

| Ignores following commits |
| :-------------------: |
| `Merge branch 'testing' into master` |
| `# Rebase commit 9f3bc7b` |
| `This reverts commit 28da9f6` |

You can use tools like [Regex101](https://regex101.com/) to tweak and test these regular expressions.

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
