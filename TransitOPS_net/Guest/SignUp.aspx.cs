using System;
using System.Web.UI;

namespace TransitOPS_net.Guest
{
    public partial class SignUp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSignUp_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;
            lblError.Visible = false;
            lblSuccess.Visible = false;

            if (string.IsNullOrWhiteSpace(txtName.Text))
            {
                lblError.Text = "Full Name is required.";
                lblError.Visible = true;
                return;
            }

            if (string.IsNullOrWhiteSpace(txtEmail.Text) || !txtEmail.Text.Contains("@"))
            {
                lblError.Text = "A valid Email is required.";
                lblError.Visible = true;
                return;
            }

            if (string.IsNullOrWhiteSpace(txtPassword.Text) || txtPassword.Text.Length < 6)
            {
                lblError.Text = "Password must be at least 6 characters.";
                lblError.Visible = true;
                return;
            }

            if (string.IsNullOrWhiteSpace(ddlRole.SelectedValue))
            {
                lblError.Text = "Please select a role.";
                lblError.Visible = true;
                return;
            }

            // Dummy success for now, redirect to login
            lblSuccess.Text = "Account created successfully! You can now sign in.";
            lblSuccess.Visible = true;
            
            // Optionally redirect after a few seconds or right away
            // Response.Redirect("~/Guest/SignIn.aspx");
        }
    }
}
