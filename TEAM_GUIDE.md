# TransitOps - Team Guide (Read First)

For all 3 members. Simple rules to get equal GitHub history with zero merge conflicts.

## 1. Setup (once per PC)

```bash
git clone https://github.com/DivyaJaviya01/transitops-dotnet.git
cd TransitOPS
git checkout develop
git pull origin develop
git config user.name "YOUR NAME"
git config user.email "your@email.com"
```

Open `TransitOPS_net/TransitOPS_net.slnx` in Visual Studio 2022.
Set `Guest/Home.aspx` as Start Page. Press F5 to run. No database needed now.

## 2. Your screens (1 file = 1 screen, no duplicate)

| Who | Screens | Files (edit ONLY these) |
|---|---|---|
| Divya (admin side) | Dashboard, Trips, Expenses, Pricing | `Admin/Dashboard.aspx`, `Dispatcher/Trips.aspx`, `FinancialAnalyst/FuelExpenses.aspx`, `Guest/Pricing.aspx` (to be created) |
| Member 2 | Vehicle registry, Drivers, Maintenance, Features | `FleetManager/Vehicles.aspx`, `SafetyOfficer/Drivers.aspx`, `FleetManager/Maintenance.aspx`, `Guest/Features.aspx` (to be created) |
| Member 3 | Home landing, Login, Sign Up, About, Contact | `Guest/Home.aspx`, `Guest/SignIn.aspx`, `Guest/SignUp.aspx`, `Guest/About.aspx` (new), `Guest/Contact.aspx` (new) |

Shared files (`Site.Master`, `Content/site.css`) — only Divya edits.
If you need style, put `<style>...</style>` inside your page's `head` block for now.

Admin/Dispatcher share the SAME `Trips.aspx` file. Do NOT make copies like `Admin/Trips.aspx`.

## 3. Daily work (no merge conflict)

```bash
# 1. update first, every day
git checkout develop
git pull origin develop

# 2. make your own branch (once per task)
git checkout -b <yourname>-<screen>
# example: git checkout -b divya-trips

# 3. edit ONLY your file, then commit ONLY that file
git add TransitOPS_net/Dispatcher/Trips.aspx
git commit -m "Add trips UI"
git push origin <yourname>-<screen>

# 4. on GitHub: Pull Request -> develop, ask 1 teammate to review + merge
```

## 4. Rules (strict)

DO:
- 1 screen = 1 commit = 1 push (this gives equal history)
- `git pull` before you start work every day
- `git add <your file>` — never `git add .`
- 1 branch per screen, e.g. `member2-vehicles`

DO NOT:
- Never edit other's folder
- Never edit `bin/ obj/ .vs/ packages/` (auto-ignored)
- Never commit real DB password (we have no DB now)
- Never commit with other's name/email (check `git config user.name`)
- Never push directly to `main`. Only to your branch, then PR to `develop`.

## 5. Check equal work

```bash
git shortlog -sne --all
```

Each member must have 4-5 commits + 1-2 PRs before submission.

## 6. If conflict happens

1. Stop. Do NOT force push.
2. `git pull origin develop` on your branch
3. Open conflicted file, keep both parts, save
4. `git add <file>`, `git commit -m "Resolve merge"`, `git push`
5. Ask in group if stuck.
