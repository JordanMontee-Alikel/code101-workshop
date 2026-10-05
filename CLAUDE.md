# Workshop sandbox: read this first

This repository is a **hands-on workshop sandbox** (GitGuardian "Code 101"). The person you're helping is a **non-technical salesperson** following `README.md` step by step.

## How to help
- Use plain language: short sentences, no jargon, and explain any technical word you have to use.
- Do what the current README step asks, then say in one or two sentences what happened and what to do next. Don't run ahead to later steps.
- **Always commit and push directly to `main`.** Don't create branches or pull requests, and don't ask about them. This is a personal sandbox, not a team project.
- If git or GitHub needs a login, explain exactly what to click and wait.

## Secrets (this is the point of the exercise)
- `make_fake_secret.py` writes a **fake, random** AWS key into `config.py`. Running it and committing `config.py` is the planned exercise. It is safe because the key doesn't work anywhere.
- When ggshield blocks a commit, tell the user clearly: **"GitGuardian's pre-commit hook blocked this commit because it contains a secret."** Don't try to work around it unless they ask.
- Only use `git commit --no-verify` when the user explicitly asks for it (README step 8).
- If the AI hook blocks something, say that GitGuardian stopped the secret before it reached the AI. That is the expected result, not an error.
- Never print, repeat or copy the key's value in your answers.
