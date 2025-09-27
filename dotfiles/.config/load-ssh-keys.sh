#!/bin/bash

# Wait for kwallet
kwallet-query -l kdewallet > /dev/null

patterns=("config" "known_host")

for key in "$HOME/.ssh"/*; do
  if [[ -f "$key" && "${key##*.}" != "pub" ]]; then
    if [[ ! $key =~ (config|known_host) ]]; then
      ssh-add -q "$key" < /dev/null
    fi
  fi
done
