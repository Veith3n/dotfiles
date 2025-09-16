# Dotfiles

## Prerequisites

- Installed `homebrew`
- For now only mac os is supported

## Supported terminals

- Iterm for mac os (config inside iterm dir)
- Wezterm for Windows/Linux (config inside wezterm dir)

## Installation

1. Run `./install` in the project's directory
2. Run `cp .git_scripts/smudge_sensitive_data.example .git_scripts/smudge_sensitive_data` and fill in the values
3. Run `.git_scripts/smudge_sensitive_data > tmp; cat tmp > .env_variables; rm tmp` to update sensitive values
4. Run `cp .git_scripts/smudge_gitconfig.example .git_scripts/smudge_gitconfig` and fill in the values, update values in gitconfig
5. Update git gpg key value
6. Run `mkdir ~/Library/Application\ Support/iTerm2/Scripts/AutoLaunch &&  BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" && ln -fsv ${BASE_DIR}/iterm/iterm_color_switching.py ~/Library/Application\ Support/iTerm2/Scripts/AutoLaunch/`
7. Set `save changes` option in preferences tab in `iterm` to `automatically`
8. Fill out values in `.env_variables` file

### Vim specific

1. Run `~/.vim/lib/update_vim_dict.sh` to generate custom vim dictionary
2. Run `PlugInstall` in vim tab

### Neovim specific

1. Run `generate_neovim_dict.sh` when adding new words to custom aspell dict
