using System;
using System.Web.UI;

namespace TransitOPS_net.Guest
{
    /// <summary>
    /// Code-behind class for the Home guest landing page.
    /// Handles page initialization and core landing page interactions.
    /// </summary>
    public partial class Home : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Page load initialization logic
            }
        }
    }
}
