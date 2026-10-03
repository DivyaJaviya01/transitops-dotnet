using System;
using System.Web.UI;

namespace TransitOPS_net.Guest
{
    public partial class Contact : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                pnlForm.Visible = true;
                pnlSuccess.Visible = false;
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                // Store inquiry in Session or process as static data
                string inquiryName = txtName.Text.Trim();
                string inquiryEmail = txtEmail.Text.Trim();
                string inquiryCompany = txtCompany.Text.Trim();
                string inquirySubject = ddlSubject.SelectedValue;
                string inquiryMessage = txtMessage.Text.Trim();

                Session["LastContactInquiry"] = $"{inquiryName} ({inquiryEmail}) - {inquirySubject}";

                pnlForm.Visible = false;
                pnlSuccess.Visible = true;
            }
        }
    }
}
