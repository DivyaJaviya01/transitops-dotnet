<%@ Page Title="Pricing - TransitOps" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Pricing.aspx.cs" Inherits="TransitOPS_net.Guest.Pricing" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .pricing-hero {
            padding: 4rem 1.5rem 3rem;
            text-align: center;
            background: linear-gradient(135deg, #0f172a, #1e293b);
            color: #ffffff;
            border-radius: 1rem;
            margin-bottom: 3rem;
        }
        .pricing-hero h1 {
            font-size: 2.75rem;
            font-weight: 800;
            margin-bottom: 1rem;
            background: linear-gradient(to right, #38bdf8, #818cf8);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .pricing-hero p {
            font-size: 1.2rem;
            color: #94a3b8;
            max-width: 40rem;
            margin: 0 auto;
        }
        .pricing-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin: 3rem 0;
        }
        .pricing-card {
            background: #ffffff;
            border-radius: 0.75rem;
            padding: 2.5rem 2rem;
            border: 1px solid #e2e8f0;
            display: flex;
            flex-direction: column;
            position: relative;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .pricing-card.featured {
            border: 2px solid #2563eb;
            box-shadow: 0 10px 25px -5px rgba(37, 99, 235, 0.15);
        }
        .pricing-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 24px -10px rgba(0, 0, 0, 0.12);
        }
        .popular-badge {
            position: absolute;
            top: -12px;
            right: 24px;
            background: #2563eb;
            color: #ffffff;
            font-size: 0.75rem;
            font-weight: 700;
            padding: 0.25rem 0.75rem;
            border-radius: 1rem;
            text-transform: uppercase;
        }
        .plan-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 0.5rem;
        }
        .plan-price {
            font-size: 2.5rem;
            font-weight: 800;
            color: #0f172a;
            margin-bottom: 1.5rem;
        }
        .plan-price span {
            font-size: 1rem;
            font-weight: 400;
            color: #64748b;
        }
        .plan-features {
            list-style: none;
            padding: 0;
            margin: 0 0 2rem 0;
            flex-grow: 1;
        }
        .plan-features li {
            padding: 0.5rem 0;
            color: #475569;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .btn-pricing {
            width: 100%;
            text-align: center;
            padding: 0.75rem 1.5rem;
            border-radius: 0.5rem;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.2s;
        }
        .btn-pricing-primary {
            background: #2563eb;
            color: #ffffff;
        }
        .btn-pricing-primary:hover {
            background: #1d4ed8;
            color: #ffffff;
        }
        .btn-pricing-secondary {
            background: #f1f5f9;
            color: #0f172a;
        }
        .btn-pricing-secondary:hover {
            background: #e2e8f0;
            color: #0f172a;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container my-4">
        <section class="pricing-hero" id="pricing-hero-section">
            <h1>Transparent Pricing for Fleets of Any Size</h1>
            <p>Choose the right plan to power your transit operations. Simple monthly billing, no hidden fees.</p>
        </section>

        <section class="pricing-grid" id="pricing-plans">
            <!-- Starter Plan -->
            <div class="pricing-card">
                <div class="plan-title">Starter</div>
                <div class="plan-price">$49 <span>/ vehicle / mo</span></div>
                <ul class="plan-features">
                    <li>✓ Up to 10 Vehicles</li>
                    <li>✓ Real-Time GPS Telematics</li>
                    <li>✓ Basic Maintenance Alerts</li>
                    <li>✓ Email Support</li>
                </ul>
                <a href="SignUp.aspx" class="btn-pricing btn-pricing-secondary">Get Started</a>
            </div>

            <!-- Pro Plan -->
            <div class="pricing-card featured">
                <div class="popular-badge">Most Popular</div>
                <div class="plan-title">Professional</div>
                <div class="plan-price">$89 <span>/ vehicle / mo</span></div>
                <ul class="plan-features">
                    <li>✓ Up to 50 Vehicles</li>
                    <li>✓ Advanced Analytics & Charts</li>
                    <li>✓ Automated Work Orders</li>
                    <li>✓ Driver Safety Scorecards</li>
                    <li>✓ Priority 24/7 Support</li>
                </ul>
                <a href="SignUp.aspx" class="btn-pricing btn-pricing-primary">Start Free Trial</a>
            </div>

            <!-- Enterprise Plan -->
            <div class="pricing-card">
                <div class="plan-title">Enterprise</div>
                <div class="plan-price">Custom</div>
                <ul class="plan-features">
                    <li>✓ Unlimited Vehicles & Roles</li>
                    <li>✓ Dedicated Account Manager</li>
                    <li>✓ Custom API Integrations</li>
                    <li>✓ SLA & Uptime Guarantee</li>
                    <li>✓ On-Premise / Hybrid Options</li>
                </ul>
                <a href="Contact.aspx" class="btn-pricing btn-pricing-secondary">Contact Sales</a>
            </div>
        </section>
    </div>
</asp:Content>
