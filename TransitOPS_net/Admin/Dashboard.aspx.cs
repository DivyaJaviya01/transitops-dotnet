using System;
using System.Collections.Generic;
using System.Web.UI;

namespace TransitOPS_net.Admin
{
    public partial class Dashboard : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindRecentTrips();
            }
        }

        private void BindRecentTrips()
        {
            var trips = new List<TripRow>
            {
                new TripRow { TripCode = "TR-1042", Driver = "Ramesh Patil", Route = "Mumbai -> Pune", Status = "Dispatched", BadgeClass = "in-progress", Time = "09:42 AM" },
                new TripRow { TripCode = "TR-1043", Driver = "Suresh Yadav", Route = "Pune -> Nashik", Status = "Completed", BadgeClass = "completed", Time = "08:15 AM" },
                new TripRow { TripCode = "TR-1044", Driver = "Amit Kumar", Route = "Nashik -> Nagpur", Status = "Draft", BadgeClass = "pending", Time = "Yesterday" },
                new TripRow { TripCode = "TR-1040", Driver = "Vikram Singh", Route = "Mumbai -> Surat", Status = "Cancelled", BadgeClass = "cancelled", Time = "Yesterday" }
            };
            gvRecentTrips.DataSource = trips;
            gvRecentTrips.DataBind();
        }

        public class TripRow
        {
            public string TripCode { get; set; }
            public string Driver { get; set; }
            public string Route { get; set; }
            public string Status { get; set; }
            public string BadgeClass { get; set; }
            public string Time { get; set; }
        }
    }
}
