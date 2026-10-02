using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TransitOPS_net.Guest
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindLogos();
                BindFeatures();
                BindProductPoints();
                BindStory();
                BindStats();
            }
        }

        private void BindLogos()
        {
            var logos = new List<string>
            {
                "Meridian Freight",
                "Coastal Transit",
                "Northline Logistics",
                "Skyway Cargo",
                "Harborline",
                "BlueRoute"
            };

            rptLogos.DataSource = logos;
            rptLogos.DataBind();
        }

        private void BindFeatures()
        {
            var features = new List<FeatureItem>
            {
                new FeatureItem
                {
                    Icon = Icon.Truck,
                    Title = "Fleet Management",
                    Description = "Track every vehicle \u2014 type, load capacity, odometer, and status \u2014 from acquisition to retirement."
                },
                new FeatureItem
                {
                    Icon = Icon.UserCircle,
                    Title = "Driver Management",
                    Description = "Licenses, safety scores, and availability in one place. Expiry warnings before they become problems."
                },
                new FeatureItem
                {
                    Icon = Icon.NavigationArrow,
                    Title = "Dispatch & Trips",
                    Description = "Plan, dispatch, and complete trips with built-in capacity and license validation at every step."
                },
                new FeatureItem
                {
                    Icon = Icon.Wrench,
                    Title = "Maintenance Scheduling",
                    Description = "Open and close work orders, track repair costs, and keep vehicles out of the shop only when they must be."
                },
                new FeatureItem
                {
                    Icon = Icon.Wallet,
                    Title = "Expense Tracking",
                    Description = "Fuel logs, tolls, parking, and permits. Every dollar accounted for against the vehicle that spent it."
                },
                new FeatureItem
                {
                    Icon = Icon.ChartLineUp,
                    Title = "Reports & Analytics",
                    Description = "KPI dashboards, vehicle ROI, and one-click CSV export for the decisions that move the fleet."
                }
            };

            rptFeatures.DataSource = features;
            rptFeatures.DataBind();
        }

        private void BindProductPoints()
        {
            var points = new List<ProductPoint>
            {
                new ProductPoint { Icon = Icon.BellRinging, Title = "Role-aware alerts for the events that matter" },
                new ProductPoint { Icon = Icon.Gauge, Title = "Real-time utilization and efficiency insights" },
                new ProductPoint { Icon = Icon.ShieldCheck, Title = "Role-based access for every seat in ops" },
                new ProductPoint { Icon = Icon.ClipboardText, Title = "Active & closed maintenance with cost history" }
            };

            rptProductPoints.DataSource = points;
            rptProductPoints.DataBind();
        }

        private void BindStory()
        {
            var slides = new List<StorySlide>
            {
                new StorySlide
                {
                    Index = "01",
                    Eyebrow = "Track",
                    Title = "Every vehicle, one single view",
                    Description = "From acquisition to retirement, Fleet Management keeps type, load capacity, odometer, and status in a single source of truth your whole team can read.",
                    Image = "https://images.unsplash.com/photo-1601584115197-04ecc0da31d7?auto=format&fit=crop&w=1200&q=80",
                    Alt = "Fleet of freight trucks",
                    Flipped = false
                },
                new StorySlide
                {
                    Index = "02",
                    Eyebrow = "Dispatch",
                    Title = "Trips that book themselves safely",
                    Description = "Plan, dispatch, and complete trips with built-in capacity and licence validation at every step \u2014 an over-capacity vehicle can never leave the yard.",
                    Image = "https://images.unsplash.com/photo-1578575437130-527eed3abbec?auto=format&fit=crop&w=1200&q=80",
                    Alt = "Shipping containers at the port",
                    Flipped = true
                },
                new StorySlide
                {
                    Index = "03",
                    Eyebrow = "Maintain",
                    Title = "Downtime that finally has a price tag",
                    Description = "Open and close work orders, track repair costs against the vehicle that earned them, and keep the fleet out of the shop only when it must be.",
                    Image = "https://images.unsplash.com/photo-1586528116311-ad8dd3c8310d?auto=format&fit=crop&w=1200&q=80",
                    Alt = "Heavy equipment transport",
                    Flipped = false
                }
            };

            rptStory.DataSource = slides;
            rptStory.DataBind();
        }

        private void BindStats()
        {
            var stats = new List<StatItem>
            {
                new StatItem { Value = "94%", Label = "Average fleet utilization across managed vehicles" },
                new StatItem { Value = "3.2k+", Label = "Trips dispatched and tracked end-to-end" },
                new StatItem { Value = "99.9%", Label = "Operational uptime for your control plane" },
                new StatItem { Value = "11", Label = "Business rules enforced without human follow-up" }
            };

            rptStats.DataSource = stats;
            rptStats.DataBind();
        }

        public class FeatureItem
        {
            public string Icon { get; set; }
            public string Title { get; set; }
            public string Description { get; set; }
        }

        public class ProductPoint
        {
            public string Icon { get; set; }
            public string Title { get; set; }
        }

        public class StorySlide
        {
            public string Index { get; set; }
            public string Eyebrow { get; set; }
            public string Title { get; set; }
            public string Description { get; set; }
            public string Image { get; set; }
            public string Alt { get; set; }
            public bool Flipped { get; set; }

            public string ModifierClass
            {
                get { return Flipped ? " is-flipped" : string.Empty; }
            }
        }

        public class StatItem
        {
            public string Value { get; set; }
            public string Label { get; set; }
        }

        /// <summary>
        /// Inline SVG marks, stroke-based to match the icons already used in
        /// Site.Master and Admin.Master.
        /// </summary>
        public static class Icon
        {
            private const string Open = @"<svg width=""20"" height=""20"" viewBox=""0 0 24 24"" fill=""none"" stroke=""currentColor"" stroke-width=""1.8"" stroke-linecap=""round"" stroke-linejoin=""round"">";
            private const string OpenSmall = @"<svg width=""18"" height=""18"" viewBox=""0 0 24 24"" fill=""none"" stroke=""currentColor"" stroke-width=""1.8"" stroke-linecap=""round"" stroke-linejoin=""round"">";

            public static readonly string Truck =
                Open + @"<path d=""M1 4h14v12H1z"" /><path d=""M15 9h4l3 3v4h-7V9z"" /><circle cx=""5.5"" cy=""18.5"" r=""2.2"" /><circle cx=""17.5"" cy=""18.5"" r=""2.2"" /></svg>";

            public static readonly string UserCircle =
                Open + @"<circle cx=""12"" cy=""12"" r=""9"" /><circle cx=""12"" cy=""10"" r=""3"" /><path d=""M6.6 18.4a6 6 0 0 1 10.8 0"" /></svg>";

            public static readonly string NavigationArrow =
                Open + @"<path d=""M3.5 11.2 20.5 3l-8.2 17-2.1-7.2-6.7-1.6z"" /></svg>";

            public static readonly string Wrench =
                Open + @"<path d=""M14.7 6.3a1 1 0 0 0 0 1.4l1.6 1.6a1 1 0 0 0 1.4 0l3.8-3.8a6 6 0 0 1-7.9 7.9l-6.9 6.9a2.1 2.1 0 0 1-3-3l6.9-6.9a6 6 0 0 1 7.9-7.9l-3.8 3.8z"" /></svg>";

            public static readonly string Wallet =
                Open + @"<path d=""M3 8.5A2.5 2.5 0 0 1 5.5 6H19a2 2 0 0 1 2 2v1"" /><rect x=""3"" y=""8.5"" width=""18"" height=""11.5"" rx=""2.5"" /><circle cx=""16.5"" cy=""14.2"" r=""1.3"" /></svg>";

            public static readonly string ChartLineUp =
                Open + @"<path d=""M3.5 20.5h17"" /><path d=""M6.5 16.5l4.2-5 3.3 2.8 5.5-6.8"" /><path d=""M19.5 12.5v-5h-5"" /></svg>";

            public static readonly string BellRinging =
                OpenSmall + @"<path d=""M18 8.5a6 6 0 1 0-12 0c0 6.5-2.5 8.5-2.5 8.5h17S18 15 18 8.5"" /><path d=""M13.8 20.5a2 2 0 0 1-3.6 0"" /><path d=""M6.1 3.6A8 8 0 0 0 4 8.5"" /><path d=""M17.9 3.6A8 8 0 0 1 20 8.5"" /></svg>";

            public static readonly string Gauge =
                OpenSmall + @"<path d=""M3.6 18a9 9 0 1 1 16.8 0"" /><path d=""M12 14.2 16 9.6"" /><circle cx=""12"" cy=""14.6"" r=""1.4"" /></svg>";

            public static readonly string ShieldCheck =
                OpenSmall + @"<path d=""M12 21.5s7.5-3.7 7.5-9.5V5.4L12 2.5 4.5 5.4V12c0 5.8 7.5 9.5 7.5 9.5z"" /><path d=""M9 12l2.2 2.2L15.2 10"" /></svg>";

            public static readonly string ClipboardText =
                OpenSmall + @"<rect x=""8.5"" y=""3"" width=""7"" height=""4"" rx=""1.2"" /><path d=""M15.5 5H19a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V7a2 2 0 0 1 2-2h3.5"" /><path d=""M8 12.5h8"" /><path d=""M8 16.5h5"" /></svg>";
        }
    }
}
