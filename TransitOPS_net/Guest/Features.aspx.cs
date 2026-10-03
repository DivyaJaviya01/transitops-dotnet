using System;
using System.Collections.Generic;
using System.Web.UI;

namespace TransitOPS_net.Guest
{
    public class ModuleItem
    {
        public string IconSvg { get; set; }
        public string ColorClass { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }
    }

    public class BusinessRuleItem
    {
        public string RuleId { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
    }

    public partial class Features : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindModules();
                BindBusinessRules();
            }
        }

        private void BindModules()
        {
            var modules = new List<ModuleItem>
            {
                new ModuleItem
                {
                    IconSvg = @"<svg width=""20"" height=""20"" viewBox=""0 0 24 24"" fill=""none"" stroke=""currentColor"" stroke-width=""2"" stroke-linecap=""round"" stroke-linejoin=""round""><rect x=""3"" y=""11"" width=""18"" height=""11"" rx=""2"" ry=""2""></rect><path d=""M7 11V7a5 5 0 0 1 10 0v4""></path></svg>",
                    ColorClass = "is-blue",
                    Title = "Authentication & Role-Based Access",
                    Description = "Secure login with ASP.NET Core Identity and five distinct roles — Admin, Fleet Manager, Dispatcher, Safety Officer, Financial Analyst. Role-based authorization policies guard every seat in ops."
                },
                new ModuleItem
                {
                    IconSvg = @"<svg width=""20"" height=""20"" viewBox=""0 0 24 24"" fill=""none"" stroke=""currentColor"" stroke-width=""2"" stroke-linecap=""round"" stroke-linejoin=""round""><rect x=""1"" y=""3"" width=""15"" height=""13""></rect><polygon points=""16 8 20 8 23 11 23 16 16 16 16 8""></polygon><circle cx=""5.5"" cy=""18.5"" r=""2.5""></circle><circle cx=""18.5"" cy=""18.5"" r=""2.5""></circle></svg>",
                    ColorClass = "is-green",
                    Title = "Vehicle Master Registry",
                    Description = "Full lifecycle tracking — registration plate, model, type, payload capacity, odometer, and acquisition cost. Live status states and a document vault for insurance, fitness certificates, and RC."
                },
                new ModuleItem
                {
                    IconSvg = @"<svg width=""20"" height=""20"" viewBox=""0 0 24 24"" fill=""none"" stroke=""currentColor"" stroke-width=""2"" stroke-linecap=""round"" stroke-linejoin=""round""><path d=""M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2""></path><circle cx=""12"" cy=""7"" r=""4""></circle></svg>",
                    ColorClass = "is-orange",
                    Title = "Driver Compliance",
                    Description = "License verification, safety scorecards, and expiry alerts 30 days ahead. Expired licenses trigger red indicators and hard dispatch locks before a driver ever leaves the yard."
                },
                new ModuleItem
                {
                    IconSvg = @"<svg width=""20"" height=""20"" viewBox=""0 0 24 24"" fill=""none"" stroke=""currentColor"" stroke-width=""2"" stroke-linecap=""round"" stroke-linejoin=""round""><polygon points=""3 11 22 2 13 21 11 13 3 11""></polygon></svg>",
                    ColorClass = "is-pink",
                    Title = "Smart Dispatch & Trip Engine",
                    Description = "Plan, dispatch, and complete trips with automated payload, availability, and license validation at every step. Dual-entity status transitions are transactional — no partial state corruption."
                },
                new ModuleItem
                {
                    IconSvg = @"<svg width=""20"" height=""20"" viewBox=""0 0 24 24"" fill=""none"" stroke=""currentColor"" stroke-width=""2"" stroke-linecap=""round"" stroke-linejoin=""round""><path d=""M14.7 6.3a1 1 0 0 0 0 1.4l1.6 1.6a1 1 0 0 0 1.4 0l3.77-3.77a6 6 0 0 1-7.94 7.94l-6.91 6.91a2.12 2.12 0 0 1-3-3l6.91-6.91a6 6 0 0 1 7.94-7.94l-3.76 3.76z""></path></svg>",
                    ColorClass = "is-blue",
                    Title = "Maintenance Hub",
                    Description = "Work orders for oil changes, brake inspections, engine overhauls, and more. Active maintenance locks a vehicle InShop and hides it from dispatch; completion restores it automatically."
                },
                new ModuleItem
                {
                    IconSvg = @"<svg width=""20"" height=""20"" viewBox=""0 0 24 24"" fill=""none"" stroke=""currentColor"" stroke-width=""2"" stroke-linecap=""round"" stroke-linejoin=""round""><rect x=""2"" y=""4"" width=""20"" height=""16"" rx=""2""></rect><line x1=""12"" y1=""8"" x2=""12"" y2=""16""></line><line x1=""8"" y1=""12"" x2=""16"" y2=""12""></line></svg>",
                    ColorClass = "is-green",
                    Title = "Cost & Expense Ledger",
                    Description = "Fuel logs, tolls, permits, parking, insurance, and routine repairs. Every expense posts against the vehicle that spent it, with automated per-vehicle operating cost calculation."
                },
                new ModuleItem
                {
                    IconSvg = @"<svg width=""20"" height=""20"" viewBox=""0 0 24 24"" fill=""none"" stroke=""currentColor"" stroke-width=""2"" stroke-linecap=""round"" stroke-linejoin=""round""><line x1=""18"" y1=""20"" x2=""18"" y2=""10""></line><line x1=""12"" y1=""20"" x2=""12"" y2=""4""></line><line x1=""6"" y1=""20"" x2=""6"" y2=""14""></line></svg>",
                    ColorClass = "is-orange",
                    Title = "Executive Analytics & Reporting",
                    Description = "Live KPI cards, fleet health donuts, safety-score distributions, and per-vehicle ROI. One-click CSV export and formatted executive PDF reports for the decisions that move the fleet."
                }
            };

            rptModules.DataSource = modules;
            rptModules.DataBind();
        }

        private void BindBusinessRules()
        {
            var rules = new List<BusinessRuleItem>
            {
                new BusinessRuleItem { RuleId = "BR-1", Name = "Unique Vehicle Registration", Description = "Every registration plate must be strictly unique across the platform." },
                new BusinessRuleItem { RuleId = "BR-2", Name = "Dispatch Vehicle Pool", Description = "Retired or InShop vehicles never appear in trip assignment dropdowns." },
                new BusinessRuleItem { RuleId = "BR-3", Name = "Driver Compliance", Description = "Drivers with expired licenses or Suspended/OffDuty status cannot be assigned." },
                new BusinessRuleItem { RuleId = "BR-4", Name = "No Double Booking", Description = "A vehicle or driver currently OnTrip cannot be assigned to another trip." },
                new BusinessRuleItem { RuleId = "BR-5", Name = "Payload Limit Validation", Description = "Cargo weight is always validated against maximum load capacity." },
                new BusinessRuleItem { RuleId = "BR-6", Name = "Automatic Dispatch Transition", Description = "Dispatching switches vehicle and driver to OnTrip and locks the start odometer." },
                new BusinessRuleItem { RuleId = "BR-7", Name = "Automatic Completion Transition", Description = "Completing restores availability, updates the odometer, and creates a fuel log." },
                new BusinessRuleItem { RuleId = "BR-8", Name = "Automatic Cancellation Reversal", Description = "Cancelling a dispatched trip instantly restores vehicle and driver availability." },
                new BusinessRuleItem { RuleId = "BR-9", Name = "Maintenance Status Lock", Description = "An active maintenance log switches the vehicle to InShop and removes it from dispatch." },
                new BusinessRuleItem { RuleId = "BR-10", Name = "Maintenance Resolution", Description = "Completing maintenance restores the vehicle to Available unless it is Retired." }
            };

            gvBusinessRules.DataSource = rules;
            gvBusinessRules.DataBind();
        }
    }
}
