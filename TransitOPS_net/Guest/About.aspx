<%@ Page Title="About Us - TransitOps" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="TransitOPS_net.Guest.About" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .about-hero {
            padding: 4rem 1.5rem 3rem;
            text-align: center;
            background: linear-gradient(135deg, #0f172a, #1e293b);
            color: #ffffff;
            border-radius: 1rem;
            margin-bottom: 3rem;
        }
        .about-hero h1 {
            font-size: 2.75rem;
            font-weight: 800;
            margin-bottom: 1rem;
            background: linear-gradient(to right, #38bdf8, #818cf8);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .about-hero p {
            font-size: 1.2rem;
            color: #94a3b8;
            max-width: 42rem;
            margin: 0 auto;
        }
        .story-section {
            background: #ffffff;
            border-radius: 0.75rem;
            padding: 3rem 2rem;
            border: 1px solid #e2e8f0;
            margin-bottom: 3rem;
        }
        .story-section h2 {
            font-size: 1.75rem;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 1rem;
        }
        .story-section p {
            color: #475569;
            line-height: 1.7;
            font-size: 1.05rem;
        }
        .values-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 2rem;
            margin: 2rem 0;
        }
        .value-card {
            background: #f8fafc;
            padding: 1.75rem;
            border-radius: 0.5rem;
            border-left: 4px solid #2563eb;
        }
        .value-card h4 {
            font-size: 1.15rem;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 0.5rem;
        }
        .value-card p {
            color: #64748b;
            font-size: 0.95rem;
            margin: 0;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container my-4">
        <section class="about-hero" id="about-hero-section">
            <h1>Empowering Modern Transit Ecosystems</h1>
            <p>Our mission is to streamline transit operations, enhance fleet safety, and deliver intelligent telematics to public and private transportation providers worldwide.</p>
        </section>

        <section class="story-section" id="our-story">
            <h2>Our Story</h2>
            <p>Founded by transit software engineers and logistics specialists, TransitOps was created to solve the real-world operational bottlenecks faced by fleet managers every day. From legacy manual spreadsheets to fragmented software, traditional systems fell short of real-time operational demands. TransitOps bridges this gap with an intuitive, unified platform for vehicles, drivers, maintenance, and analytics.</p>
            
            <h3 style="margin-top: 2.5rem; font-weight: 700; color: #0f172a;">Core Values</h3>
            <div class="values-grid">
                <div class="value-card">
                    <h4>Safety First</h4>
                    <p>Proactive compliance monitoring and driver scorecards ensure peak safety standards on every trip.</p>
                </div>
                <div class="value-card">
                    <h4>Operational Excellence</h4>
                    <p>Automated maintenance and intelligent routing drive down downtime and lower fuel consumption.</p>
                </div>
                <div class="value-card">
                    <h4>Data Transparency</h4>
                    <p>Real-time telematics and robust reporting empower leaders to make confident, data-driven decisions.</p>
                </div>
            </div>
        </section>
    </div>
</asp:Content>
