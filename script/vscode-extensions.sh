#!/bin/bash
# Install Visual Studio Code Plugins

declare -a packages=(
 'bierner.emojisense'
 'EditorConfig.EditorConfig'
 'file-icons.file-icons'
 'HookyQR.beautify'
 'timonwong.shellcheck'
)

for extension in "${packages[@]}"; do
  codium --install-extension $extension
done
