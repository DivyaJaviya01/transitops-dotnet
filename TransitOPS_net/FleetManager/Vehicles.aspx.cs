using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TransitOPS_net.FleetManager
{
    public partial class Vehicles : Page
    {
        [Serializable]
        public class Vehicle
        {
            public string RegistrationNumber { get; set; }
            public string Name { get; set; }
            public string Type { get; set; }
            public string Status { get; set; }
            public double OdometerKm { get; set; }
            public double MaxLoadKg { get; set; }
            public double AcquisitionCost { get; set; }
        }

        private List<Vehicle> Store
        {
            get
            {
                if (Session["Vehicles"] == null)
                {
                    Session["Vehicles"] = Seed();
                }
                return (List<Vehicle>)Session["Vehicles"];
            }
            set { Session["Vehicles"] = value; }
        }

        private static List<Vehicle> Seed()
        {
            return new List<Vehicle>
            {
                new Vehicle { RegistrationNumber = "MH-12-AB-1234", Name = "Volvo FH16", Type = "Truck", Status = "Available", OdometerKm = 184320, MaxLoadKg = 25000, AcquisitionCost = 4500000 },
                new Vehicle { RegistrationNumber = "MH-12-AB-5678", Name = "Tata Prima 5530", Type = "Truck", Status = "On Trip", OdometerKm = 142110, MaxLoadKg = 21000, AcquisitionCost = 3800000 },
                new Vehicle { RegistrationNumber = "DL-01-CD-9090", Name = "Ashok Leyland 3118", Type = "Truck", Status = "In Shop", OdometerKm = 231400, MaxLoadKg = 18500, AcquisitionCost = 2950000 },
                new Vehicle { RegistrationNumber = "KA-05-EF-1122", Name = "BharatBenz 1214C", Type = "Truck", Status = "Available", OdometerKm = 98750, MaxLoadKg = 16000, AcquisitionCost = 3200000 },
                new Vehicle { RegistrationNumber = "GJ-01-RT-3344", Name = "Eicher Pro 2110", Type = "Van", Status = "On Trip", OdometerKm = 76230, MaxLoadKg = 8000, AcquisitionCost = 1450000 },
                new Vehicle { RegistrationNumber = "MH-14-GH-5566", Name = "Force Traveller 3350", Type = "Van", Status = "In Shop", OdometerKm = 112400, MaxLoadKg = 3500, AcquisitionCost = 1200000 },
                new Vehicle { RegistrationNumber = "TN-09-XY-7788", Name = "Ashok Leyland Dost", Type = "Van", Status = "Available", OdometerKm = 65400, MaxLoadKg = 2500, AcquisitionCost = 850000 },
                new Vehicle { RegistrationNumber = "RJ-14-ZZ-9900", Name = "Tata Signa 4825", Type = "Truck", Status = "Retired", OdometerKm = 312000, MaxLoadKg = 42000, AcquisitionCost = 5100000 }
            };
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindAll();
            }
        }

        private void BindAll()
        {
            var list = Store;
            string status = ddlStatus.SelectedValue;
            string type = ddlType.SelectedValue;
            if (!string.IsNullOrEmpty(status))
                list = list.Where(v => v.Status == status).ToList();
            if (!string.IsNullOrEmpty(type))
                list = list.Where(v => v.Type == type).ToList();

            gvVehicles.DataSource = list;
            gvVehicles.DataBind();
            lblEmpty.Visible = list.Count == 0;
            lblCount.Text = "Showing " + list.Count + " vehicles";

            var all = Store;
            lblTotal.Text = all.Count.ToString();
            lblOnTrip.Text = all.Count(v => v.Status == "On Trip").ToString();
            lblInShop.Text = all.Count(v => v.Status == "In Shop").ToString();
            lblAvailable.Text = all.Count(v => v.Status == "Available").ToString();
        }

        protected void Filter_Changed(object sender, EventArgs e)
        {
            BindAll();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ddlStatus.SelectedIndex = 0;
            ddlType.SelectedIndex = 0;
            BindAll();
        }

        protected void gvVehicles_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string reg = e.CommandArgument.ToString();
            if (e.CommandName == "View")
            {
                var v = Store.FirstOrDefault(x => x.RegistrationNumber == reg);
                if (v != null)
                {
                    lblDReg.Text = v.RegistrationNumber;
                    lblDName.Text = v.Name;
                    lblDType.Text = v.Type;
                    lblDStatus.Text = v.Status;
                    lblDOdo.Text = v.OdometerKm.ToString("N0") + " km";
                    lblDLoad.Text = v.MaxLoadKg.ToString("N0") + " kg";
                    lblDCost.Text = "$" + v.AcquisitionCost.ToString("N0");
                    pnlDetails.Visible = true;
                }
            }
            else if (e.CommandName == "DeleteVehicle")
            {
                var list = Store;
                list.RemoveAll(x => x.RegistrationNumber == reg);
                Store = list;
                BindAll();
            }
        }

        protected void btnCloseDetails_Click(object sender, EventArgs e)
        {
            pnlDetails.Visible = false;
        }

        protected void btnAddVehicle_Click(object sender, EventArgs e)
        {
            pnlAdd.Visible = true;
        }

        protected void btnCloseAdd_Click(object sender, EventArgs e)
        {
            pnlAdd.Visible = false;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;
            var list = Store;
            if (list.Any(x => x.RegistrationNumber.Equals(txtReg.Text.Trim(), StringComparison.OrdinalIgnoreCase)))
                return;
            double load, odo, cost;
            double.TryParse(txtLoad.Text, out load);
            double.TryParse(txtOdo.Text, out odo);
            double.TryParse(txtCost.Text, out cost);
            list.Add(new Vehicle
            {
                RegistrationNumber = txtReg.Text.Trim(),
                Name = txtName.Text.Trim(),
                Type = ddlNewType.SelectedValue,
                Status = ddlNewStatus.SelectedValue,
                MaxLoadKg = load,
                OdometerKm = odo,
                AcquisitionCost = cost
            });
            Store = list;
            txtReg.Text = ""; txtName.Text = ""; txtLoad.Text = "0"; txtOdo.Text = "0"; txtCost.Text = "0";
            pnlAdd.Visible = false;
            BindAll();
        }

        protected string GetBadgeClass(object status)
        {
            string s = status.ToString();
            if (s == "Available") return "badge-success";
            if (s == "On Trip") return "badge-info";
            if (s == "In Shop") return "badge-warning";
            if (s == "Retired") return "badge-default";
            return "badge-success";
        }

        protected string GetTypeIcon(object type)
        {
            string t = type.ToString();
            if (t == "Van") return "<svg width=\"16\" height=\"16\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><rect x=\"2\" y=\"5\" width=\"13\" height=\"11\" rx=\"1\"/><path d=\"M15 9h4l3 3v4h-7V9z\"/><circle cx=\"6\" cy=\"18.5\" r=\"1.8\"/><circle cx=\"17\" cy=\"18.5\" r=\"1.8\"/></svg>";
            if (t == "Sedan") return "<svg width=\"16\" height=\"16\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><path d=\"M5 16l1.5-5h11L20 16\"/><rect x=\"3\" y=\"16\" width=\"18\" height=\"3\" rx=\"1\"/><circle cx=\"7.5\" cy=\"18.5\" r=\"1.5\"/><circle cx=\"16.5\" cy=\"18.5\" r=\"1.5\"/></svg>";
            return "<svg width=\"16\" height=\"16\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\"><rect x=\"1\" y=\"3\" width=\"15\" height=\"13\" rx=\"1\"/><path d=\"M16 8h4l3 3v5h-7V8z\"/><circle cx=\"5.5\" cy=\"18.5\" r=\"2.5\"/><circle cx=\"18.5\" cy=\"18.5\" r=\"2.5\"/></svg>";
        }
    }
}
