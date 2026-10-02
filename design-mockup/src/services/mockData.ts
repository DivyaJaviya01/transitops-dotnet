const DAY = 24 * 60 * 60 * 1000;
const daysAgo = (n: number, hour = 12) => new Date(Date.now() - n * DAY - (24 - hour) * 60 * 60 * 1000);
const daysAhead = (n: number, hour = 12) => new Date(Date.now() + n * DAY + hour * 60 * 60 * 1000);
const hoursAgo = (h: number) => new Date(Date.now() - h * 60 * 60 * 1000);

interface Vehicle {
  registrationNumber: string;
  name: string;
  type: string;
  maxLoadCapacity: number;
  odometer: number;
  acquisitionCost: number;
  status: string;
  createdAt: Date;
}

interface Driver {
  id: string;
  name: string;
  licenseNumber: string;
  licenseCategory: string;
  licenseExpiryDate: Date;
  contactNumber: string;
  status: string;
  safetyScore: number;
  createdAt: Date;
}

interface Trip {
  id: string;
  source: string;
  destination: string;
  cargoWeight: number;
  plannedDistance: number;
  actualDistance?: number;
  fuelConsumed?: number;
  status: string;
  vehicleId: string;
  driverId: string;
  vehicle: { registrationNumber: string; name: string; status: string };
  driver: { id: string; name: string; status: string };
  createdAt: Date;
  updatedAt: Date;
}

interface MaintenanceLog {
  id: string;
  type: string;
  cost: number;
  startDate: Date;
  estimatedCompletionDate: Date;
  actualCompletionDate?: Date;
  status: string;
  vehicleId: string;
  vehicle: { registrationNumber: string; name: string; status: string };
}

interface Expense {
  id: string;
  amount: number;
  date: Date;
  category: string;
  description?: string;
  vehicleId: string;
  vehicle: { registrationNumber: string; name: string };
  liters?: number;
}

interface Notification {
  id: string;
  type: 'info' | 'warning' | 'error' | 'success';
  title: string;
  message: string;
  createdAt: Date;
  isRead: boolean;
  link?: string;
}

interface User {
  id: string;
  name: string;
  email: string;
  role: string;
}

let vehicles: Vehicle[] = [
  { registrationNumber: 'MH-12-AB-1234', name: 'Volvo FH16', type: 'Truck', maxLoadCapacity: 25000, odometer: 184320, acquisitionCost: 85000, status: 'Available', createdAt: daysAgo(400) },
  { registrationNumber: 'MH-12-AB-5678', name: 'Tata Prima 5530', type: 'Truck', maxLoadCapacity: 21000, odometer: 142110, acquisitionCost: 72000, status: 'On Trip', createdAt: daysAgo(360) },
  { registrationNumber: 'DL-01-CD-9090', name: 'Ashok Leyland 3118', type: 'Truck', maxLoadCapacity: 18500, odometer: 231400, acquisitionCost: 58000, status: 'In Shop', createdAt: daysAgo(520) },
  { registrationNumber: 'KA-05-EF-1122', name: 'BharatBenz 1214C', type: 'Truck', maxLoadCapacity: 16000, odometer: 98750, acquisitionCost: 46000, status: 'Available', createdAt: daysAgo(280) },
  { registrationNumber: 'GJ-01-GH-3344', name: 'Eicher Pro 3015', type: 'Truck', maxLoadCapacity: 15000, odometer: 76500, acquisitionCost: 39000, status: 'Retired', createdAt: daysAgo(700) },
  { registrationNumber: 'TN-09-IJ-5566', name: 'Force Traveller', type: 'Van', maxLoadCapacity: 3500, odometer: 45200, acquisitionCost: 28000, status: 'Available', createdAt: daysAgo(220) },
  { registrationNumber: 'UP-32-KL-7788', name: 'Tata Winger', type: 'Van', maxLoadCapacity: 1200, odometer: 82300, acquisitionCost: 21000, status: 'On Trip', createdAt: daysAgo(300) },
  { registrationNumber: 'RJ-14-MN-9900', name: 'Toyota Hilux', type: 'Van', maxLoadCapacity: 1000, odometer: 61200, acquisitionCost: 33000, status: 'In Shop', createdAt: daysAgo(180) },
];

