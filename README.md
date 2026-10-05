# Code 101: a developer's day with GitGuardian

In 45 minutes you'll do what developers do every day: change some code, save it with **git**, and send it to **GitHub**. Then you'll "accidentally" leak a password and see GitGuardian catch it at every step.

**How it works:** the browser clicks are yours. The terminal work is Claude Code's: you ask in plain English and it runs the commands.

| Icon | Meaning |
|---|---|
| 🖱️ | You click in your browser |
| 🤖 | You ask Claude Code |
| ⌨️ | You type one command in the terminal |
| 💻 | Codespace users: what's different for you |

---

## 0. Get your own copy of this repository 🖱️
At the top of this page, click **Use this template → Create a new repository**.

> **⚠️ Set it to Private.** Your copy will contain a (fake) leaked key, and it must not be public.

Then, in **your** new repository:
- **💻 Codespace:** click **Code → Codespaces → Create codespace on main**. When the editor opens, type `claude` in the terminal at the bottom and follow its login steps.
- **Laptop:** open Claude Code and ask 🤖 *"Clone my GitHub repository `<your-repo-name>` and open it."*

## 1. Create a GitGuardian account 🖱️
Go to **https://dashboard.gitguardian.com/auth/signup** and sign up with your **personal GitHub account** ("Continue with GitHub").

## 2. Connect GitGuardian to your repository 🖱️
In the GitGuardian dashboard, connect **GitHub**, choose **your personal account**, and select **only your new repository**.

From now on, GitGuardian watches everything you push there.

## 3. Install ggshield 🤖
> *"Install GitGuardian's ggshield CLI on my machine."*

💻 **Codespace: skip this step**, it's already installed.

## 4. Connect ggshield to your account
**Laptop** 🤖
> *"Log ggshield in to my GitGuardian account."*

A browser tab opens. 🖱️ Click **Authorize**.

**💻 Codespace** ⌨️ type this in the terminal yourself, because it asks you to paste a code:
```
ggshield auth login --method oob
```
1. 🖱️ Cmd/Ctrl+click the link it prints, then click **Authorize**.
2. Copy the code shown on the page.
3. Paste it into the terminal and press Enter. *(The code won't appear as you paste, which is normal.)*

## 5. Turn on the safety nets 🤖
> *"Install ggshield's pre-commit hook in this repository, and its AI hook for Claude Code."*

These are the two checks you'll trigger in step 7:
- **Pre-commit hook:** checks every commit on your machine before it's saved.
- **AI hook:** checks what you and Claude Code send to the AI.

Then **restart Claude Code** (type `/exit`, then `claude`) so it picks up the AI hook.

💻 **Codespace: skip this step**, both are already on.

## 6. Make a normal change and push it 🤖
> *"Add a line to app.py that prints today's date, then commit and push it."*

ggshield checks the commit and says **"No secrets have been found"**. On GitHub, refresh your repository: your change is there. ✅ That's a developer's normal day.

## 7. Leak a (fake) secret and get stopped 🤖
> *"Run make_fake_secret.py, then commit config.py."*

The script writes a **fake** AWS key into `config.py`.

🛑 **Caught by the pre-commit hook:** ggshield blocks the commit on your machine, before anything leaves it.

Now try the AI side. Open `config.py`, copy the key, and paste it into Claude Code:
> *"Is this AWS key still valid? [paste]"*

🛑 **Caught by the AI hook:** the prompt is blocked before it reaches the AI.

## 8. Push it anyway 🤖
Pretend you're in a rush and skip the check:
> *"Commit config.py with --no-verify and push it to GitHub."*

## 9. See the incident 🖱️
Open your GitGuardian dashboard → **Incidents**. Your leaked AWS key is there, found in your repo on GitHub.

🎉 **That's "shift left":** the earlier a secret is caught (laptop → AI assistant → repository), the cheaper it is to fix.

---
*The key in this exercise is randomly generated and fake. It doesn't work anywhere. Never paste a real secret into code or into an AI chat.*
