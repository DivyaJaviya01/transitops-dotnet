# TransitOps — Smart Transport Operations Platform

Web-based platform for fleet vehicles, driver compliance, trip dispatching, maintenance, fuel & expenses, and operational analytics.

## Tech Stack

- **Backend:** ASP.NET Web Forms + MasterPage, .NET Framework 4.7.2 (C#)
- **Data:** MySQL 8.x (later, via `MySql.Data` + `Data/DBHelper.cs`) — backend removed for now, UI first
- **Frontend:** Web Forms `.aspx`, Vanilla CSS/JS (`Content/site.css`, `Scripts/app.js`)
- **Auth:** Forms auth with role-based folders (later)

## Documentation

See the [documentation hub](docs/README.md) for PRD, SRS, roles & permissions, database schema, workflows, UI/UX specs, and team setup guides.

## Solution Layout

```text
TransitOPS/                      # git repo root (origin/transitops-dotnet.git)
├── TransitOPS_net/              # Visual Studio Web Forms project
│   ├── TransitOPS_net.slnx
│   ├── TransitOPS_net.csproj
│   ├── Site.Master              # header + footer for all pages
│   ├── Guest/Home.aspx          # start page (landing, matches React sample)
│   ├── Admin/ FleetManager/ Dispatcher/ SafetyOfficer/ FinancialAnalyst/
│   ├── Content/site.css         # all CSS here
│   ├── Scripts/app.js
│   ├── Data/ Services/ Helpers/ # backend later
│   └── App_Data/                # local only, never committed
├── Database/TransitOps.sql      # shared DB source (later)
├── docs/                        # PRD, SRS, rules, setup guides, figma_screens/
└── design-mockup/               # React reference only, git-ignored
```

## Getting Started

1. Open `TransitOPS_net/TransitOPS_net.slnx` in Visual Studio 2022
2. Restore NuGet, set `Guest/Home.aspx` as Start Page
3. Press F5 (IIS Express) — no database needed for UI now
4. See `docs/12_Friend_Setup_Guide.md` for full team setup