let drivers: Driver[] = [
  { id: 'D-001', name: 'Rahul Verma', licenseNumber: 'MH-2021-44782', licenseCategory: 'Class A', licenseExpiryDate: daysAhead(280), contactNumber: '+91-98200-12345', status: 'Available', safetyScore: 92, createdAt: daysAgo(360) },
  { id: 'D-002', name: 'Arun Sharma', licenseNumber: 'DL-2022-11893', licenseCategory: 'Class A', licenseExpiryDate: daysAhead(90), contactNumber: '+91-98111-22456', status: 'On Trip', safetyScore: 88, createdAt: daysAgo(300) },
  { id: 'D-003', name: 'Priya Nair', licenseNumber: 'KA-2020-33456', licenseCategory: 'Class B', licenseExpiryDate: daysAhead(45), contactNumber: '+91-99000-33567', status: 'Available', safetyScore: 95, createdAt: daysAgo(450) },
  { id: 'D-004', name: 'Vikram Singh', licenseNumber: 'RJ-2023-77890', licenseCategory: 'Class A', licenseExpiryDate: daysAhead(15), contactNumber: '+91-94000-44678', status: 'Off Duty', safetyScore: 84, createdAt: daysAgo(200) },
  { id: 'D-005', name: 'Manoj Kumar', licenseNumber: 'GJ-2021-55671', licenseCategory: 'Class B', licenseExpiryDate: daysAhead(320), contactNumber: '+91-99200-55789', status: 'On Trip', safetyScore: 79, createdAt: daysAgo(150) },
  { id: 'D-006', name: 'Suresh Patel', licenseNumber: 'UP-2022-11220', licenseCategory: 'Class C', licenseExpiryDate: daysAhead(200), contactNumber: '+91-97500-66890', status: 'Available', safetyScore: 73, createdAt: daysAgo(120) },
  { id: 'D-007', name: 'Deepak Yadav', licenseNumber: 'MH-2024-99081', licenseCategory: 'Class A', licenseExpiryDate: daysAhead(-10), contactNumber: '+91-98300-77901', status: 'Suspended', safetyScore: 61, createdAt: daysAgo(90) },
  { id: 'D-008', name: 'Farhan Ali', licenseNumber: 'TN-2022-66770', licenseCategory: 'Class B', licenseExpiryDate: daysAhead(150), contactNumber: '+91-98900-88012', status: 'Off Duty', safetyScore: 90, createdAt: daysAgo(260) },
];

const v = (reg: string) => vehicles.find((x) => x.registrationNumber === reg)!;
const d = (id: string) => drivers.find((x) => x.id === id)!;

const makeTrip = (t: Omit<Trip, 'vehicle' | 'driver' | 'updatedAt'>): Trip => ({
  ...t,
  vehicle: { registrationNumber: t.vehicleId, name: v(t.vehicleId).name, status: v(t.vehicleId).status },
  driver: { id: t.driverId, name: d(t.driverId).name, status: d(t.driverId).status },
  updatedAt: t.createdAt,
});

