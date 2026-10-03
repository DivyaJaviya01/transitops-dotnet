using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;

namespace TransitOPS_net.FleetManager
{
    public partial class Maintenance : System.Web.UI.Page
    {
        public class MaintenanceLog
        {
            public string Id { get; set; }
            public string VehicleId { get; set; }
            public string VehicleName { get; set; }
            public string Type { get; set; }
            public double Cost { get; set; }
            public DateTime StartDate { get; set; }
            public DateTime EstimatedCompletionDate { get; set; }
            public string Status { get; set; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["MaintenanceLogs"] == null)
                {
                    Session["MaintenanceLogs"] = new List<MaintenanceLog>
                    {
                        new MaintenanceLog { Id = Guid.NewGuid().ToString(), VehicleId = "MH-14-XY-9081", VehicleName = "Box Truck", Type = "Routine Oil Change", Cost = 250, StartDate = DateTime.Now.AddDays(-2), EstimatedCompletionDate = DateTime.Now.AddDays(1), Status = "Active" }
                    };
                }
                BindGrid();
            }
        }

        private void BindGrid()
        {
            var logs = Session["MaintenanceLogs"] as List<MaintenanceLog>;
            if (logs == null || logs.Count == 0)
            {
                pnlEmpty.Visible = true;
                pnlTable.Visible = false;
            }
            else
            {
                pnlEmpty.Visible = false;
                pnlTable.Visible = true;
                gvLogs.DataSource = logs;
                gvLogs.DataBind();
            }
        }

        protected void btnOpenModal_Click(object sender, EventArgs e)
        {
            lblToast.Visible = false;
            lblModalError.Visible = false;
            
            ddlVehicle.SelectedIndex = 0;
            ddlType.SelectedIndex = 0;
            txtCost.Text = "";
            txtStartDate.Text = "";
            txtEstCompletion.Text = "";
            
            pnlModal.Visible = true;
        }

        protected void btnCloseModal_Click(object sender, EventArgs e)
        {
            pnlModal.Visible = false;
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(ddlVehicle.SelectedValue) || 
                string.IsNullOrWhiteSpace(txtCost.Text) || 
                string.IsNullOrWhiteSpace(txtStartDate.Text) || 
                string.IsNullOrWhiteSpace(txtEstCompletion.Text))
            {
                lblModalError.Text = "Please fill in all fields.";
                lblModalError.Visible = true;
                return;
            }

            var logs = Session["MaintenanceLogs"] as List<MaintenanceLog>;
            logs.Add(new MaintenanceLog
            {
                Id = Guid.NewGuid().ToString(),
                VehicleId = ddlVehicle.SelectedValue,
                VehicleName = ddlVehicle.SelectedItem.Text.Split('(')[0].Trim(),
                Type = ddlType.SelectedValue,
                Cost = double.Parse(txtCost.Text),
                StartDate = DateTime.Parse(txtStartDate.Text),
                EstimatedCompletionDate = DateTime.Parse(txtEstCompletion.Text),
                Status = "Active"
            });

            Session["MaintenanceLogs"] = logs;
            pnlModal.Visible = false;
            
            ShowToast("Vehicle placed in shop for maintenance successfully!", true);
            BindGrid();
        }

        protected void gvLogs_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            var logs = Session["MaintenanceLogs"] as List<MaintenanceLog>;
            string id = e.CommandArgument.ToString();
            var log = logs.FirstOrDefault(l => l.Id == id);

            if (log != null)
            {
                if (e.CommandName == "CloseLog")
                {
                    log.Status = "Closed";
                    ShowToast("Maintenance completed. Vehicle returned to Available status.", true);
                }
                else if (e.CommandName == "DeleteLog")
                {
                    logs.Remove(log);
                    ShowToast("Maintenance entry deleted.", true);
                }
                Session["MaintenanceLogs"] = logs;
                BindGrid();
            }
        }

        private void ShowToast(string message, bool isSuccess)
        {
            lblToast.Text = message;
            lblToast.Visible = true;
            if (isSuccess)
            {
                lblToast.Style["border"] = "1px solid #16a34a";
                lblToast.Style["background-color"] = "#f0fdf4";
                lblToast.Style["color"] = "#166534";
            }
            else
            {
                lblToast.Style["border"] = "1px solid #dc2626";
                lblToast.Style["background-color"] = "#fef2f2";
                lblToast.Style["color"] = "#991b1b";
            }
        }
    }
}
