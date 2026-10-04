using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TransitOPS_net.Guest
{
    public class PricingPlanItem
    {
        public string Name { get; set; }
        public string Description { get; set; }
        public string Price { get; set; }
        public string Period { get; set; }
        public string CtaText { get; set; }
        public string TargetUrl { get; set; }
        public bool IsFeatured { get; set; }
        public List<string> Features { get; set; }
    }

    public class PlanComparisonRow
    {
        public string Feature { get; set; }
        public string Starter { get; set; }
        public string Growth { get; set; }
        public string Enterprise { get; set; }
    }

    public class FaqItem
    {
        public string Question { get; set; }
        public string Answer { get; set; }
    }

    public partial class Pricing : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindPlans();
                BindComparison();
                BindFaqs();
            }
        }

        private void BindPlans()
        {
            var plans = new List<PricingPlanItem>
            {
                new PricingPlanItem
                {
                    Name = "Starter",
                    Description = "For small fleets getting off the spreadsheet.",
                    Price = "$49",
                    Period = "per month",
                    CtaText = "Start Free Trial",
                    TargetUrl = "~/Guest/SignUp.aspx",
                    IsFeatured = false,
                    Features = new List<string>
                    {
                        "Up to 10 vehicles",
                        "Vehicle registry & odometer tracking",
                        "Driver profiles & license expiry alerts",
                        "Up to 50 trips per month",
                        "Basic maintenance work orders",
                        "Email support"
                    }
                },
                new PricingPlanItem
                {
                    Name = "Growth",
                    Description = "For operations teams running the daily grind.",
                    Price = "$129",
                    Period = "per month",
                    CtaText = "Start Free Trial",
                    TargetUrl = "~/Guest/SignUp.aspx",
                    IsFeatured = true,
                    Features = new List<string>
                    {
                        "Up to 50 vehicles",
                        "Everything in Starter",
                        "Unlimited trips with smart dispatch",
                        "Fuel logging & expense ledger",
                        "Executive dashboard & KPI cards",
                        "Per-vehicle ROI analytics",
                        "CSV & PDF report export",
                        "Priority support"
                    }
                },
                new PricingPlanItem
                {
                    Name = "Enterprise",
                    Description = "For multi-hub fleets with custom needs.",
                    Price = "Custom",
                    Period = "talk to sales",
                    CtaText = "Talk to Sales",
                    TargetUrl = "~/Guest/Contact.aspx",
                    IsFeatured = false,
                    Features = new List<string>
                    {
                        "Unlimited vehicles & users",
                        "Everything in Growth",
                        "Role-based access control",
                        "Custom business rules",
                        "Onboarding & training",
                        "Dedicated support manager"
                    }
                }
            };

            rptPlans.DataSource = plans;
            rptPlans.DataBind();
        }

        protected void Plans_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem)
            {
                return;
            }

            var plan = e.Item.DataItem as PricingPlanItem;
            var features = e.Item.FindControl("rptFeatures") as Repeater;
            if (features != null && plan != null)
            {
                features.DataSource = plan.Features;
                features.DataBind();
            }
        }

        private void BindComparison()
        {
            var comparison = new List<PlanComparisonRow>
            {
                new PlanComparisonRow { Feature = "Vehicles", Starter = "10", Growth = "50", Enterprise = "Unlimited" },
                new PlanComparisonRow { Feature = "Smart dispatch engine", Starter = "No", Growth = "Yes", Enterprise = "Yes" },
                new PlanComparisonRow { Feature = "Maintenance work orders", Starter = "Yes", Growth = "Yes", Enterprise = "Yes" },
                new PlanComparisonRow { Feature = "Fuel & expense ledger", Starter = "No", Growth = "Yes", Enterprise = "Yes" },
                new PlanComparisonRow { Feature = "Executive dashboard & KPIs", Starter = "No", Growth = "Yes", Enterprise = "Yes" },
                new PlanComparisonRow { Feature = "Per-vehicle ROI analytics", Starter = "No", Growth = "Yes", Enterprise = "Yes" },
                new PlanComparisonRow { Feature = "CSV & PDF export", Starter = "No", Growth = "Yes", Enterprise = "Yes" },
                new PlanComparisonRow { Feature = "Role-based access (5 roles)", Starter = "No", Growth = "Yes", Enterprise = "Yes" },
                new PlanComparisonRow { Feature = "Custom business rules", Starter = "No", Growth = "No", Enterprise = "Yes" },
            };

            gvComparison.DataSource = comparison;
            gvComparison.DataBind();
        }

        private void BindFaqs()
        {
            var faqs = new List<FaqItem>
            {
                new FaqItem
                {
                    Question = "Do I need a credit card to start?",
                    Answer = "No. Every plan starts with a free 14-day trial. No credit card required and no obligation â€” set up a workspace in minutes."
                },
                new FaqItem
                {
                    Question = "Can I change plans later?",
                    Answer = "Yes. You can upgrade or downgrade at any time. Changes take effect on your next billing cycle and we never prorate retroactively."
                },
                new FaqItem
                {
                    Question = "What happens when I hit my plan limits?",
                    Answer = "We never cut you off mid-operation. You will see a friendly upgrade prompt in the app; your data stays safe and exportable at any time."
                },
                new FaqItem
                {
                    Question = "Is my fleet data exportable?",
                    Answer = "Always. One-click CSV export for every ledger, plus a formatted executive PDF report. Your data belongs to you."
                }
            };

            rptFaqs.DataSource = faqs;
            rptFaqs.DataBind();
        }
    }
}
