# Dotfiles

## Prerequisites

- Installed `homebrew`
- For now only mac os is supported

## Installation

1. Run `./install` in the project's directory
2. Run `cp .git_scripts/smudge_sensitive_data.example .git_scripts/smudge_sensitive_data` and fill in the values
3. Run `.git_scripts/smudge_sensitive_data > tmp; cat tmp > .env_variables; rm tmp` to update sensitive values
2. Run `cp .git_scripts/smudge_gitconfig.example .git_scripts/smudge_gitconfig` and fill in the values, update values in gitconfig
4. Update git gpg key value
5. Run `PlugInstall` in vim tab
6. Run `mkdir ~/Library/Application\ Support/iTerm2/Scripts/AutoLaunch &&  BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" && ln -fsv ${BASE_DIR}/iterm/iterm_color_switching.py ~/Library/Application\ Support/iTerm2/Scripts/AutoLaunch/`
6. Set `save changes` option in preferences tab in `iterm` to `automatically`
6. Fill out values in `.env_variables` file
