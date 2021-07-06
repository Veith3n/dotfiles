# Dotfiles
## Prerequisites
- Installed `homebrew`
- For now only mac os is supported
## Installation
1. Run `./install` in the project's directory
2. Run `cp smudge_sensitive_data.example smudge_sensitive_data` and fill in the values
2. Run `./smudge_sensitive_data > tmp; cat tmp > .env_variables; rm tmp` to update sensitive values
3. Update git gpg key value
3. Run `PlugInstall` in vim tab
3. Set `save changes` option in preferences tab in `iterm` to `automatically`
