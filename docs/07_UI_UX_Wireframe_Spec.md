# UI/UX Screen Specifications & Wireframe Design System
## Project: TransitOps – Smart Transport Operations Platform

**Document Version:** 1.0  
**Design Standard:** Stripe-Inspired Minimal White (Canvas `#F8FAFC`, White Cards, Hairline Borders)  
**Target Tool Compatibility:** Stitch / Figma / ASP.NET Core Razor Views  

---

## 1. Design System & Visual Tokens

### 1.1 Color Palette & Theme Tokens

```css
:root {
  /* Canvas & Card Surfaces (Stripe Benchmark) */
  --canvas-bg: #F8FAFC;
  --surface-card: #FFFFFF;
  --surface-hover: #F1F5F9;
  --surface-subtle: #F8FAFC;
  --border-default: #E2E8F0;
  --border-subtle: #EDF2F7;

  /* Typography */
  --text-heading: #0F172A;
  --text-body: #334155;
  --text-muted: #64748B;
  --text-placeholder: #94A3B8;

  /* Buttons */
  --btn-primary-bg: #0F172A;
  --btn-primary-hover: #1E293B;
  --btn-primary-text: #FFFFFF;
  --btn-secondary-bg: #FFFFFF;
  --btn-secondary-border: #CBD5E1;
  --btn-secondary-text: #0F172A;

  /* Status Colors */
  --status-available-bg: #ECFDF5;
  --status-available-text: #047857;
  --status-available-border: #A7F3D0;

  --status-ontrip-bg: #EFF6FF;
  --status-ontrip-text: #1D4ED8;
  --status-ontrip-border: #BFDBFE;

  --status-inshop-bg: #FFFBEB;
  --status-inshop-text: #B45309;
  --status-inshop-border: #FDE68A;

  --status-danger-bg: #FEF2F2;
  --status-danger-text: #B91C1C;
  --status-danger-border: #FECACA;

  /* Shadows */
  --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
  --shadow-card: 0 1px 3px 0 rgba(0, 0, 0, 0.04), 0 1px 2px -1px rgba(0, 0, 0, 0.02);
  --shadow-modal: 0 20px 25px -5px rgba(0, 0, 0, 0.08), 0 8px 10px -6px rgba(0, 0, 0, 0.03);

  /* Typography */
  --font-family: 'Plus Jakarta Sans', 'Inter', system-ui, -apple-system, sans-serif;
  --radius-sm: 6px;
  --radius-md: 10px;
  --radius-lg: 14px;
  --radius-full: 9999px;
}
```

---

## 2. Global Navigation & Layout Wireframe

```
+----------------------------------------------------------------------------------------------------+
|  [LOGO] TransitOps   | Search [Filter: All Hubs v] | [Dark/Light] | [User Avatar v]  |
+----------------------------------------------------------------------------------------------------+
| SIDEBAR              | MAIN CONTENT AREA                                                          |
|                      |                                                                            |
| [o] Dashboard        | [ Top KPI Cards: Active Fleet | In Shop | Trips | Utilization Rate (%) ]   |
| [o] Vehicles Master  |                                                                            |
| [o] Driver Directory | [ Telemetry Chart: Monthly Costs ] [ Status Donut: Fleet Health ]          |
| [o] Trip Dispatcher  |                                                                            |
| [o] Maintenance Log  | [ Dispatches Table: TRP-01 | Van-05 | Alex | 450kg | Dispatched ]     |
| [o] Fuel & Expenses  |                                                                            |
| [o] ROI Analytics    | [ Compliance Alert Banner: 2 Driver Licenses Expiring in < 30 Days ]       |
| [o] Export Reports   |                                                                            |
+----------------------------------------------------------------------------------------------------+
```

---

## 3. Detailed Screen Specifications (For Stitch Wireframing)

### Screen 1: Executive Operations Dashboard (`/Dashboard`)
- **Header**: Greeting, Time Range Selector (Today, 7D, 30D, YTD), Quick Dispatch Button (`+ New Trip`), Hub/Region Dropdown.
- **KPI Summary Grid (6 Cards)**:
  1. **Active Vehicles**: Count with `+X% vs last week` badge.
  2. **Available Fleet**: Count of ready units.
  3. **In Maintenance**: Orange pill count with quick link to workshop orders.
  4. **Active Trips**: Dispatched transport runs currently en-route.
  5. **Drivers On Duty**: Active licensed drivers.
  6. **Fleet Utilization Rate (%)**: Gauge / progress ring (Target: $>75\%$).
- **Charts Row**:
  - Left: Line/Bar chart: Operational Cost Trend (Fuel vs. Maintenance vs. Tolls).
  - Right: Donut Chart: Fleet Distribution by Status (`Available`, `OnTrip`, `InShop`, `Retired`).
- **Dispatches Feed**: Table showing the top 5 active trips with cargo progress bars.

---

