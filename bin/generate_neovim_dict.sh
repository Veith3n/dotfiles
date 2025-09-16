#!/bin/bash

# Path to your Aspell personal word list file
ASPPELL_DICT="$HOME/.aspell.en.pws"

# Neovim spell directory and output spell file
NVIM_SPELL_DIR="$HOME/.config/nvim/spell"
NVIM_SPELL_FILE="$NVIM_SPELL_DIR/en-custom.utf-8.spl"

# Ensure spell directory exists
mkdir -p "$NVIM_SPELL_DIR"

# Check if Aspell word list exists
if [ ! -f "$ASPPELL_DICT" ]; then
  echo "Aspell word list file not found: $ASPPELL_DICT"
  exit 1
fi

# Regenerate spell file only if Aspell file is newer or spell file is missing
if [ ! -f "$NVIM_SPELL_FILE" ] || [ "$ASPPELL_DICT" -nt "$NVIM_SPELL_FILE" ]; then
  echo "Generating Neovim spell file from Aspell word list..."
  nvim -c ":mkspell! $NVIM_SPELL_DIR/en-custom $ASPPELL_DICT" -c ":q"
  echo "Generated"
else
  echo "Spell file is up to date. No regeneration needed."
fi
