#!/bin/bash

# Default values
ROOT_DIR=""
EDITOR="vim"

# Check if a config file exists and read values from it
CONFIG_FILE="$HOME/.config/quak/config"

if [ -f "$CONFIG_FILE" ]; then
  while IFS='=' read -r key value; do
    case "$key" in
      "ROOT_DIR")
        ROOT_DIR="$value"
        ;;
      "EDITOR")
        EDITOR="$value"
        ;;
      *)
        # Ignore unrecognized keys
        ;;
    esac
  done < "$CONFIG_FILE"
fi

# If ROOT_DIR is still empty, set a default value
ROOT_DIR="${ROOT_DIR:-/tmp}"

# Display usage instructions
show_help() {
  echo "Usage: $0 [options] [note_title]"
  echo "Options:"
  echo "  --tree     Show a tree of all notes"
  echo "  --sync     Switch to the parent directory and execute 'ngx quartz sync'"
  echo "  --edit     Switch to ROOT_DIR and open the editor for editing"
  echo "  --config   Switch to ROOT_DIR/.. and open the editor for configuring"
  echo "  --help     Display this help message"
  exit 1
}

# Generate a simple tree-like listing
generate_tree() {
  local INDENT=""
  local PREFIX=""
  local DIR="$1"
  local LEVEL="$2"
  local FILE

  for FILE in "$DIR"/*; do
    if [ -d "$FILE" ]; then
      echo "$INDENT|-- $(basename "$FILE")/"
      generate_tree "$FILE" "$((LEVEL + 1))"
    elif [ -f "$FILE" ]; then
      echo "$INDENT|-- $(basename "$FILE")"
    fi
  done
}

# Handle different script operations
case "$1" in
  "--tree")
    # Show a tree of all notes
    echo "$(basename "$ROOT_DIR")/"
    generate_tree "$ROOT_DIR" 1
    ;;

  "--sync")
    # Switch to the parent directory and execute 'ngx quartz sync'
    cd "$ROOT_DIR/.." || exit
    ngx quartz sync
    ;;

  "--edit")
    # Switch to ROOT_DIR and open the editor
    cd "$ROOT_DIR" || exit
    "$EDITOR" .
    ;;

  "--config")
    # Switch to ROOT_DIR/.. and open the editor
    cd "$ROOT_DIR/.." || exit
    "$EDITOR" .
    ;;

  "--help")
    # Display usage instructions
    show_help
    ;;

  *)
    # Default behavior: Create a new note
    # Prompt the user for the note title (filename without extension)
    if [ -z "$1" ]; then
      echo "Note title is missing."
      show_help
    fi

    NOTE_TITLE="$1"

    # Remove spaces and replace them with underscores
    NOTE_TITLE="${NOTE_TITLE// /_}"

    # Check if the note title is empty
    if [ -z "$NOTE_TITLE" ]; then
      echo "Note title cannot be empty."
      exit 1
    fi

    # Prompt the user to select a topic or create a new one
    echo "Select a topic (or enter a new one):"
    select TOPIC_DIR in $(find "$ROOT_DIR" -maxdepth 1 -type d -name '.*' -prune -o -type d -print | sed '1d; s#.*/##'); do
      if [ -z "$TOPIC_DIR" ]; then
        echo "Creating a new topic..."
        read -p "Enter the name of the new topic: " NEW_TOPIC
        if [ -z "$NEW_TOPIC" ]; then
          echo "Topic name cannot be empty."
          exit 1
        fi
        TOPIC_DIR="$ROOT_DIR/$NEW_TOPIC"
        mkdir "$TOPIC_DIR"
        break
      elif [ -n "$TOPIC_DIR" ]; then
        TOPIC_DIR="$ROOT_DIR/$TOPIC_DIR"
        break
      else
        echo "Invalid selection. Please try again."
      fi
    done

    # Create the note file with the .md extension and add front matter
    NOTE_FILE="$TOPIC_DIR/$NOTE_TITLE.md"
    touch "$NOTE_FILE"

    # Add front matter to the note file
    cat <<EOL > "$NOTE_FILE"
---
title: $NOTE_TITLE
draft: false
tags:
  - 
---

EOL

    # Open the note file in the specified editor
    "$EDITOR" "$NOTE_FILE"
    ;;
esac