let trips: Trip[] = [
  makeTrip({ id: 'T-1001', source: 'Mumbai', destination: 'Pune', cargoWeight: 12000, plannedDistance: 150, actualDistance: 148, fuelConsumed: 55, status: 'Completed', vehicleId: 'MH-12-AB-1234', driverId: 'D-001', createdAt: daysAgo(12) }),
  makeTrip({ id: 'T-1002', source: 'Delhi', destination: 'Jaipur', cargoWeight: 18000, plannedDistance: 270, actualDistance: 265, fuelConsumed: 95, status: 'Completed', vehicleId: 'MH-12-AB-5678', driverId: 'D-002', createdAt: daysAgo(11) }),
  makeTrip({ id: 'T-1003', source: 'Bangalore', destination: 'Chennai', cargoWeight: 9000, plannedDistance: 350, actualDistance: 342, fuelConsumed: 88, status: 'Completed', vehicleId: 'KA-05-EF-1122', driverId: 'D-003', createdAt: daysAgo(9) }),
  makeTrip({ id: 'T-1004', source: 'Ahmedabad', destination: 'Surat', cargoWeight: 14000, plannedDistance: 260, actualDistance: 250, fuelConsumed: 78, status: 'Completed', vehicleId: 'GJ-01-GH-3344', driverId: 'D-005', createdAt: daysAgo(7) }),
  makeTrip({ id: 'T-1005', source: 'Mumbai', destination: 'Goa', cargoWeight: 16000, plannedDistance: 590, actualDistance: 580, fuelConsumed: 210, status: 'Completed', vehicleId: 'MH-12-AB-5678', driverId: 'D-002', createdAt: daysAgo(6) }),
  makeTrip({ id: 'T-1006', source: 'Chennai', destination: 'Coimbatore', cargoWeight: 3000, plannedDistance: 510, actualDistance: 505, fuelConsumed: 120, status: 'Completed', vehicleId: 'TN-09-IJ-5566', driverId: 'D-006', createdAt: daysAgo(4) }),
  makeTrip({ id: 'T-1007', source: 'Delhi', destination: 'Chandigarh', cargoWeight: 11000, plannedDistance: 250, status: 'Dispatched', vehicleId: 'MH-12-AB-1234', driverId: 'D-001', createdAt: daysAgo(1, 10) }),
  makeTrip({ id: 'T-1008', source: 'Mumbai', destination: 'Nagpur', cargoWeight: 15000, plannedDistance: 830, status: 'Dispatched', vehicleId: 'UP-32-KL-7788', driverId: 'D-004', createdAt: daysAgo(1, 16) }),
  makeTrip({ id: 'T-1009', source: 'Bangalore', destination: 'Hyderabad', cargoWeight: 7500, plannedDistance: 570, status: 'Dispatched', vehicleId: 'KA-05-EF-1122', driverId: 'D-003', createdAt: hoursAgo(8) }),
  makeTrip({ id: 'T-1010', source: 'Jaipur', destination: 'Udaipur', cargoWeight: 13000, plannedDistance: 410, status: 'Draft', vehicleId: 'MH-12-AB-1234', driverId: 'D-001', createdAt: hoursAgo(3) }),
  makeTrip({ id: 'T-1011', source: 'Pune', destination: 'Nashik', cargoWeight: 10000, plannedDistance: 210, status: 'Draft', vehicleId: 'TN-09-IJ-5566', driverId: 'D-006', createdAt: hoursAgo(1) }),
  makeTrip({ id: 'T-1012', source: 'Surat', destination: 'Vadodara', cargoWeight: 8000, plannedDistance: 140, status: 'Cancelled', vehicleId: 'KA-05-EF-1122', driverId: 'D-008', createdAt: daysAgo(2) }),
];

let maintenance: MaintenanceLog[] = [
  { id: 'M-201', type: 'Routine Oil Change', cost: 250, startDate: daysAgo(5), estimatedCompletionDate: daysAhead(2), status: 'Active', vehicleId: 'MH-12-AB-1234', vehicle: { registrationNumber: 'MH-12-AB-1234', name: v('MH-12-AB-1234').name, status: v('MH-12-AB-1234').status } },
  { id: 'M-202', type: 'Engine Repair', cost: 2400, startDate: daysAgo(8), estimatedCompletionDate: daysAhead(3), status: 'Active', vehicleId: 'DL-01-CD-9090', vehicle: { registrationNumber: 'DL-01-CD-9090', name: v('DL-01-CD-9090').name, status: v('DL-01-CD-9090').status } },
  { id: 'M-203', type: 'Brake Pad Service', cost: 450, startDate: daysAgo(30), estimatedCompletionDate: daysAgo(27), actualCompletionDate: daysAgo(27), status: 'Closed', vehicleId: 'MH-12-AB-5678', vehicle: { registrationNumber: 'MH-12-AB-5678', name: v('MH-12-AB-5678').name, status: v('MH-12-AB-5678').status } },
  { id: 'M-204', type: 'Tire Rotation/Replacement', cost: 380, startDate: daysAgo(1), estimatedCompletionDate: daysAhead(5), status: 'Active', vehicleId: 'RJ-14-MN-9900', vehicle: { registrationNumber: 'RJ-14-MN-9900', name: v('RJ-14-MN-9900').name, status: v('RJ-14-MN-9900').status } },
  { id: 'M-205', type: 'Body work', cost: 1200, startDate: daysAgo(60), estimatedCompletionDate: daysAgo(55), actualCompletionDate: daysAgo(55), status: 'Closed', vehicleId: 'GJ-01-GH-3344', vehicle: { registrationNumber: 'GJ-01-GH-3344', name: v('GJ-01-GH-3344').name, status: v('GJ-01-GH-3344').status } },
  { id: 'M-206', type: 'Routine Oil Change', cost: 250, startDate: daysAgo(45), estimatedCompletionDate: daysAgo(43), actualCompletionDate: daysAgo(43), status: 'Closed', vehicleId: 'MH-12-AB-1234', vehicle: { registrationNumber: 'MH-12-AB-1234', name: v('MH-12-AB-1234').name, status: v('MH-12-AB-1234').status } },
];

