#!/bin/bash
# Install Visual Studio Code Pplugins

declare -a packages=(
 'Adobe.extendscript-debug'
 'bierner.emojisense'
 'bowlerhatllc.vscode-nextgenas'
 'bowlerhatllc.vscode-swf-debug'
 'EditorConfig.EditorConfig'
 'file-icons.file-icons'
 'HookyQR.beautify'
 'mads-hartmann.bash-ide-vscode'
 'slevesque.vscode-autohotkey'
 'timonwong.shellcheck'
)

for extension in "${packages[@]}"; do
  codium --install-extension $extension
done