### Screen 2: Vehicle Master Registry (`/Vehicles`)
- **Header**: Search by Plate/Model, Filter by Type (`Truck`, `Van`, `Bus`, `Trailer`), Filter by Status, `+ Register Vehicle` Button.
- **Vehicle Grid / Table View**:
  - Columns: Registration Plate, Vehicle Model & Type, Max Payload Capacity (kg), Current Odometer (km), Acquisition Cost, Status Badge, Region Hub, Actions (`View`, `Edit`, `Service`, `Retire`).
- **Register / Edit Vehicle Modal**:
  - Inputs: Registration Plate (unique validator), Model Name, Vehicle Type dropdown, Max Load Capacity (kg), Initial Odometer, Acquisition Cost, Region Hub, Document Attachment upload.

---

### Screen 3: Driver Directory & Compliance Center (`/Drivers`)
- **Header**: Search Driver Name/License, Filter by License Category, Status Filter, Expiry Alert Counter (`2 Expiring Soon`), `+ Register Driver` Button.
- **Driver Table**:
  - Columns: Avatar & Full Name, License Number, Category (`Heavy`, `Medium`, `Light`), License Expiry Date (Color-coded: Red if expired, Yellow if $\le 30$ days, Green if valid), Safety Score (0–100 progress badge), Status, Actions (`View`, `Edit`, `Suspend`, `Upload License`).

---

### Screen 4: Trip Dispatch & Lifecycle Hub (`/Trips`)
- **Tabs**: `All Trips`, `Active (Dispatched)`, `Drafts`, `Completed`, `Cancelled`.
- **`+ Create New Trip` Modal / Form**:
  - Input 1: Origin / Source Depot.
  - Input 2: Delivery Destination.
  - Input 3: Cargo Description & Cargo Weight (kg).
  - Input 4: Vehicle Selector (Dropdown filters dynamically to show **only** `Available` vehicles. If Cargo Weight $>$ Selected Vehicle Max Capacity, real-time warning and submit button is disabled).
  - Input 5: Driver Selector (Dropdown filters dynamically to show **only** `Available` drivers with valid licenses).
  - Input 6: Planned Distance (km) & Freight Revenue ($/₹).
  - Actions: `Save as Draft`, `Dispatch Immediately`.
- **Complete Trip Modal**:
  - Input: Final Odometer (km) [Validated $\ge$ Start Odometer].
  - Input: Fuel Consumed (Liters) & Fuel Price per Liter.
  - Input: Tolls / Incidental Expenses.
  - Action: `Confirm Delivery & Release Fleet`.

---

### Screen 5: Maintenance & Service Logs (`/Maintenance`)
- **Header**: Total In-Shop Count, Total Maintenance Spend (MTD), `+ Log Maintenance` Button.
- **Maintenance Table**:
  - Columns: Work Order #, Vehicle Plate & Model, Service Type (`Oil Change`, `Brake Inspection`, `Engine Overhaul`, `Tire Replacement`), Service Vendor, Start Date, Completed Date, Cost ($), Status (`InProgress`, `Completed`), Actions.
- **Initiate Maintenance Modal**:
  - Select Vehicle (Dropdown of `Available` vehicles).
  - Service Type & Description.
  - Vendor & Estimated Cost.
  - *Notice: Submitting will immediately switch vehicle to `InShop`.*

---

### Screen 6: Fuel & Operating Expense Ledger (`/Expenses`)
- **Metric Cards**: Total Fuel Cost (MTD), Total Maintenance Cost (MTD), Total Tolls & Permits (MTD), Cost-Per-KM ($/km).
- **Log Fuel / Expense Form**:
  - Vehicle dropdown, Linked Trip (optional), Expense Type, Amount, Liters (if fuel), Odometer, Receipt Upload.
- **Expense Ledger Table**: Filterable by Date Range, Vehicle, and Expense Type.

---

### Screen 7: Executive Reports & Vehicle ROI Analytics (`/Reports`)
- **Financial Analytics Panel**:
  - Per-Vehicle ROI table:
    - Vehicle Plate, Model, Acquisition Cost, Freight Revenue Generated, Fuel Cost, Maintenance Cost, Net Profit, **ROI (%)**.
  - Fuel Efficiency Matrix: Distance Traveled vs. Fuel Consumed (km/L) per vehicle class.
- **Export Toolbar**:
  - `[Export to CSV]` button.
  - `[Generate Executive PDF Report]` button.

---

## 4. Key Interactive States & Error Messages

| State / Trigger | UI Behavior / Visual Feedback |
|---|---|
| Cargo $>$ Vehicle Max Capacity | Input border turns red; helper text displays *"Cargo exceeds Van-05 capacity (450kg > 500kg)"*; `Dispatch` button disabled. |
| Expired Driver License | Driver dropdown row displays red badge *"Expired 2026-08-01"*; selection is disabled. |
| Vehicle `InShop` or `Retired` | Excluded automatically from trip dispatch dropdowns. |
| Trip Dispatched successfully | Toast notification *"Trip TRP-2026-001 Dispatched. Van-05 & Alex are now On Trip."* |
| Maintenance Work Order Closed | Toast notification *"Maintenance completed. Van-05 restored to Available."* |
| Dark / Light Mode Switch | Instant transition of all tokens, background surfaces, clean white cards, and Chart.js color schemes. |
