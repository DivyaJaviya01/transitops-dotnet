<%@ Page Title="Features - TransitOps" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Features.aspx.cs" Inherits="TransitOPS_net.Guest.Features" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .features-hero {
            padding: 4rem 1.5rem 3rem;
            text-align: center;
            background: linear-gradient(135deg, #0f172a, #1e293b);
            color: #ffffff;
            border-radius: 1rem;
            margin-bottom: 3rem;
        }
        .features-hero h1 {
            font-size: 2.75rem;
            font-weight: 800;
            margin-bottom: 1rem;
            background: linear-gradient(to right, #38bdf8, #818cf8);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .features-hero p {
            font-size: 1.2rem;
            color: #94a3b8;
            max-width: 40rem;
            margin: 0 auto;
        }
        .feature-detail-card {
            background: #ffffff;
            border-radius: 0.75rem;
            padding: 2rem;
            border: 1px solid #e2e8f0;
            margin-bottom: 2rem;
            transition: box-shadow 0.2s, transform 0.2s;
        }
        .feature-detail-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px -5px rgba(0, 0, 0, 0.08);
        }
        .feature-badge {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            background: #eff6ff;
            color: #2563eb;
            font-weight: 600;
            font-size: 0.85rem;
            border-radius: 1rem;
            margin-bottom: 1rem;
        }
        .feature-detail-card h3 {
            font-size: 1.5rem;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 0.75rem;
        }
        .feature-detail-card p {
            color: #64748b;
            line-height: 1.6;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container my-4">
        <section class="features-hero" id="features-hero-section">
            <h1>Powerful Tools for Modern Transit Operations</h1>
            <p>Explore the comprehensive feature suite designed to boost efficiency, lower operating costs, and ensure passenger safety.</p>
        </section>

        <section id="features-list">
            <div class="feature-detail-card">
                <span class="feature-badge">GPS & Tracking</span>
                <h3>Real-Time Telematics & GPS Tracking</h3>
                <p>Monitor your entire fleet in real-time with sub-second position updates, route playback, geofence alerts, and automated arrival notifications for passengers and dispatchers alike.</p>
            </div>

            <div class="feature-detail-card">
                <span class="feature-badge">Maintenance</span>
                <h3>Predictive Maintenance & Work Orders</h3>
                <p>Automate maintenance schedules based on odometer readings and engine hours. Instantly generate digital work orders, track spare parts inventory, and prevent costly breakdown delays.</p>
            </div>

            <div class="feature-detail-card">
                <span class="feature-badge">Analytics</span>
                <h3>Advanced Fuel & Fleet Analytics</h3>
                <p>Gain actionable insights into fuel consumption, idle time metrics, vehicle performance trends, and driver efficiency scorecards with intuitive Chart.js visualizations.</p>
            </div>

            <div class="feature-detail-card">
                <span class="feature-badge">Compliance</span>
                <h3>Driver Management & Safety Compliance</h3>
                <p>Maintain digital records of driver licenses, certifications, hours of service (HOS), and safety incident logs to comply with state and federal transportation regulations.</p>
            </div>
        </section>
    </div>
</asp:Content>