let expenses: Expense[] = [
  { id: 'E-301', amount: 540, date: daysAgo(8), category: 'Fuel', description: 'Diesel fill — NH48', vehicleId: 'MH-12-AB-5678', vehicle: { registrationNumber: 'MH-12-AB-5678', name: v('MH-12-AB-5678').name }, liters: 180 },
  { id: 'E-302', amount: 450, date: daysAgo(6), category: 'Fuel', description: 'Diesel fill — Pune depot', vehicleId: 'MH-12-AB-1234', vehicle: { registrationNumber: 'MH-12-AB-1234', name: v('MH-12-AB-1234').name }, liters: 150 },
  { id: 'E-303', amount: 390, date: daysAgo(5), category: 'Fuel', description: 'Diesel fill — EHP', vehicleId: 'KA-05-EF-1122', vehicle: { registrationNumber: 'KA-05-EF-1122', name: v('KA-05-EF-1122').name }, liters: 130 },
  { id: 'E-304', amount: 270, date: daysAgo(4), category: 'Fuel', description: 'Fuel — city route', vehicleId: 'TN-09-IJ-5566', vehicle: { registrationNumber: 'TN-09-IJ-5566', name: v('TN-09-IJ-5566').name }, liters: 90 },
  { id: 'E-305', amount: 495, date: daysAgo(2), category: 'Fuel', description: 'Diesel fill — highway', vehicleId: 'MH-12-AB-5678', vehicle: { registrationNumber: 'MH-12-AB-5678', name: v('MH-12-AB-5678').name }, liters: 165 },
  { id: 'E-306', amount: 1200, date: daysAgo(9), category: 'Insurance', description: 'Annual insurance renewal', vehicleId: 'MH-12-AB-1234', vehicle: { registrationNumber: 'MH-12-AB-1234', name: v('MH-12-AB-1234').name } },
  { id: 'E-307', amount: 340, date: daysAgo(7), category: 'Permit', description: 'National permit — north zone', vehicleId: 'DL-01-CD-9090', vehicle: { registrationNumber: 'DL-01-CD-9090', name: v('DL-01-CD-9090').name } },
  { id: 'E-308', amount: 1100, date: daysAgo(6), category: 'Insurance', description: 'Third-party cover', vehicleId: 'MH-12-AB-5678', vehicle: { registrationNumber: 'MH-12-AB-5678', name: v('MH-12-AB-5678').name } },
  { id: 'E-309', amount: 215, date: daysAgo(3), category: 'Other', description: 'Toll & parking charges', vehicleId: 'KA-05-EF-1122', vehicle: { registrationNumber: 'KA-05-EF-1122', name: v('KA-05-EF-1122').name } },
  { id: 'E-310', amount: 185, date: daysAgo(2), category: 'Permit', description: 'State permit — Rajasthan', vehicleId: 'RJ-14-MN-9900', vehicle: { registrationNumber: 'RJ-14-MN-9900', name: v('RJ-14-MN-9900').name } },
];

