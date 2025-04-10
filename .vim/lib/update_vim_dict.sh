#!/bin/bash

# Path to your Aspell dictionary files
ASPPELL_DICT_PATH="$HOME/.aspell.en.pws"

# Path to your Vim spell directory and file
VIM_SPELL_PATH="$HOME/.vim/spell"
VIM_SPELL_FILE="$VIM_SPELL_PATH/en-custom.utf-8.spl"

# Ensure the Vim spell directory exists
mkdir -p "$VIM_SPELL_PATH"

# Check if the Vim spell file exists or needs regeneration
if [ ! -f "$VIM_SPELL_FILE" ] || [ -n "$(find "$ASPPELL_DICT_PATH" -type f -newer "$VIM_SPELL_FILE")" ]; then
  # Regenerate Vim's .spl file using Aspell dictionary and save it to the specified location

  # vim -c ":mkspell! ~/.vim/spell/en-custom ~/.aspell.en.pws" -c ":q"
  vim -c ":mkspell! $VIM_SPELL_PATH/en-custom $ASPPELL_DICT_PATH" -c ":q"
fi
