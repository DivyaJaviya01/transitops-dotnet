<%@ Page Title="Home - TransitOps" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="TransitOPS_net.Guest.Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .landing-hero {
            position: relative;
            padding: 5rem 1.5rem 4rem;
            text-align: center;
            background: linear-gradient(135deg, rgba(15, 23, 42, 0.95), rgba(30, 41, 59, 0.98));
            color: #ffffff;
            border-radius: 1rem;
            margin-bottom: 3rem;
            overflow: hidden;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.3);
        }
        .landing-hero h1 {
            font-size: 3rem;
            font-weight: 800;
            line-height: 1.2;
            margin-bottom: 1.25rem;
            background: linear-gradient(to right, #60a5fa, #38bdf8, #818cf8);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .landing-hero p {
            font-size: 1.25rem;
            color: #94a3b8;
            max-width: 42rem;
            margin: 0 auto 2rem;
            line-height: 1.6;
        }
        .cta-group {
            display: flex;
            gap: 1rem;
            justify-content: center;
            align-items: center;
            flex-wrap: wrap;
        }
        .btn-primary-custom {
            background: linear-gradient(135deg, #2563eb, #1d4ed8);
            color: #ffffff;
            padding: 0.875rem 2rem;
            border-radius: 0.5rem;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.2s ease;
            box-shadow: 0 4px 14px rgba(37, 99, 235, 0.4);
        }
        .btn-primary-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(37, 99, 235, 0.6);
            color: #ffffff;
        }
        .btn-secondary-custom {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(8px);
            color: #f8fafc;
            padding: 0.875rem 2rem;
            border-radius: 0.5rem;
            font-weight: 600;
            text-decoration: none;
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: all 0.2s ease;
        }
        .btn-secondary-custom:hover {
            background: rgba(255, 255, 255, 0.2);
            color: #ffffff;
        }
        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 2rem;
            margin: 3rem 0;
        }
        .feature-card {
            background: #ffffff;
            padding: 2rem;
            border-radius: 0.75rem;
            border: 1px solid #e2e8f0;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .feature-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 24px -10px rgba(0, 0, 0, 0.1);
        }
        .feature-icon {
            width: 48px;
            height: 48px;
            background: #eff6ff;
            color: #2563eb;
            border-radius: 0.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            margin-bottom: 1.25rem;
        }
        .feature-card h3 {
            font-size: 1.25rem;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 0.5rem;
        }
        .feature-card p {
            color: #64748b;
            line-height: 1.5;
        }
        .stats-banner {
            background: #0f172a;
            color: #ffffff;
            border-radius: 1rem;
            padding: 3rem 2rem;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 2rem;
            text-align: center;
            margin-top: 4rem;
        }
        .stat-item .stat-number {
            font-size: 2.5rem;
            font-weight: 800;
            color: #38bdf8;
        }
        .stat-item .stat-label {
            color: #94a3b8;
            font-size: 0.875rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            margin-top: 0.5rem;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container my-4">
        <!-- Hero Section -->
        <section class="landing-hero" id="hero-section">
            <h1>Next-Gen Fleet & Transit Operations</h1>
            <p>Real-time vehicle tracking, intelligent route optimization, automated maintenance scheduling, and advanced analytics — built for modern transit teams.</p>
            <div class="cta-group">
                <a href="SignUp.aspx" class="btn-primary-custom" id="btn-get-started">Start Free Trial</a>
                <a href="Features.aspx" class="btn-secondary-custom" id="btn-explore-features">Explore Features</a>
            </div>
        </section>

        <!-- Features Overview Section -->
        <section id="features-overview" class="my-5">
            <div class="text-center mb-4">
                <h2 style="font-weight: 800; color: #0f172a;">Complete Transit & Fleet Control</h2>
                <p class="text-muted">Everything you need to run efficient, safe, and cost-effective operations.</p>
            </div>
            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">⚡</div>
                    <h3>Real-Time Fleet Tracking</h3>
                    <p>Live GPS position updates, speed monitoring, and geofence alerts for your entire vehicle roster.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">🔧</div>
                    <h3>Automated Maintenance</h3>
                    <p>Preventative maintenance schedules, work order generation, and part inventory tracking.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">📊</div>
                    <h3>Advanced Analytics</h3>
                    <p>Fuel efficiency charts, trip performance reports, and operational cost breakdowns.</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">🛡️</div>
                    <h3>Safety & Compliance</h3>
                    <p>Driver scorecards, license compliance tracking, and incident logging to maintain regulatory standards.</p>
                </div>
            </div>
        </section>

        <!-- Stats Section -->
        <section class="stats-banner" id="stats-section">
            <div class="stat-item">
                <div class="stat-number">99.9%</div>
                <div class="stat-label">Uptime Reliability</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">25%+</div>
                <div class="stat-label">Fuel Cost Savings</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">500+</div>
                <div class="stat-label">Transit Fleets Managed</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">10M+</div>
                <div class="stat-label">Miles Tracked</div>
            </div>
        </section>
    </div>
</asp:Content>
