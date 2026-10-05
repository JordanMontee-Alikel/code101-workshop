# Code 101: a developer's day with GitGuardian

In 45 minutes you'll do what developers do every day: change some code, save it with **git**, and send it to **GitHub**. Then you'll "accidentally" leak a password and see GitGuardian catch it at every step.

**How it works:** the browser clicks are yours. The terminal work is Claude Code's: you ask in plain English and it runs the commands.

| Icon | Meaning |
|---|---|
| 🖱️ | You click in your browser |
| 🤖 | You ask Claude Code |
| ⌨️ | You type in the terminal yourself |
| 💻 | Codespace users: what's different for you |

> **Terminal tips**
> - **Links:** hold **Cmd** (Mac) or **Ctrl** (Windows) and click. If a box asks *"Do you want Code to open the external website?"*, click **Open**.
> - **Typing:** click inside the terminal first. If pressing Enter doesn't send your message, click inside it and press Enter again.
> - If Claude asks *"How is Claude doing this session?"*, press **0** to dismiss it.

---

## 0. Get your own copy of this repository 🖱️
At the top of this page, click **Use this template → Create a new repository**.
- **Repository name:** `code101-workshop`
- **⚠️ Visibility starts as Public: click it and choose Private.** Your copy will contain a (fake) leaked key, so it must not be public.

Then click **Create repository** and continue in **your** new repository:

**💻 Codespace:** click **Code → Codespaces → Create codespace on main**. It opens in a new tab and takes about 2 minutes.
- If a box asks *"Do you trust the authors of the files in this folder?"*, click **Trust Folder & Continue**.
- This guide opens as plain text on the left. To read it formatted, right-click `README.md` in the file list → **Open Preview**.

Then log in to Claude Code ⌨️:
1. Type `claude` in the terminal at the bottom and press Enter.
2. Press Enter to keep the colours, then Enter again for **"Claude account with subscription"**.
3. 🖱️ Click the long link (Cmd/Ctrl+click), then click **Authorize**. *(If no tab opens, press `c` to copy the link and paste it into a new browser tab.)*
4. Copy the code shown on the page, paste it into the terminal and press Enter. Then press Enter on the next screens until you see Claude's input box.

**Laptop:** open Claude Code and ask 🤖 *"Clone my GitHub repository `code101-workshop` and open it."* If Claude asks whether you trust the folder, choose **Yes**.

## 1. Create a GitGuardian account 🖱️
Go to **https://dashboard.gitguardian.com/auth/signup** and click **Sign up with GitHub** (use your personal GitHub account). The page can stay blank for a few seconds while it loads.

## 2. Connect GitGuardian to your repository 🖱️
In the GitGuardian dashboard, connect **GitHub**, choose **your personal account**, and select **only `code101-workshop`**.

From now on, GitGuardian watches everything you push there.

> If a red message says *"Your current plan does not allow accessing this resource"*, ignore it. It's about a paid feature you don't need today.

## 3. Install ggshield 🤖
> *"Install GitGuardian's ggshield CLI on my machine."*

💻 **Codespace: skip this step**, it's already installed.

## 4. Connect ggshield to your account
**Laptop** 🤖
> *"Log ggshield in to my GitGuardian account."*

A browser tab opens. 🖱️ Tick **"I started this CLI myself"**, then click **Confirm**.

**💻 Codespace** ⌨️ Claude is using the first terminal, so open a second one: click **+** at the top right of the terminal panel. Then type:
```
ggshield auth login --method oob
```
1. 🖱️ Click the link it prints (Cmd/Ctrl+click).
2. Tick **"I started this CLI myself"**, then click **Confirm**.
3. Copy the code shown on the page, paste it into the terminal and press Enter. *(It shows partly hidden with \*\*\*\*, which is normal.)*
4. You'll see **"Success! You are now authenticated."** Then switch back to the first terminal (Claude's) and **click inside it** before typing.

> Tip: use the 🖱️ copy button on the code page instead of selecting the code by hand. A partial paste gives *"Cannot create a token"*.

> Red ✗ lines on the page (*"This permission will be skipped"*) and a *"scopes were not granted"* warning in the terminal are normal on a free account. Everything you need works.

## 5. Turn on the safety nets 🤖
> *"Install ggshield's pre-commit hook in this repository, and its AI hook for Claude Code."*

These are the two checks you'll trigger in step 7:
- **Pre-commit hook:** checks every commit on your machine before it's saved.
- **AI hook:** checks what you and Claude Code send to the AI.

Then **restart Claude Code** (type `/exit`, then `claude`) so it picks up the AI hook.

💻 **Codespace: skip this step**, both are already on.

## 6. Make a normal change and push it 🤖
> *"Add a line to app.py that prints today's date, then commit and push it to main."*

ggshield checks the commit and finds no secrets. On GitHub, refresh your repository: your change is there. ✅ That's a developer's normal day.

## 7. Leak a (fake) secret and get stopped 🤖
> *"Run make_fake_secret.py, then commit config.py."*

The script writes a **fake** AWS key into `config.py`. Claude tells you the commit was blocked.

🛑 **Two safety nets fire at once:**
- the **pre-commit hook** blocks the commit on your machine, before anything leaves it;
- the **AI hook** stops the secret in the error message from being sent to the AI.

*Want to see the pre-commit message itself?* ⌨️ In a terminal **without Claude in it** (💻: the second one, from step 4), type `git add config.py && git commit -m "add config"`.

Now try the AI side directly. Open `config.py`, select **both lines** (`AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`), copy them, and paste them into Claude Code:
> *"Is this AWS key still valid? [paste]"*

🛑 **Caught by the AI hook:** *"Detected 1 secret in your prompt… The prompt was not sent to the agent."* Your screen still shows what you typed, but it never left your machine.

## 8. Push it anyway 🤖
Pretend you're in a rush and skip the check:
> *"Commit config.py with --no-verify and push it to main."*

## 9. See the incident 🖱️
Open your GitGuardian dashboard. In the left menu, click **Internal secret incidents**. Within a minute, your leaked AWS key appears there, found in your repository on GitHub.

🎉 **That's "shift left":** the earlier a secret is caught (laptop → AI assistant → repository), the cheaper it is to fix.

---
*The key in this exercise is randomly generated and fake. It doesn't work anywhere. Never paste a real secret into code or into an AI chat.*
