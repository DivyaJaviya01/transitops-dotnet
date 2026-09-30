# TransitOps - Team GitHub Setup (Web Forms + MasterPage + MySQL)

> Adapted from `docs/rachit/ASP.NET_Team_GitHub_Setup.md` for `TransitOPS_net`.

GitHub shares code, not your environment. Both PCs need same setup.

## 1. Workflow

```text
Your PC -> push -> GitHub -> pull -> Friend PC
Branches: main (stable), develop (combined), <name>-feature (work)
```

## 2. What to push / not push

Push:
- `TransitOPS_net.slnx`, `TransitOPS_net.csproj`
- `Site.Master*`, `Web.config` (with YOUR_PASSWORD), `packages.config`
- `Guest/`, `Admin/`, `FleetManager/`, `Dispatcher/`, `SafetyOfficer/`, `FinancialAnalyst/` (.aspx + .cs)
- `Data/DBHelper.cs`, `Services/`, `Helpers/`, `Content/`, `Scripts/`, `Images/`
- `Database/TransitOps.sql`, `docs/`

Do NOT push:
- `bin/`, `obj/`, `.vs/`, `packages/`, `*.user`, `*.suo`
- `App_Data/*.mdf`, `*.ldf`
- Real DB passwords, API keys

## 3. Environment (both PCs same)

- Visual Studio 2022 + ASP.NET workload
- .NET Framework 4.7.2
- MySQL 8.x + MySQL Connector/NET
- NuGet `MySql.Data` 9.1.0 (Restore on open)

## 4. Daily use

```bash
git checkout develop
git pull origin develop
git checkout -b <your-name>-feature
# work, then
git add .
git commit -m "Add trips grid"
git push origin <your-name>-feature
# Pull Request to develop, review, merge, test, then to main
```

## 5. Security

Never commit `password=RealPass123`. Keep `password=YOUR_PASSWORD` in repo. Each dev edits locally only.

## 6. Golden rule

Fresh clone must run after `12_Friend_Setup_Guide.md`. If not, update docs + `Database/TransitOps.sql`, do not send ZIPs.
