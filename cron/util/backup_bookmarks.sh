#!/bin/bash

# DESCRIPTION:
# I use this script to do daily backups of my
# Firefox bookmarks.  The resulting file is stored
# in my NextCloud.

# SCRIPT CONFIGURATION:
# - BOOKMARKS_BACKUP_DIR | This is the folder the script copies backups into.
#   can be wherever


LIVE_BOOKMARKS_DIR=($HOME/.mozilla/firefox/*.default-release/bookmarkbackups)
BOOKMARKS_BACKUP_DIR="$HOME/Nextcloud/Documents/Bookmarks"

LATEST_BOOKMARK_FILE="$(ls "${LIVE_BOOKMARKS_DIR[*]}" | tail -n 1)"
LATEST_BACKUP_FILE="$(ls "$BOOKMARKS_BACKUP_DIR" | tail -n 1)"

LIVE_FILE="${LIVE_BOOKMARKS_DIR[*]}/$LATEST_BOOKMARK_FILE"
BACKUP_FILE="$BOOKMARKS_BACKUP_DIR/$LATEST_BACKUP_FILE"

backup_bookmarks() {
  cp "$LIVE_FILE" "$BOOKMARKS_BACKUP_DIR/"
}

main() {
  # Exit if Firefox hasn't generated a bookmark file yet
  if [ -z "$(ls -A "${LIVE_BOOKMARKS_DIR[*]}")" ]; then
    printf "No saved bookmarks. exiting.\n"
    exit
  fi

  # Run backup immediately if backup directory is empty
  if [ -z "$(ls -A "$BOOKMARKS_BACKUP_DIR")" ] ; then
    printf "No backups detected. Backing up latest bookmarks file.\n"
    backup_bookmarks
    exit
  fi

  # If there are files in the source/dest directories, pluck the
  # most recently modified from each and only run a backup if
  # they are different.
  BOOKMARK_DIFF="$(diff "$LIVE_FILE" "$BACKUP_FILE")"

  if [ "$BOOKMARK_DIFF" != "" ]; then
    printf "Bookmarks have been updated. Running backup.\n"
    backup_bookmarks
  else
    printf "No changes to bookmarks. Ignoring.\n"
  fi
}

main "${@}"
