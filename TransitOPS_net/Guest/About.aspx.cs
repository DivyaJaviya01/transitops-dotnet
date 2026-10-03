using System;
using System.Collections.Generic;
using System.Web.UI;

namespace TransitOPS_net.Guest
{
    public class ValueItem
    {
        public string IconSvg { get; set; }
        public string ColorClass { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
    }

    public class TeamMemberItem
    {
        public string Initials { get; set; }
        public string Name { get; set; }
        public string Role { get; set; }
        public string ColorClass { get; set; }
    }

    public class StatItem
    {
        public string Value { get; set; }
        public string Label { get; set; }
    }

    public partial class About : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindValues();
                BindStats();
                BindTeam();
            }
        }

        private void BindValues()
        {
            var values = new List<ValueItem>
            {
                new ValueItem
                {
                    IconSvg = @"<svg width=""20"" height=""20"" viewBox=""0 0 24 24"" fill=""none"" stroke=""currentColor"" stroke-width=""2"" stroke-linecap=""round"" stroke-linejoin=""round""><circle cx=""12"" cy=""12"" r=""10""></circle><circle cx=""12"" cy=""12"" r=""6""></circle><circle cx=""12"" cy=""12"" r=""2""></circle></svg>",
                    ColorClass = "is-blue",
                    Title = "Operational clarity",
                    Description = "Every vehicle, driver, and expense should answer a question instantly — not live in a spreadsheet someone else owns."
                },
                new ValueItem
                {
                    IconSvg = @"<svg width=""20"" height=""20"" viewBox=""0 0 24 24"" fill=""none"" stroke=""currentColor"" stroke-width=""2"" stroke-linecap=""round"" stroke-linejoin=""round""><path d=""M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z""></path><path d=""m9 12 2 2 4-4""></path></svg>",
                    ColorClass = "is-green",
                    Title = "Rules over memory",
                    Description = "The platform enforces the ten business rules your team should never have to remember by hand."
                },
                new ValueItem
                {
                    IconSvg = @"<svg width=""20"" height=""20"" viewBox=""0 0 24 24"" fill=""none"" stroke=""currentColor"" stroke-width=""2"" stroke-linecap=""round"" stroke-linejoin=""round""><polygon points=""13 2 3 14 12 14 11 22 21 10 12 10 13 2""></polygon></svg>",
                    ColorClass = "is-orange",
                    Title = "Calm by design",
                    Description = "A minimal, Stripe-inspired interface that stays out of the way so your team can dispatch faster and spend less."
                },
                new ValueItem
                {
                    IconSvg = @"<svg width=""20"" height=""20"" viewBox=""0 0 24 24"" fill=""none"" stroke=""currentColor"" stroke-width=""2"" stroke-linecap=""round"" stroke-linejoin=""round""><path d=""M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2""></path><circle cx=""9"" cy=""7"" r=""4""></circle><path d=""M23 21v-2a4 4 0 0 0-3-3.87""></path><path d=""M16 3.13a4 4 0 0 1 0 7.75""></path></svg>",
                    ColorClass = "is-pink",
                    Title = "Built for every seat",
                    Description = "Five roles, one workspace. Dispatchers, safety officers, analysts, and managers all see what they need."
                }
            };

            rptValues.DataSource = values;
            rptValues.DataBind();
        }

        private void BindStats()
        {
            var stats = new List<StatItem>
            {
                new StatItem { Value = "94%", Label = "Average fleet utilization across managed vehicles" },
                new StatItem { Value = "3.2k+", Label = "Trips dispatched and tracked end-to-end" },
                new StatItem { Value = "99.9%", Label = "Operational uptime for your control plane" },
                new StatItem { Value = "10", Label = "Business rules enforced without human follow-up" }
            };

            rptStats.DataSource = stats;
            rptStats.DataBind();
        }

        private void BindTeam()
        {
            var team = new List<TeamMemberItem>
            {
                new TeamMemberItem { Initials = "DJ", Name = "Divya Javiya", Role = "Product & Engineering", ColorClass = "is-blue" },
                new TeamMemberItem { Initials = "RT", Name = "Runtime Terrors", Role = "Design & Experience", ColorClass = "is-pink" },
                new TeamMemberItem { Initials = "TO", Name = "TransitOps Crew", Role = "Operations & Testing", ColorClass = "is-green" },
                new TeamMemberItem { Initials = "TS", Name = "Transit Solutions", Role = "Research & Data", ColorClass = "is-orange" }
            };

            rptTeam.DataSource = team;
            rptTeam.DataBind();
        }
    }
}
