# TransitOps - Friend Setup Guide
> Adapted from `docs/rachit/Friend-Setup-Guide.md` for `TransitOPS_net`.

## 1. Clone and open

1. `git clone <your-repo-url>`
2. Open `TransitOPS_net/TransitOPS_net.slnx` (not folder)
3. Workload: `ASP.NET and web development`, .NET Framework 4.7.2

## 2. Restore NuGet

1. Right-click Solution > Restore NuGet Packages
2. If `MySql.Data` missing: Tools > NuGet > Manage for Solution > Browse > `MySql.Data` 9.1.0 > Install
3. Build > Rebuild Solution

## 3. Fix Web.config

Open `TransitOPS_net/Web.config`, find:

```xml
<add name="TransitOpsDB" connectionString="server=localhost;user id=root;password=YOUR_PASSWORD;database=transitops;port=3306" />
```

Change only `user id` / `password` to your MySQL. Keep `database=transitops`.

## 4. Database

1. Install MySQL 8.x, create DB `transitops`
2. Import `Database/TransitOps.sql`
3. `App_Data/` stays empty (local files never committed)

## 5. Run

1. Right-click `Guest/Home.aspx` > Set As Start Page
2. Press F5 (IIS Express)

## 6. Common errors

| Error | Reason | Fix |
|-------|--------|-----|
| `Access denied / Unable to connect` | Wrong password in `Web.config` | Set your local MySQL password |
| `MySql.Data not found` | NuGet not restored | Restore / Install `MySql.Data` |
| `Site.Master not found / HTTP 500` | Opened folder not `.slnx` | Open `TransitOPS_net.slnx` |
| `Redirect / loop` | Empty Users table | SignUp first, then SignIn |
| `Invalid TargetFramework` | Missing 4.7.2 | Install .NET Framework 4.7.2 dev pack |

See also `10_Project_Structure_and_UI_Rules.md` for naming and sync rules.
