<%@ Page Title="Analytics" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Analytics.aspx.cs" Inherits="TransitOPS_net.Admin.Analytics" %>

<asp:Content ID="c1" ContentPlaceHolderID="TitleContent" runat="server">Fleet Analytics - TransitOps Admin</asp:Content>

<asp:Content ID="c2" ContentPlaceHolderID="head" runat="server">
    <style>
        .kpi-card { background: #fff; padding: 1.5rem; border-radius: 12px; border: 1px solid var(--border-color); border-left-width: 4px; box-shadow: 0 1px 3px rgba(0,0,0,0.02); }
        .kpi-card h3 { font-size: 0.85rem; text-transform: uppercase; letter-spacing: 0.05em; color: var(--text-secondary); margin-bottom: 0.5rem; }
        .kpi-value { font-size: 2rem; font-weight: 800; font-family: 'Geist', sans-serif; letter-spacing: -0.02em; }
        .graph-card { background: #fff; padding: 1.5rem; border-radius: 12px; border: 1px solid var(--border-color); box-shadow: 0 1px 3px rgba(0,0,0,0.02); margin-bottom: 1.5rem; }
        .graph-header h3 { display: flex; align-items: center; gap: 0.5rem; font-family: 'Geist', sans-serif; font-size: 1.1rem; color: var(--text-primary); margin-bottom: 1.5rem; }
    </style>
    <script src="../Scripts/chart.umd.min.js"></script>
</asp:Content>

<asp:Content ID="c3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content-wrapper">
        <div class="page-header">
            <div>
                <h1>Fleet Analytics</h1>
                <p>Deep dive into fleet performance and distribution metrics.</p>
            </div>
        </div>

        <div style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 1.5rem; margin-bottom: 1.5rem;">
            <div class="kpi-card" style="border-left-color: #2d6a4f;">
                <h3>Total Fleet</h3>
                <p class="kpi-value" style="color: #2d6a4f;"><asp:Literal ID="litTotalFleet" runat="server"></asp:Literal></p>
            </div>
            <div class="kpi-card" style="border-left-color: #10b981;">
                <h3>Active Trips</h3>
                <p class="kpi-value" style="color: #10b981;"><asp:Literal ID="litActiveTrips" runat="server"></asp:Literal></p>
            </div>
            <div class="kpi-card" style="border-left-color: #f59e0b;">
                <h3>Fleet Utilization</h3>
                <p class="kpi-value" style="color: #f59e0b;"><asp:Literal ID="litUtilization" runat="server"></asp:Literal>%</p>
            </div>
            <div class="kpi-card" style="border-left-color: #8b5cf6;">
                <h3>Drivers On Duty</h3>
                <p class="kpi-value" style="color: #8b5cf6;"><asp:Literal ID="litDrivers" runat="server"></asp:Literal></p>
            </div>
        </div>

        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem;">
            <div class="graph-card">
                <div class="graph-header">
                    <h3>
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#1b4332" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="23 6 13.5 15.5 8.5 10.5 1 18"/><polyline points="17 6 23 6 23 12"/></svg> 
                        14-Day Trip Trend
                    </h3>
                </div>
                <div style="height: 260px;">
                    <canvas id="trendChart"></canvas>
                </div>
            </div>

            <div class="graph-card">
                <div class="graph-header">
                    <h3>
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#1b4332" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="20" x2="18" y2="10"/><line x1="12" y1="20" x2="12" y2="4"/><line x1="6" y1="20" x2="6" y2="14"/></svg>
                        Fleet by Type
                    </h3>
                </div>
                <div style="height: 260px;">
                    <canvas id="typeChart"></canvas>
                </div>
            </div>
        </div>

        <div class="graph-card">
            <div class="graph-header">
                <h3>
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#1b4332" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21.21 15.89A10 10 0 1 1 8 2.83"/><path d="M22 12A10 10 0 0 0 12 2v10z"/></svg>
                    Vehicle Status Distribution
                </h3>
            </div>
            <div style="height: 280px; display: flex; justify-content: center;">
                <canvas id="statusChart"></canvas>
            </div>
        </div>
    </div>
    
    <asp:Literal ID="litChartData" runat="server"></asp:Literal>
</asp:Content>
