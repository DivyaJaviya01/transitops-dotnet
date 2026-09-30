# TransitOps - Project Structure and UI Rules
> Single source of truth. Code, docs, and database must stay in sync.

## 1. Stack (fixed)

- ASP.NET Web Forms + `Site.Master`, .NET Framework 4.7.2
- MySQL 8.x + `MySql.Data` 9.1.0 (NuGet)
- IIS Express, Visual Studio 2022 with `ASP.NET and web development` workload
- No MVC, no paid tools

## 2. Repo layout (must match real files)

```text
TransitOPS/
├── TransitOPS_net/
│   ├── TransitOPS_net.slnx
│   ├── TransitOPS_net.csproj
│   ├── Site.Master (+ .cs + .designer.cs)
│   ├── Web.config (TransitOpsDB with YOUR_PASSWORD placeholder)
│   ├── packages.config (CodeDom + MySql.Data)
│   ├── Guest/Home.aspx (start page), SignIn.aspx, SignUp.aspx
│   ├── Admin/Dashboard.aspx
│   ├── FleetManager/Vehicles.aspx, Maintenance.aspx
│   ├── Dispatcher/Trips.aspx
│   ├── SafetyOfficer/Drivers.aspx
│   ├── FinancialAnalyst/FuelExpenses.aspx
│   ├── Content/site.css
│   ├── Scripts/app.js
│   ├── Images/
│   ├── Data/DBHelper.cs
│   ├── Services/, Helpers/
│   └── App_Data/ (empty, local .mdf never committed)
├── Database/TransitOps.sql
├── docs/
└── .gitignore (bin/, obj/, .vs/, packages/, App_Data/*.mdf)
```

Rule: if you add a new `.aspx`, you must also add it to `TransitOPS_net.csproj` `<Content Include>`, and list it here.

## 3. MasterPage rules

- Only one master: `Site.Master` at project root
- IDs fixed: `head`, `form1`, `ContentPlaceHolder1`
- All role pages must use `MasterPageFile="~/Site.Master"`
- CSS only via `Content/site.css`, JS only via `Scripts/app.js`
- No inline `<style>` or page-specific CSS files

## 4. Naming rules

- Folders: `Guest, Admin, FleetManager, Dispatcher, SafetyOfficer, FinancialAnalyst, Content, Scripts, Images, Data, Services, Helpers`
- Pages: PascalCase, e.g. `FuelExpenses.aspx`, codebehind `TransitOPS_net.<Folder>.<Page>`
- DB connection name fixed: `TransitOpsDB`
- `DBHelper` only in `Data/DBHelper.cs`, use `DBHelper.GetConnection()` everywhere, no hardcoded connection strings in pages

## 5. UI rules (Figma first)

- Figma is design source. No new color/font without updating `Content/site.css` tokens
- `Guest/Home.aspx` is Operations Dashboard placeholder: Vehicles / Active Trips / Drivers cards
- Validators: use `RequiredFieldValidator`, `RegularExpressionValidator`, `ValidationSummary` like `master_page` reference
- Set start page: right-click `Guest/Home.aspx` > Set As Start Page

## 6. Database sync rules

- `Database/TransitOps.sql` is the only shared DB source
- After any table change: export fresh `.sql`, commit it, update `docs/05_Database_Schema_and_ERD.md`
- `Web.config` always keeps `password=YOUR_PASSWORD`. Each dev sets local password, never commits real one
- Business rules from docs (no double booking, Retired/InShop never in dispatch, license check, etc.) must be enforced in `Services/` + validators, not only in UI

## 7. Sync checklist (before every push)

- [ ] New file added to `.csproj`?
- [ ] `Database/TransitOps.sql` updated if schema changed?
- [ ] `Web.config` has no real password?
- [ ] `bin/, obj/, .vs/, packages/` not staged?
- [ ] Docs updated if folder/page added?

If fresh clone + guide in `12_Friend_Setup_Guide.md` does not run, fix docs first, not local hacks.