let notifications: Notification[] = [
  { id: 'N-401', type: 'info', title: 'New trip drafted', message: 'T-1011 Pune → Nashik drafted by dispatcher.', createdAt: hoursAgo(1), isRead: false, link: '/trips' },
  { id: 'N-402', type: 'warning', title: 'License expiring soon', message: 'Vikram Singh (D-004) license expires in 15 days.', createdAt: hoursAgo(3), isRead: false, link: '/drivers' },
  { id: 'N-403', type: 'success', title: 'Trip completed', message: 'T-1005 Mumbai → Goa marked as completed.', createdAt: hoursAgo(6), isRead: true, link: '/trips' },
  { id: 'N-404', type: 'warning', title: 'Vehicle in shop', message: 'Ashok Leyland 3118 is undergoing engine repair.', createdAt: hoursAgo(24), isRead: false, link: '/maintenance' },
  { id: 'N-405', type: 'info', title: 'Dispatch successful', message: 'T-1007 dispatched with Rahul Verma.', createdAt: hoursAgo(26), isRead: true, link: '/trips' },
  { id: 'N-406', type: 'error', title: 'Driver suspended', message: 'Deepak Yadav (D-007) suspended — license expired.', createdAt: hoursAgo(48), isRead: true, link: '/drivers' },
];

const users: User[] = [
  { id: 'U-001', name: 'Divya Sharma', email: 'manager@transitops.com', role: 'Fleet Manager' },
  { id: 'U-002', name: 'Rahul Khanna', email: 'safety@transitops.com', role: 'Safety Officer' },
  { id: 'U-003', name: 'Meera Iyer', email: 'finance@transitops.com', role: 'Financial Analyst' },
  { id: 'U-004', name: 'Rahul Verma', email: 'driver@transitops.com', role: 'Driver' },
];

const uid = () => `id-${Date.now()}-${Math.random().toString(36).slice(2, 7)}`;

