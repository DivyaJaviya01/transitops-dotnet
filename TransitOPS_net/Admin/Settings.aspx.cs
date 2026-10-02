using System;

namespace TransitOPS_net.Admin
{
    public partial class Settings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadUserData();
            }
        }

        private void LoadUserData()
        {
            string username = Session["Username"] as string ?? "Divya Javiya";
            string role = Session["Role"] as string ?? "Fleet Manager";
            
            txtName.Text = username;
            txtEmail.Text = username.Replace(" ", "").ToLower() + "@transitops.com";
            lblRole.Text = role;
            chkNotifications.Checked = true;
            
            pnlSuccess.Visible = false;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                // In a real application, update database here
                
                // Show success message
                pnlSuccess.Visible = true;
                litSuccessMsg.Text = $"Preferences for {txtName.Text} saved successfully!";
                
                // Update session if name changed
                Session["Username"] = txtName.Text;
            }
        }
    }
}
