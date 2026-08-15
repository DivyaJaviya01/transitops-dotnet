# TransitOps — Smart Transport Operations Platform

TransitOps is a web-based platform for managing fleet vehicles, driver compliance, trip dispatching, maintenance, fuel & expenses, and operational analytics.

## Tech Stack

- **Backend:** ASP.NET Core 10 (C#), Clean Architecture
- **Data:** Entity Framework Core, MySQL / SQLite
- **Frontend:** Razor Views (MVC), Vanilla CSS/JS, Chart.js
- **Auth:** ASP.NET Core Identity with role-based access control

## Documentation

See the [documentation hub](docs/README.md) for the PRD, SRS, roles & permissions, architecture, database schema, workflows, and UI/UX specifications.

## Solution Layout

```
TransitOps.sln
├── src/
│   ├── TransitOps.Core/          # Domain: entities, enums, interfaces, exceptions
│   ├── TransitOps.Infrastructure/ # Data: EF Core DbContext, Identity, seeding
│   ├── TransitOps.Services/      # Application: business logic & state machines
│   └── TransitOps.Web/           # Presentation: controllers, views, static assets
└── docs/                         # Project documentation
```

## Getting Started

```bash
dotnet restore
dotnet build
dotnet run --project src/TransitOps.Web
```