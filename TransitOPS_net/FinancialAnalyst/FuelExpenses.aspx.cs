using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TransitOPS_net.FinancialAnalyst
{
    public partial class FuelExpenses : Page
    {
        [Serializable]
        public class Expense
        {
            public int Id { get; set; }
            public string VehicleName { get; set; }
            public string VehicleReg { get; set; }
            public string Category { get; set; }
            public bool IsFuel { get; set; }
            public string Description { get; set; }
            public DateTime ExpenseDate { get; set; }
            public double Amount { get; set; }
        }

        private static readonly string[][] Fleet = new string[][]
        {
            new string[] { "Volvo FH16", "MH-12-AB-1234" },
            new string[] { "Tata Prima 5530", "MH-12-AB-5678" },
            new string[] { "BharatBenz 1214C", "KA-05-EF-1122" },
            new string[] { "Force Traveller", "TN-09-IJ-5566" },
            new string[] { "Eicher Pro 2110", "GJ-01-RT-3344" },
            new string[] { "Ashok Leyland Dost", "TN-09-XY-7788" }
        };

        private List<Expense> Store
        {
            get
            {
                if (Session["Expenses"] == null)
                {
                    Session["Expenses"] = Seed();
                }
                return (List<Expense>)Session["Expenses"];
            }
            set { Session["Expenses"] = value; }
        }

        private static List<Expense> Seed()
        {
            return new List<Expense>
            {
                new Expense { Id = 1, VehicleName = "Tata Prima 5530", VehicleReg = "MH-12-AB-5678", Category = "Fuel", IsFuel = true, Description = "Diesel fill - NH48", ExpenseDate = new DateTime(2026, 8, 8), Amount = 540 },
                new Expense { Id = 2, VehicleName = "Volvo FH16", VehicleReg = "MH-12-AB-1234", Category = "Fuel", IsFuel = true, Description = "Diesel fill - Pune depot", ExpenseDate = new DateTime(2026, 8, 10), Amount = 450 },
                new Expense { Id = 3, VehicleName = "BharatBenz 1214C", VehicleReg = "KA-05-EF-1122", Category = "Fuel", IsFuel = true, Description = "Diesel fill - EHP", ExpenseDate = new DateTime(2026, 8, 11), Amount = 390 },
                new Expense { Id = 4, VehicleName = "Force Traveller", VehicleReg = "TN-09-IJ-5566", Category = "Fuel", IsFuel = true, Description = "Fuel - city route", ExpenseDate = new DateTime(2026, 8, 12), Amount = 270 },
                new Expense { Id = 5, VehicleName = "Tata Prima 5530", VehicleReg = "MH-12-AB-5678", Category = "Fuel", IsFuel = true, Description = "Diesel fill - highway", ExpenseDate = new DateTime(2026, 8, 14), Amount = 495 },
                new Expense { Id = 6, VehicleName = "Volvo FH16", VehicleReg = "MH-12-AB-1234", Category = "Insurance", IsFuel = false, Description = "Annual insurance renewal", ExpenseDate = new DateTime(2026, 8, 7), Amount = 1200 },
                new Expense { Id = 7, VehicleName = "Eicher Pro 2110", VehicleReg = "GJ-01-RT-3344", Category = "Permit", IsFuel = false, Description = "State entry permit - MP border", ExpenseDate = new DateTime(2026, 8, 9), Amount = 180 },
                new Expense { Id = 8, VehicleName = "Ashok Leyland Dost", VehicleReg = "TN-09-XY-7788", Category = "Fuel", IsFuel = true, Description = "Diesel fill - depot", ExpenseDate = new DateTime(2026, 8, 15), Amount = 210 }
            };
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                FillVehicleLists();
                BindGrid();
                UpdateCalculator();
            }
        }

        private void FillVehicleLists()
        {
            ddlInspect.Items.Clear();
            ddlInspect.Items.Add(new ListItem("-- Select Vehicle to Inspect --", ""));
            ddlFuelVehicle.Items.Clear();
            ddlFuelVehicle.Items.Add(new ListItem("-- Choose Vehicle --", ""));
            ddlExpVehicle.Items.Clear();
            ddlExpVehicle.Items.Add(new ListItem("-- Choose Vehicle --", ""));
            foreach (var v in Fleet)
            {
                string text = v[0] + " (" + v[1] + ")";
                ddlInspect.Items.Add(new ListItem(text, v[1]));
                ddlFuelVehicle.Items.Add(new ListItem(text, v[1]));
                ddlExpVehicle.Items.Add(new ListItem(text, v[1]));
            }
        }

        private void BindGrid()
        {
            var list = Store.OrderByDescending(x => x.ExpenseDate).ToList();
            gvExpenses.DataSource = list;
            gvExpenses.DataBind();
            lblEmpty.Visible = list.Count == 0;
        }

        protected void ddlInspect_Changed(object sender, EventArgs e)
        {
            UpdateCalculator();
        }

        private void UpdateCalculator()
        {
            string reg = ddlInspect.SelectedValue;
            if (string.IsNullOrEmpty(reg))
            {
                pnlCost.Visible = false;
                return;
            }
            var rows = Store.Where(x => x.VehicleReg == reg).ToList();
            double fuel = rows.Where(x => x.IsFuel).Sum(x => x.Amount);
            double other = rows.Where(x => !x.IsFuel).Sum(x => x.Amount);
            lblFuelSum.Text = fuel.ToString("N0");
            lblExpSum.Text = other.ToString("N0");
            lblTotalCost.Text = (fuel + other).ToString("N0");
            pnlCost.Visible = true;
        }

        protected void gvExpenses_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditExpense")
            {
                int id;
                if (int.TryParse(e.CommandArgument.ToString(), out id))
                {
                    var ex = Store.FirstOrDefault(x => x.Id == id);
                    if (ex != null)
                    {
                        ddlExpVehicle.SelectedValue = ex.VehicleReg;
                        ddlExpVehicle.Enabled = false;
                        txtAmount.Text = ex.Amount.ToString("F0");
                        ddlCategory.SelectedValue = ex.Category;
                        txtDesc.Text = ex.Description == "-" ? "" : ex.Description;
                        ViewState["EditId"] = ex.Id;
                        lblExpenseTitle.Text = "Edit Expense Entry";
                        btnSaveExpense.Text = "Update Expense";
                        pnlExpense.Visible = true;
                    }
                }
            }
            else if (e.CommandName == "DeleteExpense")
            {
                int id;
                if (int.TryParse(e.CommandArgument.ToString(), out id))
                {
                    var list = Store;
                    list.RemoveAll(x => x.Id == id);
                    Store = list;
                    BindGrid();
                    UpdateCalculator();
                }
            }
        }

        protected void btnFuel_Click(object sender, EventArgs e)
        {
            pnlFuel.Visible = true;
        }

        protected void btnCloseFuel_Click(object sender, EventArgs e)
        {
            pnlFuel.Visible = false;
        }

        protected void btnSaveFuel_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;
            if (string.IsNullOrEmpty(ddlFuelVehicle.SelectedValue)) return;
            double liters, cost;
            if (!double.TryParse(txtLiters.Text, out liters)) return;
            if (!double.TryParse(txtFuelCost.Text, out cost)) return;
            var parts = ddlFuelVehicle.SelectedItem.Text.Split(new[] { " (" }, StringSplitOptions.None);
            var list = Store;
            int id = list.Count > 0 ? list.Max(x => x.Id) + 1 : 1;
            list.Add(new Expense
            {
                Id = id,
                VehicleName = parts[0],
                VehicleReg = ddlFuelVehicle.SelectedValue,
                Category = "Fuel",
                IsFuel = true,
                Description = "Diesel fill - " + liters.ToString("N0") + " L",
                ExpenseDate = DateTime.Today,
                Amount = cost
            });
            Store = list;
            txtLiters.Text = ""; txtFuelCost.Text = "";
            pnlFuel.Visible = false;
            BindGrid();
            UpdateCalculator();
        }

        protected void btnExpense_Click(object sender, EventArgs e)
        {
            ddlExpVehicle.Enabled = true;
            ddlExpVehicle.SelectedIndex = 0;
            txtAmount.Text = ""; txtDesc.Text = "";
            ddlCategory.SelectedIndex = 0;
            ViewState["EditId"] = null;
            lblExpenseTitle.Text = "Record Operational Expense";
            btnSaveExpense.Text = "Record Expense";
            pnlExpense.Visible = true;
        }

        protected void btnCloseExpense_Click(object sender, EventArgs e)
        {
            pnlExpense.Visible = false;
        }

        protected void btnSaveExpense_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;
            if (string.IsNullOrEmpty(ddlExpVehicle.SelectedValue)) return;
            double amount;
            if (!double.TryParse(txtAmount.Text, out amount)) return;
            var list = Store;
            object editId = ViewState["EditId"];
            if (editId != null)
            {
                int id;
                if (int.TryParse(editId.ToString(), out id))
                {
                    var existing = list.FirstOrDefault(x => x.Id == id);
                    if (existing != null)
                    {
                        existing.Amount = amount;
                        existing.Category = ddlCategory.SelectedValue;
                        existing.Description = string.IsNullOrWhiteSpace(txtDesc.Text) ? "-" : txtDesc.Text.Trim();
                    }
                }
                ViewState["EditId"] = null;
            }
            else
            {
                var parts = ddlExpVehicle.SelectedItem.Text.Split(new[] { " (" }, StringSplitOptions.None);
                int id = list.Count > 0 ? list.Max(x => x.Id) + 1 : 1;
                list.Add(new Expense
                {
                    Id = id,
                    VehicleName = parts[0],
                    VehicleReg = ddlExpVehicle.SelectedValue,
                    Category = ddlCategory.SelectedValue,
                    IsFuel = false,
                    Description = string.IsNullOrWhiteSpace(txtDesc.Text) ? "-" : txtDesc.Text.Trim(),
                    ExpenseDate = DateTime.Today,
                    Amount = amount
                });
            }
            Store = list;
            txtAmount.Text = ""; txtDesc.Text = "";
            pnlExpense.Visible = false;
            BindGrid();
            UpdateCalculator();
        }
    }
}
