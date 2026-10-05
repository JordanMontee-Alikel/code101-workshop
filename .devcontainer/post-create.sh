#!/usr/bin/env bash
# Runs once when the Codespace is created. Tools are already in the image.
set -euo pipefail

# Repo folder may be owned by a different uid (local Docker bind mounts)
git config --global --add safe.directory "$PWD"

# git hooks live in .git/, which is never copied from the template,
# so the pre-commit hook has to be installed in each new copy.
ggshield install --mode local --hook-type pre-commit --force

# Browser Codespaces can't receive Claude Code's localhost login callback,
# so `claude` must not auto-open a tab: it goes straight to "paste the code".
# Scoped to claude only; other tools keep opening links normally.
grep -q "alias claude=" ~/.bashrc || echo "alias claude='BROWSER=false claude'" >> ~/.bashrc

# postCreateCommand output only goes to the hidden creation log,
# so greet participants from the terminal itself.
grep -q "Welcome to Code 101" ~/.bashrc || cat >> ~/.bashrc <<'EOF'
echo
echo "👋 Welcome to Code 101! Everything is installed."
echo "   Type  claude  and press Enter to start."
echo
EOF
