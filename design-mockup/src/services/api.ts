import { store, buildVehiclesCsv, buildDriversCsv } from './mockData';

const delay = (ms = 250) => new Promise((resolve) => setTimeout(resolve, ms));

const ok = (data: any) => ({ data });
const badRequest = (error: string) => {
  const err: any = new Error(error);
  err.response = { data: { error }, status: 400 };
  return Promise.reject(err);
};
const notFound = (error: string) => {
  const err: any = new Error(error);
  err.response = { data: { error }, status: 404 };
  return Promise.reject(err);
};
const unauthorized = (error: string) => {
  const err: any = new Error(error);
  err.response = { data: { error }, status: 401 };
  return Promise.reject(err);
};

const parseUrl = (url: string) => {
  const [path, query] = url.split('?');
  const params = new URLSearchParams(query || '');
  return { path, params };
};

const respond = (fn: () => Promise<any> | any) => {
  return delay().then(() => fn());
};

const api = {
  get: (url: string) => {
    return respond(() => {
      const { path, params } = parseUrl(url);

      if (path === '/reports/kpis') return ok(store.getKpis());

      if (path === '/trips') return ok(store.getTrips());

      if (path === '/vehicles') {
        const status = params.get('status');
        const type = params.get('type');
        let list = store.getVehicles();
        if (status) list = list.filter((v) => v.status === status);
        if (type) list = list.filter((v) => v.type === type);
        return ok(list);
      }

      if (path === '/drivers') {
        const status = params.get('status');
        let list = store.getDrivers();
        if (status) list = list.filter((d) => d.status === status);
        return ok(list);
      }

      if (path === '/maintenance') return ok(store.getMaintenance());

      if (path === '/expenses') return ok(store.getExpenses());

      const costMatch = path.match(/^\/expenses\/cost\/(.+)$/);
      if (costMatch) return ok(store.getOperationalCost(decodeURIComponent(costMatch[1])));

      const analyticsMatch = path.match(/^\/reports\/analytics\/(.+)$/);
      if (analyticsMatch) {
        const reg = decodeURIComponent(analyticsMatch[1]);
        if (!store.getVehicles().some((v) => v.registrationNumber === reg)) return notFound('Vehicle not found');
        return ok(store.getVehicleAnalytics(reg));
      }

      if (path === '/notifications') {
        const limit = Number(params.get('limit') || 10);
        const list = store.getNotifications();
        const notifications = [...list].sort((a, b) => b.createdAt.getTime() - a.createdAt.getTime()).slice(0, limit);
        const unreadCount = list.filter((n) => !n.isRead).length;
        return ok({ notifications, unreadCount });
      }

      return notFound(`GET ${path} not found in mock api`);
    });
  },

  post: (url: string, data: any) => {
    return respond(() => {
      if (url === '/auth/login') {
        const email = data?.email || '';
        const user = store.getUsers().find((u) => u.email.toLowerCase() === email.toLowerCase());
        if (!user) return unauthorized('Invalid credentials');
        return ok({ token: `mock-token-${user.id}`, user });
      }

      if (url === '/auth/register') {
        if (!data?.email || !data?.name) return badRequest('Missing registration fields');
        return ok({ message: 'Account created successfully' });
      }

      if (url === '/trips') {
        if (!data?.source || !data?.destination || !data?.vehicleId || !data?.driverId) {
          return badRequest('Missing required trip fields');
        }
        return ok(store.addTrip(data));
      }

      if (url === '/vehicles') {
        if (!data?.registrationNumber || !data?.name) return badRequest('Registration number and name required');
        return ok(store.addVehicle(data));
      }

      if (url === '/drivers') {
        if (!data?.name || !data?.licenseNumber) return badRequest('Name and license number required');
        return ok(store.addDriver(data));
      }

      if (url === '/maintenance') {
        if (!data?.vehicleId || !data?.type || !data?.cost) return badRequest('Vehicle, type and cost required');
        return ok(store.addMaintenance(data));
      }

      if (url === '/expenses/fuel') {
        if (!data?.vehicleId || !data?.liters || !data?.cost) return badRequest('Vehicle, liters and cost required');
        return ok(store.addFuel(data));
      }

      if (url === '/expenses/other') {
        if (!data?.vehicleId || !data?.amount || !data?.category) return badRequest('Vehicle, amount and category required');
        return ok(store.addOtherExpense(data));
      }

      return notFound(`POST ${url} not found in mock api`);
    });
  },

  patch: (url: string, data?: any) => {
    return respond(() => {
      const dispatchMatch = url.match(/^\/trips\/(.+)\/dispatch$/);
      if (dispatchMatch) {
        const trip = store.dispatchTrip(decodeURIComponent(dispatchMatch[1]));
        if (!trip) return notFound('Trip not found');
        return ok(trip);
      }

      const completeMatch = url.match(/^\/trips\/(.+)\/complete$/);
      if (completeMatch) {
        const trip = store.completeTrip(decodeURIComponent(completeMatch[1]), data);
        if (!trip) return notFound('Trip not found');
        return ok(trip);
      }

      const cancelMatch = url.match(/^\/trips\/(.+)\/cancel$/);
      if (cancelMatch) {
        const trip = store.cancelTrip(decodeURIComponent(cancelMatch[1]));
        if (!trip) return notFound('Trip not found');
        return ok(trip);
      }

      const closeMaintenanceMatch = url.match(/^\/maintenance\/(.+)\/close$/);
      if (closeMaintenanceMatch) {
        const log = store.closeMaintenance(decodeURIComponent(closeMaintenanceMatch[1]), data);
        if (!log) return notFound('Maintenance log not found');
        return ok(log);
      }

      const readMatch = url.match(/^\/notifications\/(.+)\/read$/);
      if (readMatch) {
        store.markNotificationRead(decodeURIComponent(readMatch[1]));
        return ok({ message: 'Marked as read' });
      }

      if (url === '/notifications/read-all') {
        store.markAllNotificationsRead();
        return ok({ message: 'All notifications marked as read' });
      }

      return notFound(`PATCH ${url} not found in mock api`);
    });
  },

  delete: (url: string) => {
    return respond(() => {
      const tripMatch = url.match(/^\/trips\/(.+)$/);
      if (tripMatch) {
        store.deleteTrip(decodeURIComponent(tripMatch[1]));
        return ok({ message: 'Trip deleted' });
      }

      const vehicleMatch = url.match(/^\/vehicles\/(.+)$/);
      if (vehicleMatch) {
        store.deleteVehicle(decodeURIComponent(vehicleMatch[1]));
        return ok({ message: 'Vehicle deleted' });
      }

      const driverMatch = url.match(/^\/drivers\/(.+)$/);
      if (driverMatch) {
        store.deleteDriver(decodeURIComponent(driverMatch[1]));
        return ok({ message: 'Driver deleted' });
      }

      const maintenanceMatch = url.match(/^\/maintenance\/(.+)$/);
      if (maintenanceMatch) {
        store.deleteMaintenance(decodeURIComponent(maintenanceMatch[1]));
        return ok({ message: 'Maintenance log deleted' });
      }

      const expenseMatch = url.match(/^\/expenses\/(fuel|other)\/(.+)$/);
      if (expenseMatch) {
        store.deleteExpense(decodeURIComponent(expenseMatch[2]));
        return ok({ message: 'Expense deleted' });
      }

      return notFound(`DELETE ${url} not found in mock api`);
    });
  },
};

export const downloadCsv = (filename: string, content: string) => {
  const blob = new Blob([content], { type: 'text/csv;charset=utf-8;' });
  const url = URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.href = url;
  a.download = filename;
  document.body.appendChild(a);
  a.click();
  document.body.removeChild(a);
  URL.revokeObjectURL(url);
};

export const exportFleetCsv = () => downloadCsv('transitops-fleet.csv', buildVehiclesCsv());
export const exportDriversCsv = () => downloadCsv('transitops-drivers.csv', buildDriversCsv());

export default api;
