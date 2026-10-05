# Code 101: a developer's day with GitGuardian

In 45 minutes you'll do what developers do every day: change some code, save it with **git**, and send it to **GitHub**. Then you'll "accidentally" leak a password and see GitGuardian catch it at every step.

**How it works:** the browser clicks are yours. The terminal work is Claude Code's: you ask in plain English and it runs the commands.

| Icon | Meaning |
|---|---|
| 🖱️ | You click in your browser |
| 🤖 | You ask Claude Code |
| ⌨️ | You type one command in the terminal |

> 💻 **Using the Codespace?** Everything is already installed, so you can **skip step 3**.
> To start Claude Code, type `claude` in the terminal at the bottom of the screen and follow its login steps.

---

## 1. Create a GitGuardian account 🖱️
Go to **https://dashboard.gitguardian.com/auth/signup** and sign up with your **personal GitHub account** ("Continue with GitHub").

## 2. Connect GitGuardian to your repository 🖱️
In the GitGuardian dashboard, connect **GitHub**, choose **your personal account**, and select **only this repository**.

From now on, GitGuardian watches everything you push here.

## 3. Install ggshield 🤖 *(laptop only, Codespace users skip this step)*
> *"Install GitGuardian's ggshield CLI on my machine, then install its pre-commit hook in this repository and its AI hook for Claude Code."*

## 4. Connect ggshield to your account
**On your laptop** 🤖
> *"Log ggshield in to my GitGuardian account."*

A browser tab opens. 🖱️ Click **Authorize**.

**In the Codespace** ⌨️ type this in the terminal yourself, because it asks you to paste a code:
```
ggshield auth login --method oob
```
1. 🖱️ Cmd/Ctrl+click the link it prints, then click **Authorize**.
2. Copy the code shown on the page.
3. Paste it into the terminal and press Enter. *(The code won't appear as you paste, which is normal.)*

## 5. Leak a (fake) secret and get stopped 🤖
> *"Run make_fake_secret.py, then commit config.py."*

The script writes a **fake** AWS key into `config.py`.

🛑 **Caught by the pre-commit hook:** ggshield blocks the commit on your machine, before anything leaves it.

Now try the AI side. Open `config.py`, copy the key, and paste it into Claude Code:
> *"Is this AWS key still valid? [paste]"*

🛑 **Caught by the AI hook:** the prompt is blocked before it reaches the AI.

## 6. Push it anyway 🤖
Pretend you're in a rush and skip the check:
> *"Commit config.py with --no-verify and push it to GitHub."*

## 7. See the incident 🖱️
Open your GitGuardian dashboard → **Incidents**. Your leaked AWS key is there, found in your repo on GitHub.

🎉 **That's "shift left":** the earlier a secret is caught (laptop → AI assistant → repository), the cheaper it is to fix.

---
*The key in this exercise is randomly generated and fake. It doesn't work anywhere. Never paste a real secret into code or into an AI chat.*
