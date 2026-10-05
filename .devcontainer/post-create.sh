#!/usr/bin/env bash
# Runs once when the Codespace is created. Tools are already in the image.
set -euo pipefail

# Repo folder may be owned by a different uid (local Docker bind mounts)
git config --global --add safe.directory "$PWD"

# git hooks live in .git/, which is never copied from the template,
# so the pre-commit hook has to be installed in each new copy.
ggshield install --mode local --hook-type pre-commit --force

echo "✅ Codespace ready."
