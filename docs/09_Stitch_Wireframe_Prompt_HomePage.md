# Stitch Design Specification & Prompt: Operations Dashboard (Home Page)
## Project: TransitOps – Smart Transport Operations Platform

> **Target Tool:** Stitch UI Designer  
> **Aesthetic Theme:** Stripe-Inspired Minimal White (`#FAFAFA` Canvas + Pure White Elevated Cards + 1px Hairline Borders + Soft Pastel Status Pills)  

---

## 📋 Direct Stitch Generation Prompt (Copy & Paste into Stitch)

```text
Create a high-density, minimal white enterprise dashboard for "TransitOps" (a smart transport operations platform), designed in the style of Stripe Dashboard and Linear.

Layout Structure:
1. Left Navigation Sidebar (260px width, white surface, subtle 1px border on the right):
   - Brand Header: Dark geometric icon logo with bold title "TransitOps" and subtitle "Operations Hub".
   - Navigation Menu items with clean line icons:
     * Dashboard (Active state: subtle light-gray pill highlight with dark indicator bar)
     * Vehicle Registry
     * Driver Compliance (with a red warning pill badge: "1 Exp")
     * Trip Dispatcher
     * Maintenance Logs
     * Fuel & Expenses
     * ROI & Analytics
   - Bottom Profile Footer: Clean user avatar "MV", name "Marcus Vance", role "Fleet Manager".

2. Top Application Bar (64px height, sticky white surface):
   - Left: Page title area.
   - Right: Depot selector dropdown "🌐 All Depots & Hubs", notification bell with a red compliance alert dot, and clean action buttons.

3. Main Dashboard Body (Canvas background: #F8FAFC, ample whitespace and padding):
   - Page Header:
     * Title: "Operations Dashboard" with subtitle "Fleet telemetry, dispatch tracking, and asset utilization overview"
     * Right Action Buttons: Secondary button "[⬇ Export CSV]" and Primary black button "[+ Dispatch Trip]".
   
   - Compliance Warning Banner (Soft yellow background #FFFBEB, amber border #FDE68A):
     * Amber warning triangle icon, text: "Safety Compliance Notice: 1 Driver License Expired & 1 Expiring Soon. Robert Jackson's heavy license expired. Automated dispatch lock engaged." with an "[Audit Drivers]" button.

   - Top Metric KPI Summary (Row of 5 elevated pure white cards with soft subtle shadows):
     1. "ACTIVE FLEET": Value "28" with a green badge "▲ +4 units vs yesterday".
     2. "AVAILABLE READY": Value "14" with a green status dot "● Ready for dispatch".
     3. "IN MAINTENANCE": Value "3" with an amber badge "1 Overdue (Scania R500 In-Shop)".
     4. "FLEET UTILIZATION": Value "82.4%" with a progress ring gauge and subtitle "Target >75% (Healthy)".
     5. "DRIVERS ON DUTY": Value "32" with subtitle "100% Active shift compliance".

   - Telemetry & Visual Analytics Row (2-column layout: 2fr and 1fr):
     * Left Card (Operational Cost Breakdown): A clean bar/line chart comparing Monthly Fuel Expense, Maintenance Cost, and Tolls across Jan to Aug with time filter pills (7D, 30D, YTD).
     * Right Card (Fleet Status Distribution): A Samsara-style doughnut chart showing status breakdown: On Trip (28 - Blue), Available (14 - Green), In Shop (3 - Amber), Retired (2 - Red) with a clean legend.

   - Stripe-Style Data Table Card (Active Dispatches & Runs):
     * Table Header Toolbar: Title "Active Dispatches & Runs", search input, and filter pills: [All Trips], [On Trip], [Drafts], [Completed].
     * Clean Data Table with generous row padding (16px), subtle bottom dividers, and hover highlight:
       - Row 1: Code "#TRP-2026-0042" | Van-08 (Mercedes Sprinter) | Sarah Jenkins | Chicago → Detroit (455 km) | Cargo bar: 450kg / 650kg (69%) | Blue Pill Badge "🔵 On Trip" | Action button "[Details]".
       - Row 2: Code "#TRP-2026-0043" | Trk-12 (Volvo FH16) | David Chen | Dallas → Austin (310 km) | Cargo bar: 14,200kg / 18,000kg (79%) | Blue Pill Badge "🔵 On Trip" | Action button "[Details]".
       - Row 3: Code "#TRP-2026-0044" | Van-05 (Ford Transit) | Alex Morgan | Denver → Boulder (85 km) | Cargo bar: 380kg / 500kg (76%) | Gray Pill Badge "Draft" | Action button "[Details]".

4. Trip Details Page Link (v1 navigates to a full detail page — no slide-over drawer):
   - Page header: Trip Code "#TRP-2026-0042" + Status Badge "On Trip".
   - Quick Metric Box: Freight Revenue "$1,250.00", Odometer at Dispatch "28,400 km".
   - Manifest Details: Assigned Vehicle, Driver, Route, Distance, and Consignment specs.
   - Action buttons: "[Cancel Trip]" and Primary Black button "[Complete & Release]".

Color Palette & Visual Tokens:
- Canvas: #F8FAFC
- Card Surface: #FFFFFF
- Primary Accent & Buttons: #0F172A (Deep Charcoal / Black)
- Hairline Borders: #E2E8F0
- Available Badge: #ECFDF5 bg, #047857 text, #A7F3D0 border
- On Trip Badge: #EFF6FF bg, #1D4ED8 text, #BFDBFE border
- In Shop Badge: #FFFBEB bg, #B45309 text, #FDE68A border
- Danger / Expired Badge: #FEF2F2 bg, #B91C1C text, #FECACA border
- Font: Geometric Clean Sans (Inter / Plus Jakarta Sans) with tabular figures for numbers.
```