export const store = {
  getVehicles: () => vehicles,
  addVehicle: (data: any) => {
    const vehicle: Vehicle = {
      registrationNumber: data.registrationNumber,
      name: data.name,
      type: data.type,
      maxLoadCapacity: Number(data.maxLoadCapacity) || 0,
      odometer: Number(data.odometer) || 0,
      acquisitionCost: Number(data.acquisitionCost) || 0,
      status: data.status || 'Available',
      createdAt: new Date(),
    };
    vehicles.push(vehicle);
    return vehicle;
  },
  deleteVehicle: (reg: string) => {
    vehicles = vehicles.filter((v) => v.registrationNumber !== reg);
  },

  getDrivers: () => drivers,
  addDriver: (data: any) => {
    const driver: Driver = {
      id: `D-${String(drivers.length + 1).padStart(3, '0')}`,
      name: data.name,
      licenseNumber: data.licenseNumber,
      licenseCategory: data.licenseCategory,
      licenseExpiryDate: new Date(data.licenseExpiryDate),
      contactNumber: data.contactNumber,
      status: data.status || 'Available',
      safetyScore: Number(data.safetyScore) || 85,
      createdAt: new Date(),
    };
    drivers.push(driver);
    return driver;
  },
  deleteDriver: (id: string) => {
    drivers = drivers.filter((d) => d.id !== id);
  },

  getTrips: () => trips,
  addTrip: (data: any) => {
    const trip: Trip = makeTrip({
      id: `T-${1000 + trips.length + 1}`,
      source: data.source,
      destination: data.destination,
      cargoWeight: Number(data.cargoWeight) || 0,
      plannedDistance: Number(data.plannedDistance) || 0,
      status: 'Draft',
      vehicleId: data.vehicleId,
      driverId: data.driverId,
      createdAt: new Date(),
    });
    trips.unshift(trip);
    return trip;
  },
  dispatchTrip: (id: string) => {
    const trip = trips.find((t) => t.id === id);
    if (!trip) return null;
    trip.status = 'Dispatched';
    trip.updatedAt = new Date();
    const vehicle = v(trip.vehicleId);
    vehicle.status = 'On Trip';
    const driver = d(trip.driverId);
    driver.status = 'On Trip';
    trip.vehicle = { registrationNumber: vehicle.registrationNumber, name: vehicle.name, status: vehicle.status };
    trip.driver = { id: driver.id, name: driver.name, status: driver.status };
    return trip;
  },
  completeTrip: (id: string, payload: any) => {
    const trip = trips.find((t) => t.id === id);
    if (!trip) return null;
    trip.status = 'Completed';
    trip.actualDistance = Number(payload.actualDistance) || trip.plannedDistance;
    trip.fuelConsumed = Number(payload.fuelConsumed) || 0;
    trip.updatedAt = new Date();
    const vehicle = v(trip.vehicleId);
    vehicle.status = 'Available';
    const driver = d(trip.driverId);
    driver.status = 'Available';
    trip.vehicle = { registrationNumber: vehicle.registrationNumber, name: vehicle.name, status: vehicle.status };
    trip.driver = { id: driver.id, name: driver.name, status: driver.status };
    return trip;
  },
  cancelTrip: (id: string) => {
    const trip = trips.find((t) => t.id === id);
    if (!trip) return null;
    trip.status = 'Cancelled';
    trip.updatedAt = new Date();
    const vehicle = v(trip.vehicleId);
    vehicle.status = 'Available';
    const driver = d(trip.driverId);
    driver.status = 'Available';
    return trip;
  },
  deleteTrip: (id: string) => {
    trips = trips.filter((t) => t.id !== id);
  },

  getMaintenance: () => maintenance,
  addMaintenance: (data: any) => {
    const log: MaintenanceLog = {
      id: `M-${200 + maintenance.length + 1}`,
      type: data.type,
      cost: Number(data.cost) || 0,
      startDate: new Date(data.startDate),
      estimatedCompletionDate: new Date(data.estimatedCompletionDate),
      status: 'Active',
      vehicleId: data.vehicleId,
      vehicle: { registrationNumber: data.vehicleId, name: v(data.vehicleId).name, status: v(data.vehicleId).status },
    };
    const vehicle = v(data.vehicleId);
    vehicle.status = 'In Shop';
    log.vehicle = { registrationNumber: vehicle.registrationNumber, name: vehicle.name, status: vehicle.status };
    maintenance.unshift(log);
    return log;
  },
  closeMaintenance: (id: string, payload: any) => {
    const log = maintenance.find((m) => m.id === id);
    if (!log) return null;
    log.status = 'Closed';
    log.actualCompletionDate = new Date(payload?.actualCompletionDate || Date.now());
    const vehicle = v(log.vehicleId);
    vehicle.status = 'Available';
    log.vehicle = { registrationNumber: vehicle.registrationNumber, name: vehicle.name, status: vehicle.status };
    return log;
  },
  deleteMaintenance: (id: string) => {
    maintenance = maintenance.filter((m) => m.id !== id);
  },

  getExpenses: () => expenses,
  addFuel: (data: any) => {
    const exp: Expense = {
      id: uid(),
      amount: Number(data.cost) || 0,
      date: data.date ? new Date(data.date) : new Date(),
      category: 'Fuel',
      description: data.description || 'Fuel purchase',
      vehicleId: data.vehicleId,
      vehicle: { registrationNumber: data.vehicleId, name: v(data.vehicleId).name },
      liters: Number(data.liters) || 0,
    };
    expenses.unshift(exp);
    return exp;
  },
  addOtherExpense: (data: any) => {
    const exp: Expense = {
      id: uid(),
      amount: Number(data.amount) || 0,
      date: data.date ? new Date(data.date) : new Date(),
      category: data.category || 'Other',
      description: data.description,
      vehicleId: data.vehicleId,
      vehicle: { registrationNumber: data.vehicleId, name: v(data.vehicleId).name },
    };
    expenses.unshift(exp);
    return exp;
  },
  deleteExpense: (id: string) => {
    expenses = expenses.filter((e) => e.id !== id);
  },

  getNotifications: () => notifications,
  markNotificationRead: (id: string) => {
    const n = notifications.find((x) => x.id === id);
    if (n) n.isRead = true;
  },
  markAllNotificationsRead: () => {
    notifications.forEach((n) => (n.isRead = true));
  },

  getUsers: () => users,
  getKpis: () => {
    const activeVehicles = vehicles.filter((x) => x.status === 'On Trip').length;
    const availableVehicles = vehicles.filter((x) => x.status === 'Available').length;
    const maintenanceVehicles = vehicles.filter((x) => x.status === 'In Shop').length;
    const activeTrips = trips.filter((x) => x.status === 'Dispatched').length;
    const pendingTrips = trips.filter((x) => x.status === 'Draft').length;
    const driversOnDuty = drivers.filter((x) => x.status === 'On Trip').length + drivers.filter((x) => x.status === 'Available').length;
    const fleetUtilizationPercentage = vehicles.length > 0 ? Math.round((activeVehicles / vehicles.length) * 100) : 0;
    return {
      activeVehicles,
      availableVehicles,
      maintenanceVehicles,
      activeTrips,
      pendingTrips,
      driversOnDuty,
      fleetUtilizationPercentage,
    };
  },

  getVehicleAnalytics: (reg: string) => {
    const vehicle = v(reg);
    const completed = trips.filter((t) => t.vehicleId === reg && t.status === 'Completed');
    const totalDistance = completed.reduce((s, t) => s + (t.actualDistance || 0), 0);
    const totalFuel = completed.reduce((s, t) => s + (t.fuelConsumed || 0), 0);
    const fuelEfficiencyKmPerLiter = totalFuel > 0 ? Math.round((totalDistance / totalFuel) * 10) / 10 : 5.2;
    const vehicleExpenses = expenses.filter((e) => e.vehicleId === reg);
    const totalOperationalCost = vehicleExpenses.reduce((s, e) => s + e.amount, 0);
    const ratePerKm = 2.2;
    const estimatedRevenue = Math.round(totalDistance * ratePerKm);
    const roiPercentage = totalOperationalCost > 0 ? Math.round(((estimatedRevenue - totalOperationalCost) / totalOperationalCost) * 100) : 0;
    return {
      registrationNumber: reg,
      fuelEfficiencyKmPerLiter,
      totalDistanceTraveledKm: totalDistance,
      totalOperationalCost,
      estimatedRevenue,
      roiPercentage,
    };
  },

  getOperationalCost: (reg: string) => {
    const vehicleExpenses = expenses.filter((e) => e.vehicleId === reg);
    const fuelCost = vehicleExpenses.filter((e) => e.category === 'Fuel').reduce((s, e) => s + e.amount, 0);
    const expenseCost = vehicleExpenses.filter((e) => e.category !== 'Fuel').reduce((s, e) => s + e.amount, 0);
    return {
      vehicleId: reg,
      fuelCost,
      expenseCost,
      totalOperationalCost: fuelCost + expenseCost,
    };
  },
};

export const csvEscape = (val: any) => {
  const s = val === null || val === undefined ? '' : String(val);
  return /[",\n]/.test(s) ? `"${s.replace(/"/g, '""')}"` : s;
};

export const buildVehiclesCsv = () => {
  const header = ['Registration Number', 'Name', 'Type', 'Status', 'Odometer (km)', 'Capacity (kg)', 'Acquisition Cost'];
  const rows = vehicles.map((v) => [v.registrationNumber, v.name, v.type, v.status, v.odometer, v.maxLoadCapacity, v.acquisitionCost]);
  return [header, ...rows].map((r) => r.map(csvEscape).join(',')).join('\n');
};

export const buildDriversCsv = () => {
  const header = ['ID', 'Name', 'License Number', 'License Category', 'License Expiry', 'Status', 'Safety Score', 'Contact'];
  const rows = drivers.map((d) => [d.id, d.name, d.licenseNumber, d.licenseCategory, d.licenseExpiryDate.toISOString().slice(0, 10), d.status, d.safetyScore, d.contactNumber]);
  return [header, ...rows].map((r) => r.map(csvEscape).join(',')).join('\n');
};
