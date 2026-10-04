using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TransitOPS_net.SafetyOfficer
{
    public partial class Drivers : Page
    {
        [Serializable]
        public class Driver
        {
            public string FullName { get; set; }
            public string LicenseNumber { get; set; }
            public string LicenseCategory { get; set; }
            public DateTime LicenseExpiryDate { get; set; }
            public string ContactNumber { get; set; }
            public string Status { get; set; }
            public int SafetyScore { get; set; }
        }

        private List<Driver> Store
        {
            get
            {
                if (Session["Drivers"] == null)
                {
                    Session["Drivers"] = Seed();
                }
                return (List<Driver>)Session["Drivers"];
            }
            set { Session["Drivers"] = value; }
        }

        private static List<Driver> Seed()
        {
            return new List<Driver>
            {
                new Driver { FullName = "Rahul Verma", LicenseNumber = "MH-2021-44782", LicenseCategory = "Class A", LicenseExpiryDate = new DateTime(2027, 5, 24), ContactNumber = "+91-98765-11111", Status = "Available", SafetyScore = 92 },
                new Driver { FullName = "Arun Sharma", LicenseNumber = "DL-2022-11893", LicenseCategory = "Class A", LicenseExpiryDate = new DateTime(2026, 11, 15), ContactNumber = "+91-98765-22222", Status = "On Trip", SafetyScore = 88 },
                new Driver { FullName = "Priya Nair", LicenseNumber = "KA-2020-33456", LicenseCategory = "Class B", LicenseExpiryDate = new DateTime(2026, 10, 1), ContactNumber = "+91-98765-33333", Status = "Available", SafetyScore = 95 },
                new Driver { FullName = "Vikram Singh", LicenseNumber = "RJ-2023-77890", LicenseCategory = "Class A", LicenseExpiryDate = new DateTime(2026, 9, 1), ContactNumber = "+91-98765-44444", Status = "Off Duty", SafetyScore = 84 },
                new Driver { FullName = "Neha Gupta", LicenseNumber = "GJ-2021-22334", LicenseCategory = "Class B", LicenseExpiryDate = new DateTime(2026, 12, 12), ContactNumber = "+91-98765-55555", Status = "Available", SafetyScore = 90 },
                new Driver { FullName = "Rajesh Kumar", LicenseNumber = "MH-2019-55667", LicenseCategory = "Class A", LicenseExpiryDate = new DateTime(2026, 8, 20), ContactNumber = "+91-98765-66666", Status = "On Trip", SafetyScore = 78 },
                new Driver { FullName = "Sunita Rao", LicenseNumber = "TN-2022-88990", LicenseCategory = "Class B", LicenseExpiryDate = new DateTime(2027, 3, 5), ContactNumber = "+91-98765-77777", Status = "Off Duty", SafetyScore = 70 },
                new Driver { FullName = "Amit Patel", LicenseNumber = "DL-2020-11223", LicenseCategory = "Class A", LicenseExpiryDate = new DateTime(2026, 7, 30), ContactNumber = "+91-98765-88888", Status = "Suspended", SafetyScore = 65 }
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
            if (!string.IsNullOrEmpty(status))
                list = list.Where(d => d.Status == status).ToList();

            gvDrivers.DataSource = list;
            gvDrivers.DataBind();
            lblEmpty.Visible = list.Count == 0;
            lblCount.Text = "Showing " + list.Count + " drivers";

            var all = Store;
            lblTotal.Text = all.Count.ToString();
            int onTrip = all.Count(d => d.Status == "On Trip");
            lblOnTrip.Text = onTrip.ToString();
            lblOnTripPct.Text = all.Count > 0 ? Math.Round(onTrip * 100.0 / all.Count) + "%" : "0%";
            lblAvailable.Text = all.Count(d => d.Status == "Available").ToString();
            lblAvgSafety.Text = all.Count > 0 ? (all.Sum(d => d.SafetyScore) / (double)all.Count).ToString("F1") : "0";
        }

        protected void Filter_Changed(object sender, EventArgs e)
        {
            BindAll();
        }

        protected void gvDrivers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string license = e.CommandArgument.ToString();
            if (e.CommandName == "View")
            {
                var d = Store.FirstOrDefault(x => x.LicenseNumber == license);
                if (d != null)
                {
                    lblDInitials.Text = GetInitials(d.FullName);
                    lblDName.Text = d.FullName;
                    lblDCat.Text = d.LicenseCategory;
                    lblDLicense.Text = "#" + d.LicenseNumber;
                    lblDStatus.Text = d.Status;
                    lblDScore.Text = d.SafetyScore + "/100";
                    lblDExpiry.Text = d.LicenseExpiryDate.ToString("MMM d, yyyy");
                    lblDContact.Text = d.ContactNumber;
                    pnlDetails.Visible = true;
                }
            }
            else if (e.CommandName == "EditDriver")
            {
                var d = Store.FirstOrDefault(x => x.LicenseNumber == license);
                if (d != null)
                {
                    txtName.Text = d.FullName;
                    txtLicense.Text = d.LicenseNumber;
                    txtLicense.Enabled = false;
                    ddlNewCat.SelectedValue = d.LicenseCategory;
                    txtContact.Text = d.ContactNumber;
                    txtExpiry.Text = d.LicenseExpiryDate.ToString("yyyy-MM-dd");
                    ddlNewStatus.SelectedValue = d.Status;
                    txtScore.Text = d.SafetyScore.ToString();
                    ViewState["EditLicense"] = d.LicenseNumber;
                    lblFormTitle.Text = "Edit Driver";
                    btnSave.Text = "Update Driver";
                    pnlAdd.Visible = true;
                }
            }
            else if (e.CommandName == "DeleteDriver")
            {
                var list = Store;
                list.RemoveAll(x => x.LicenseNumber == license);
                Store = list;
                BindAll();
            }
        }

        protected void btnCloseDetails_Click(object sender, EventArgs e)
        {
            pnlDetails.Visible = false;
        }

        protected void btnAddDriver_Click(object sender, EventArgs e)
        {
            txtName.Text = ""; txtLicense.Text = ""; txtContact.Text = ""; txtExpiry.Text = ""; txtScore.Text = "85";
            txtLicense.Enabled = true;
            ddlNewCat.SelectedIndex = 0;
            ddlNewStatus.SelectedIndex = 0;
            ViewState["EditLicense"] = null;
            lblFormTitle.Text = "Add New Driver";
            btnSave.Text = "Save Driver";
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
            DateTime expiry;
            if (!DateTime.TryParse(txtExpiry.Text, out expiry)) return;
            int score;
            if (!int.TryParse(txtScore.Text, out score)) score = 85;
            score = Math.Max(0, Math.Min(100, score));
            string editLicense = ViewState["EditLicense"] as string;
            if (!string.IsNullOrEmpty(editLicense))
            {
                var existing = list.FirstOrDefault(x => x.LicenseNumber == editLicense);
                if (existing != null)
                {
                    existing.FullName = txtName.Text.Trim();
                    existing.LicenseCategory = ddlNewCat.SelectedValue;
                    existing.ContactNumber = txtContact.Text.Trim();
                    existing.LicenseExpiryDate = expiry;
                    existing.Status = ddlNewStatus.SelectedValue;
                    existing.SafetyScore = score;
                }
                ViewState["EditLicense"] = null;
            }
            else
            {
                if (list.Any(x => x.LicenseNumber.Equals(txtLicense.Text.Trim(), StringComparison.OrdinalIgnoreCase)))
                    return;
                list.Add(new Driver
                {
                    FullName = txtName.Text.Trim(),
                    LicenseNumber = txtLicense.Text.Trim(),
                    LicenseCategory = ddlNewCat.SelectedValue,
                    ContactNumber = txtContact.Text.Trim(),
                    LicenseExpiryDate = expiry,
                    Status = ddlNewStatus.SelectedValue,
                    SafetyScore = score
                });
            }
            Store = list;
            txtName.Text = ""; txtLicense.Text = ""; txtContact.Text = ""; txtExpiry.Text = ""; txtScore.Text = "85";
            pnlAdd.Visible = false;
            BindAll();
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            var sb = new StringBuilder();
            sb.AppendLine("FullName,LicenseNumber,Category,Contact,Expiry,Status,SafetyScore");
            foreach (var d in Store)
            {
                sb.AppendLine(string.Format("\"{0}\",\"{1}\",\"{2}\",\"{3}\",\"{4:yyyy-MM-dd}\",\"{5}\",{6}",
                    d.FullName, d.LicenseNumber, d.LicenseCategory, d.ContactNumber, d.LicenseExpiryDate, d.Status, d.SafetyScore));
            }
            Response.Clear();
            Response.ContentType = "text/csv";
            Response.AddHeader("Content-Disposition", "attachment;filename=drivers.csv");
            Response.Write(sb.ToString());
            Response.End();
        }

        protected string GetBadgeClass(object status)
        {
            string s = status.ToString();
            if (s == "On Trip") return "badge-info";
            if (s == "Available") return "badge-success";
            if (s == "Off Duty") return "badge-default";
            if (s == "Suspended") return "badge-danger";
            return "badge-success";
        }

        protected string GetInitials(object fullName)
        {
            var parts = fullName.ToString().Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
            string init = "";
            foreach (var p in parts) { if (init.Length < 2) init += char.ToUpper(p[0]); }
            return init;
        }

        protected string GetScoreColor(int score)
        {
            if (score >= 90) return "var(--accent-brand)";
            if (score >= 80) return "#92400e";
            return "#b91c1c";
        }

        protected string GetExpiryColor(DateTime expiry)
        {
            int days = (int)Math.Ceiling((expiry - DateTime.Today).TotalDays);
            if (days <= 0) return "#b91c1c";
            if (days <= 30) return "#92400e";
            return "var(--accent-brand)";
        }

        protected string GetExpiryText(DateTime expiry)
        {
            int days = (int)Math.Ceiling((expiry - DateTime.Today).TotalDays);
            if (days <= 0) return "EXPIRED";
            return days + " days left";
        }
    }
}
