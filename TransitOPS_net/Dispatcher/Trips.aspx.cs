using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TransitOPS_net.Dispatcher
{
    public partial class Trips : Page
    {
        [Serializable]
        public class Trip
        {
            public string TripCode { get; set; }
            public string Source { get; set; }
            public string Destination { get; set; }
            public double CargoWeightKg { get; set; }
            public double PlannedKm { get; set; }
            public double ActualKm { get; set; }
            public string VehicleName { get; set; }
            public string VehicleReg { get; set; }
            public string DriverName { get; set; }
            public string Status { get; set; }
        }

        private List<Trip> Store
        {
            get
            {
                if (Session["Trips"] == null)
                {
                    Session["Trips"] = Seed();
                }
                return (List<Trip>)Session["Trips"];
            }
            set { Session["Trips"] = value; }
        }

        private static List<Trip> Seed()
        {
            return new List<Trip>
            {
                new Trip { TripCode = "TR-1042", Source = "Mumbai", Destination = "Pune", CargoWeightKg = 12000, PlannedKm = 148, ActualKm = 148, VehicleName = "Volvo FH16", VehicleReg = "MH-12-AB-1234", DriverName = "Rahul Verma", Status = "Completed" },
                new Trip { TripCode = "TR-1043", Source = "Delhi", Destination = "Jaipur", CargoWeightKg = 18000, PlannedKm = 265, ActualKm = 265, VehicleName = "Tata Prima 5530", VehicleReg = "MH-12-AB-5678", DriverName = "Arun Sharma", Status = "Completed" },
                new Trip { TripCode = "TR-1044", Source = "Bangalore", Destination = "Chennai", CargoWeightKg = 9000, PlannedKm = 342, ActualKm = 342, VehicleName = "BharatBenz 1214C", VehicleReg = "KA-05-EF-1122", DriverName = "Priya Nair", Status = "Completed" },
                new Trip { TripCode = "TR-1045", Source = "Ahmedabad", Destination = "Surat", CargoWeightKg = 14000, PlannedKm = 250, ActualKm = 250, VehicleName = "Eicher Pro 3015", VehicleReg = "GJ-01-GH-3344", DriverName = "Manoj Kumar", Status = "Completed" },
                new Trip { TripCode = "TR-1046", Source = "Mumbai", Destination = "Goa", CargoWeightKg = 16000, PlannedKm = 580, ActualKm = 580, VehicleName = "Tata Prima 5530", VehicleReg = "MH-12-AB-5678", DriverName = "Arun Sharma", Status = "Completed" },
                new Trip { TripCode = "TR-1047", Source = "Chennai", Destination = "Coimbatore", CargoWeightKg = 3000, PlannedKm = 505, ActualKm = 505, VehicleName = "Force Traveller", VehicleReg = "TN-09-IJ-5566", DriverName = "Suresh Patel", Status = "Completed" },
                new Trip { TripCode = "TR-1048", Source = "Delhi", Destination = "Chandigarh", CargoWeightKg = 11000, PlannedKm = 250, ActualKm = 0, VehicleName = "Volvo FH16", VehicleReg = "MH-12-AB-1234", DriverName = "Rahul Verma", Status = "Dispatched" },
                new Trip { TripCode = "TR-1049", Source = "Mumbai", Destination = "Nagpur", CargoWeightKg = 15000, PlannedKm = 830, ActualKm = 0, VehicleName = "Tata Winger", VehicleReg = "UP-32-KL-7788", DriverName = "Vikram Singh", Status = "Dispatched" },
                new Trip { TripCode = "TR-1050", Source = "Pune", Destination = "Nashik", CargoWeightKg = 7000, PlannedKm = 210, ActualKm = 0, VehicleName = "Eicher Pro 2110", VehicleReg = "GJ-01-RT-3344", DriverName = "Neha Gupta", Status = "Draft" }
            };
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        private void BindGrid()
        {
            var list = Store;
            gvTrips.DataSource = list;
            gvTrips.DataBind();
            lblEmpty.Visible = list.Count == 0;
        }

        protected void gvTrips_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string code = e.CommandArgument.ToString();
            var list = Store;
            var t = list.FirstOrDefault(x => x.TripCode == code);
            if (t == null) return;
            if (e.CommandName == "Dispatch" && t.Status == "Draft")
            {
                t.Status = "Dispatched";
            }
            else if (e.CommandName == "OpenComplete" && t.Status == "Dispatched")
            {
                hfTrip.Value = code;
                txtActualKm.Text = t.PlannedKm.ToString();
                txtFuel.Text = "";
                pnlComplete.Visible = true;
                return;
            }
            else if (e.CommandName == "CancelTrip" && (t.Status == "Draft" || t.Status == "Dispatched"))
            {
                t.Status = "Cancelled";
            }
            else if (e.CommandName == "DeleteTrip" && t.Status == "Draft")
            {
                list.Remove(t);
            }
            Store = list;
            BindGrid();
        }

        protected void btnNewTrip_Click(object sender, EventArgs e)
        {
            ddlVehicle.Items.Clear();
            ddlVehicle.Items.Add(new ListItem("-- Choose Vehicle --", ""));
            ddlVehicle.Items.Add(new ListItem("Volvo FH16 (MH-12-AB-1234)", "Volvo FH16|MH-12-AB-1234"));
            ddlVehicle.Items.Add(new ListItem("Tata Prima 5530 (MH-12-AB-5678)", "Tata Prima 5530|MH-12-AB-5678"));
            ddlVehicle.Items.Add(new ListItem("BharatBenz 1214C (KA-05-EF-1122)", "BharatBenz 1214C|KA-05-EF-1122"));
            ddlVehicle.Items.Add(new ListItem("Eicher Pro 2110 (GJ-01-RT-3344)", "Eicher Pro 2110|GJ-01-RT-3344"));
            ddlDriver.Items.Clear();
            ddlDriver.Items.Add(new ListItem("-- Choose Driver --", ""));
            ddlDriver.Items.Add(new ListItem("Rahul Verma", "Rahul Verma"));
            ddlDriver.Items.Add(new ListItem("Arun Sharma", "Arun Sharma"));
            ddlDriver.Items.Add(new ListItem("Priya Nair", "Priya Nair"));
            ddlDriver.Items.Add(new ListItem("Neha Gupta", "Neha Gupta"));
            pnlNew.Visible = true;
        }

        protected void btnCloseNew_Click(object sender, EventArgs e)
        {
            pnlNew.Visible = false;
        }

        protected void btnCreate_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;
            if (string.IsNullOrEmpty(ddlVehicle.SelectedValue) || string.IsNullOrEmpty(ddlDriver.SelectedValue)) return;
            double cargo, dist;
            if (!double.TryParse(txtCargo.Text, out cargo) || cargo <= 0) return;
            if (!double.TryParse(txtDist.Text, out dist) || dist <= 0) return;
            var parts = ddlVehicle.SelectedValue.Split('|');
            var list = Store;
            int n = 1051 + list.Count;
            list.Add(new Trip
            {
                TripCode = "TR-" + n,
                Source = txtSource.Text.Trim(),
                Destination = txtDest.Text.Trim(),
                CargoWeightKg = cargo,
                PlannedKm = dist,
                ActualKm = 0,
                VehicleName = parts[0],
                VehicleReg = parts[1],
                DriverName = ddlDriver.SelectedValue,
                Status = "Draft"
            });
            Store = list;
            txtSource.Text = ""; txtDest.Text = ""; txtCargo.Text = ""; txtDist.Text = "";
            pnlNew.Visible = false;
            BindGrid();
        }

        protected void btnCloseComplete_Click(object sender, EventArgs e)
        {
            pnlComplete.Visible = false;
        }

        protected void btnDoComplete_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;
            double km, fuel;
            if (!double.TryParse(txtActualKm.Text, out km)) return;
            if (!double.TryParse(txtFuel.Text, out fuel)) return;
            var list = Store;
            var t = list.FirstOrDefault(x => x.TripCode == hfTrip.Value);
            if (t != null && t.Status == "Dispatched")
            {
                t.ActualKm = km;
                t.Status = "Completed";
                Store = list;
            }
            pnlComplete.Visible = false;
            BindGrid();
        }

        protected string GetBadgeClass(object status)
        {
            string s = status.ToString();
            if (s == "Completed") return "badge-success";
            if (s == "Dispatched") return "badge-info";
            if (s == "Cancelled") return "badge-danger";
            return "badge-default";
        }

        protected string GetDistanceText(object status, object actual, object planned)
        {
            double a = Convert.ToDouble(actual);
            double p = Convert.ToDouble(planned);
            if (status.ToString() == "Completed")
                return a.ToString("N0") + " km (actual)";
            return p.ToString("N0") + " km (planned)";
        }
    }
}
