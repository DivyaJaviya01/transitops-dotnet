using System;
using System.Web.UI;

namespace TransitOPS_net.Guest
{
    public partial class SignIn : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Page load logic
            }
        }

        protected void btnSignIn_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;
            lblError.Visible = false;

            if (string.IsNullOrWhiteSpace(txtEmail.Text))
            {
                lblError.Text = "Email is required.";
                lblError.Visible = true;
                return;
            }

            if (!txtEmail.Text.Contains("@") || !txtEmail.Text.Contains("."))
            {
                lblError.Text = "Please enter a valid email address.";
                lblError.Visible = true;
                return;
            }

            if (string.IsNullOrWhiteSpace(txtPassword.Text))
            {
                lblError.Text = "Password is required.";
                lblError.Visible = true;
                return;
            }

            string email = txtEmail.Text;
            string role = ddlRole.SelectedValue;
            
            Session["UserEmail"] = email;
            Session["UserRole"] = role;
            
            if (role == "Fleet Manager")
                Response.Redirect("~/FleetManager/Vehicles.aspx");
            else if (role == "Dispatcher")
                Response.Redirect("~/Dispatcher/Trips.aspx");
            else if (role == "Safety Officer")
                Response.Redirect("~/SafetyOfficer/Drivers.aspx");
            else if (role == "Financial Analyst")
                Response.Redirect("~/FinancialAnalyst/FuelExpenses.aspx");
            else
                Response.Redirect("~/Admin/Dashboard.aspx");
        }
    }
}
