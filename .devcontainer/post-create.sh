#!/usr/bin/env bash
# Runs once when the Codespace is created.
set -euo pipefail

GGSHIELD_VERSION="1.55.0"   # pinned so every session behaves the same

echo "==> Installing ggshield ${GGSHIELD_VERSION}"
pipx install "ggshield==${GGSHIELD_VERSION}"
export PATH="$HOME/.local/bin:$PATH"

# Repo folder may be owned by a different uid (local Docker bind mounts)
git config --global --add safe.directory "$PWD"

echo "==> Installing ggshield pre-commit hook (this repo)"
ggshield install --mode local --hook-type pre-commit --force

echo "==> Installing ggshield AI hook for Claude Code"
ggshield install --mode global --hook-type claude-code --force

echo
echo "==> Versions"
git --version
gh --version | head -1
ggshield --version
claude --version || echo "claude: not found"

echo
echo "✅ Setup complete. Next: run 'ggshield auth login --method oob'"
