# TransitOps - Team Guide (Read First)

For Krisha, Jainil, Divya. Simple rules to get equal GitHub history with zero merge conflicts.

`main` always has the latest shared files (`Admin.Master`, `Site.Master`, `site.css`, Chart.js).
Start every task from `main` so you get them.

## 1. Setup (once per PC)

```bash
git clone https://github.com/DivyaJaviya01/transitops-dotnet.git
cd TransitOPS
git checkout main
git pull origin main
git config user.name "YOUR NAME"
git config user.email "your@email.com"
```

Open `TransitOPS_net/TransitOPS_net.slnx` in Visual Studio.
Set `Guest/Home.aspx` as Start Page. Press F5 to run. No database needed now.

## 2. Your screens (1 file = 1 screen, no duplicate)

| Who | Screens | Files (edit ONLY these) |
|---|---|---|
| Krisha | Home, About, Contact, Features, Pricing (all guest) | `Guest/Home.aspx`, `Guest/About.aspx`, `Guest/Contact.aspx`, `Guest/Features.aspx`, `Guest/Pricing.aspx` |
| Jainil | Maintenance, Reports, Fleet analysis, Settings, Login, SignUp | `FleetManager/Maintenance.aspx`, `Guest/SignIn.aspx`, `Guest/SignUp.aspx` (+ new `Admin/Reports.aspx`, `Admin/Analytics.aspx`, `Admin/Settings.aspx` — ask Divya to create placeholders first) |
| Divya | Dashboard, Vehicle registry, Drivers, Trips, Expenses | `Admin/Dashboard.aspx` (done, v0.2), `FleetManager/Vehicles.aspx`, `SafetyOfficer/Drivers.aspx`, `Dispatcher/Trips.aspx`, `FinancialAnalyst/FuelExpenses.aspx` |

Shared files — only Divya edits:
`Admin.Master`, `Site.Master`, `Content/site.css`, `Scripts/*`, `TransitOPS_net.csproj`.
If you need a style, put `<style>...</style>` inside your page's `head` block. Divya merges it later.

Admin pages share the SAME files (e.g. one `Trips.aspx` used by all roles). Do NOT make copies like `Admin/Trips.aspx`.

New pages (Reports, Analytics, Settings) do not exist yet — do NOT create them yourself (creates `.csproj` conflict). Ask Divya to add placeholders, pull `main`, then start.

## 3. How to work individually (no merge conflicts)

```bash
# 1. start fresh from main every time
git checkout main
git pull origin main

# 2. make your own branch (one branch per screen)
git checkout -b <yourname>-<screen>
# examples: krisha-home, jainil-maintenance, divya-trips

# 3. edit ONLY your file, then add ONLY that file
git add TransitOPS_net/FleetManager/Maintenance.aspx
git commit -m "feat: add maintenance work orders UI"
git push -u origin <yourname>-<screen>

# 4. on GitHub: Pull Request your branch -> develop
# ask 1 teammate to review, then merge
```

Why no conflicts:
- Each person touches different files, so merges are automatic.
- Never run `git add .` — it grabs others' files.
- Never edit `Admin.Master`, `site.css`, or `.csproj` unless you are Divya.
- Always `pull` before making a new branch, so you start from latest `main`.

## 4. Rules (strict)

DO:
- 1 screen = 1 branch = 1 commit = 1 push (this gives equal history)
- `git pull` before you start work every day
- `git add <your file>` — never `git add .`
- Branch names: `krisha-*`, `jainil-*`, `divya-*`

DO NOT:
- Never edit another member's file
- Never edit `bin/ obj/ .vs/ packages/` (auto-ignored by git)
- Never commit real DB passwords (we have no DB now)
- Never commit with another member's name/email (check `git config user.name`)
- Never push directly to `main` or `develop`. Only your branch, then PR.

## 5. Check equal work

```bash
git shortlog -sne --all
```

Each member needs 4-5 commits + PRs before submission.

## 6. If conflict happens

1. Stop. Do NOT force push.
2. On your branch: `git pull origin develop`
3. Open the conflicted file, keep both parts, save.
4. `git add <file>`, `git commit -m "Resolve merge"`, `git push`
5. Ask in the group if stuck.
