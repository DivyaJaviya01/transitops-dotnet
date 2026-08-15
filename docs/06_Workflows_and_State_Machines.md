# Workflows and State Machines Specification
## Project: TransitOps – Smart Transport Operations Platform

**Document Version:** 1.0  
**Status:** Approved Specification  

---

## 1. Core State Machines

### 1.1 Vehicle Lifecycle State Machine

```mermaid
stateDiagram-v2
    [*] --> Available: Vehicle Registered (MaxCap, Odo, RegNo)
    
    Available --> OnTrip: Trip Dispatched\n[Condition: Cargo <= MaxCap, Driver Valid]
    OnTrip --> Available: Trip Completed / Dispatched Trip Cancelled
    
    Available --> InShop: Maintenance Log Created (InProgress)
    InShop --> Available: Maintenance Log Closed (Completed)
    
    Available --> Retired: Decommissioned / Scrapped
    InShop --> Retired: Unrepairable / Write-off
    
    Retired --> [*]
```

### 1.2 Driver Operational & Compliance State Machine

```mermaid
stateDiagram-v2
    [*] --> Available: Driver Registered (Valid License)
    
    Available --> OnTrip: Assigned Trip Dispatched
    OnTrip --> Available: Trip Completed / Cancelled
    
    Available --> OffDuty: Driver Shift Ends / Leave
    OffDuty --> Available: Driver Reports On Duty
    
    Available --> Suspended: License Expired / Safety Violation
    OffDuty --> Suspended: Compliance Violation
    Suspended --> Available: License Renewed / Reinstated by Safety Officer
```

### 1.3 Trip Lifecycle State Machine

```mermaid
stateDiagram-v2
    [*] --> Draft: Create Trip (Origin, Dest, Cargo)
    
    Draft --> Dispatched: Dispatch Action\n[Validation: Veh=Available, Drv=Available, Cargo<=Cap, License Valid]
    note right of Dispatched
        Side Effects:
        - Vehicle -> OnTrip
        - Driver -> OnTrip
        - StartOdometer recorded
    end note

    Dispatched --> Completed: Complete Trip Action\n[Input: EndOdometer, FuelConsumed, FreightRevenue]
    note right of Completed
        Side Effects:
        - Vehicle -> Available
        - Driver -> Available
        - Vehicle.Odometer -> EndOdometer
        - FuelLog created
    end note

    Dispatched --> Cancelled: Cancel Dispatched Trip
    note right of Cancelled
        Side Effects:
        - Vehicle -> Available
        - Driver -> Available
    end note

    Draft --> Cancelled: Discard Draft
    Completed --> [*]
    Cancelled --> [*]
```

---

## 2. End-to-End Sequence Workflows

### 2.1 Workflow 1: End-to-End Trip Dispatch & Completion

```mermaid
sequenceDiagram
    autonumber
    actor Dispatcher
    participant Web as TripsController
    participant Service as TripService
    participant DB as DbContext
    
    Dispatcher->>Web: Create Trip (Van-05, MaxCap 500kg, Cargo 450kg, Driver Alex)
    Web->>Service: ValidateAndCreateTrip(dto)
    Service->>DB: Fetch Van-05 and Alex
    DB-->>Service: Van-05 (Status: Available), Alex (Status: Available, License: Valid)
    
    alt Cargo (450kg) > Capacity (500kg)
        Service-->>Web: Error: "Cargo exceeds vehicle load capacity"
    else Driver License Expired
        Service-->>Web: Error: "Driver license expired"
    else All Rules Passed
        Service->>DB: Begin Transaction
        Service->>DB: Insert Trip (Status: Dispatched, StartOdo: 12,500 km)
        Service->>DB: Update Van-05 (Status: OnTrip)
        Service->>DB: Update Alex (Status: OnTrip)
        Service->>DB: Commit Transaction
        Service-->>Web: Success (Trip Dispatched)
        Web-->>Dispatcher: Display Dispatched Status & Updated Fleet State
    end

    Dispatcher->>Web: Complete Trip (EndOdo: 12,850 km, Fuel: 35L @ $1.5/L)
    Web->>Service: CompleteTrip(tripId, endOdo, fuelLiters, unitPrice)
    Service->>DB: Begin Transaction
    Service->>DB: Update Trip (Status: Completed, EndOdo: 12,850 km)
    Service->>DB: Update Van-05 (Status: Available, CurrentOdometer: 12,850 km)
    Service->>DB: Update Alex (Status: Available)
    Service->>DB: Insert FuelLog (Vehicle: Van-05, Liters: 35, TotalCost: $52.50)
    Service->>DB: Commit Transaction
    Service-->>Web: Success (Trip Completed)
    Web-->>Dispatcher: Display Completed Summary & Updated Fleet State
```

---

### 2.2 Workflow 2: Preventive Maintenance & Asset Protection

```mermaid
sequenceDiagram
    autonumber
    actor FleetManager as Fleet Manager
    participant Web as MaintenanceController
    participant Service as MaintenanceService
    participant DB as DbContext
    
    FleetManager->>Web: Create Work Order (Van-05, "Oil Change & Brake Inspection", Cost $180)
    Web->>Service: ScheduleMaintenance(vehicleId, type, description, vendor, cost)
    Service->>DB: Fetch Van-05
    DB-->>Service: Van-05 (Status: Available)
    
    Service->>DB: Begin Transaction
    Service->>DB: Insert MaintenanceLog (Status: InProgress)
    Service->>DB: Update Van-05 (Status: InShop)
    Service->>DB: Commit Transaction
    Service-->>Web: Maintenance Started
    Web-->>FleetManager: Vehicle marked InShop (Removed from dispatch pool)
    
    Note over FleetManager,DB: Dispatcher attempts to assign Van-05 to new trip: Van-05 is hidden / rejected.
    
    FleetManager->>Web: Close Work Order (Mark Completed)
    Web->>Service: CompleteMaintenance(logId)
    Service->>DB: Begin Transaction
    Service->>DB: Update MaintenanceLog (Status: Completed, EndDate: Today)
    Service->>DB: Update Van-05 (Status: Available)
    Service->>DB: Commit Transaction
    Service-->>Web: Maintenance Completed
    Web-->>FleetManager: Van-05 restored to Available pool
```

---

### 2.3 Workflow 3: Driver License Expiry & Proactive Suspension

```mermaid
sequenceDiagram
    autonumber
    actor System as Scheduled Compliance Job
    participant Service as DriverService
    participant DB as DbContext
    actor SafetyOfficer as Safety Officer
    
    System->>Service: CheckLicenseExpirations()
    Service->>DB: Query Drivers WHERE LicenseExpiryDate <= Today
    DB-->>Service: List of Expired Drivers [Driver Bob]
    
    Service->>DB: Update Bob (Status: Suspended)
    Service->>DB: Log Compliance Alert
    Service-->>SafetyOfficer: Send License Expiration Notification
    
    Note over SafetyOfficer,DB: Driver Bob is blocked from all trip assignments.
    
    SafetyOfficer->>Service: Upload Renewed License (New Expiry Date: 2028-12-31)
    Service->>DB: Update Bob (LicenseExpiryDate: 2028-12-31, Status: Available)
    Service-->>SafetyOfficer: Bob Reinstated & Eligible for Trips
```
