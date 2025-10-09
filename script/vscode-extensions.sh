#!/bin/bash
# Install Visual Studio Code Plugins

declare -a packages=(
 'bierner.emojisense'
 'bierner.markdown-mermaid'
 'file-icons.file-icons'
 'kaiwood.endwise'
 'ms-azuretools.vscode-docker'
 'ms-vscode-remote.remote-containers'
 'ms-vscode-remote.remote-explorer'
 'ms-vscode-remote.remote-ssh'
 'ms-vscode-remote.remote-ssh-edit'
 'yzane.markdown-pdf'
)

for extension in "${packages[@]}"; do
  codium --install-extension $extension
done
