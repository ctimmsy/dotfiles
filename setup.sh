#!/bin/bash

set -euo pipefail

if ! command -v chezmoi >/dev/null; then
  sh -c "$(curl -fsLS https://get.chezmoi.io/)" -- -b $HOME/.local/bin init --apply "ctimmsy"
fi
curl -s https://ohmyposh.dev/install.sh | bash -s -- -d $HOME/.local/bin

