using System;
using System.Collections.Generic;
using System.Text;
using System.Web.UI.WebControls;

namespace TransitOPS_net.Admin
{
    public partial class Reports : System.Web.UI.Page
    {
        public class Vehicle
        {
            public string RegistrationNumber { get; set; }
            public string Name { get; set; }
            public string Type { get; set; }
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
            var vehicles = new List<Vehicle>
            {
                new Vehicle { RegistrationNumber = "MH-12-AB-4521", Name = "Sprinter Van", Type = "Cargo Van" },
                new Vehicle { RegistrationNumber = "MH-14-XY-9081", Name = "Box Truck", Type = "Heavy Duty" },
                new Vehicle { RegistrationNumber = "GJ-01-PQ-1122", Name = "Refrigerated Truck", Type = "Specialized" },
                new Vehicle { RegistrationNumber = "MH-04-LM-3344", Name = "Delivery Van", Type = "Light Duty" }
            };

            gvVehicles.DataSource = vehicles;
            gvVehicles.DataBind();

            if (vehicles.Count == 0)
            {
                pnlEmpty.Visible = true;
                pnlTable.Visible = false;
            }
        }

        protected void gvVehicles_SelectedIndexChanged(object sender, EventArgs e)
        {
            string regNumber = gvVehicles.SelectedDataKey.Value.ToString();
            lblSelectedVehicle.Text = regNumber;
            
            // Generate mock analytics based on registration number hash
            int seed = regNumber.GetHashCode();
            Random rand = new Random(seed);

            double fuelEfficiency = rand.Next(4, 15) + (rand.NextDouble());
            int distance = rand.Next(10000, 150000);
            double cost = rand.Next(5000, 30000);
            double revenue = rand.Next(20000, 90000);
            double roi = ((revenue - cost) / cost) * 100;

            lblFuel.Text = fuelEfficiency.ToString("0.0");
            lblDistance.Text = distance.ToString("n0");
            lblCost.Text = cost.ToString("n0");
            lblRevenue.Text = revenue.ToString("n0");
            
            lblROI.Text = roi.ToString("0.0");
            if (roi >= 0) {
                lblROI.ForeColor = System.Drawing.ColorTranslator.FromHtml("#10b981");
            } else {
                lblROI.ForeColor = System.Drawing.ColorTranslator.FromHtml("#b91c1c");
            }

            pnlNoSelection.Visible = false;
            pnlAnalytics.Visible = true;
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=Fleet_Report.csv");
            Response.Charset = "";
            Response.ContentType = "text/csv";

            StringBuilder sb = new StringBuilder();
            sb.AppendLine("Registration Number,Vehicle Name,Type,Status");
            sb.AppendLine("MH-12-AB-4521,Sprinter Van,Cargo Van,Active");
            sb.AppendLine("MH-14-XY-9081,Box Truck,Heavy Duty,Maintenance");
            sb.AppendLine("GJ-01-PQ-1122,Refrigerated Truck,Specialized,Active");
            sb.AppendLine("MH-04-LM-3344,Delivery Van,Light Duty,Active");

            Response.Output.Write(sb.ToString());
            Response.Flush();
            Response.End();
        }
    }
}
