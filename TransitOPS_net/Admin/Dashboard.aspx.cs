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
                new TripRow { TripCode = "TR-1042", Driver = "Ramesh Patil", Route = "Mumbai → Pune", Status = "Dispatched", PillClass = "to-pill-blue", Time = "09:42 AM" },
                new TripRow { TripCode = "TR-1043", Driver = "Suresh Yadav", Route = "Pune → Nashik", Status = "Completed", PillClass = "to-pill-green", Time = "08:15 AM" },
                new TripRow { TripCode = "TR-1044", Driver = "Amit Kumar", Route = "Nashik → Nagpur", Status = "Draft", PillClass = "to-pill-amber", Time = "Yesterday" },
                new TripRow { TripCode = "TR-1040", Driver = "Vikram Singh", Route = "Mumbai → Surat", Status = "Cancelled", PillClass = "to-pill-amber", Time = "Yesterday" }
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
            public string PillClass { get; set; }
            public string Time { get; set; }
        }
    }
}
