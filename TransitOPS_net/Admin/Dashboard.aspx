<%@ Page Title="Fleet Overview" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="TransitOPS_net.Admin.Dashboard" %>
<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">Fleet Overview - TransitOps Admin</asp:Content>
<asp:Content ID="c1" ContentPlaceHolderID="head" runat="server">
<script src='<%= ResolveUrl("~/Scripts/chart.umd.min.js") %>'></script>
</asp:Content>
<asp:Content ID="c2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="dashboard-page">
  <div class="dashboard-header">
    <div>
      <h1>Fleet Overview</h1>
      <p>Welcome back &#8212; Here's what's happening today.</p>
    </div>
    <div class="dashboard-header-actions">
      <a href="#" class="btn-outline"><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="7 10 12 15 17 10"/><line x1="12" y1="15" x2="12" y2="3"/></svg>Export</a>
      <a href="../Dispatcher/Trips.aspx" class="btn-primary"><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>New Trip</a>
    </div>
  </div>

  <div class="graph-card">
    <div class="graph-header">
      <h3><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#2d6a4f" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="23 6 13.5 15.5 8.5 10.5 1 18"/><polyline points="17 6 23 6 23 12"/></svg>Trip Activity &#8212; Last 7 Days</h3>
      <div class="graph-legend"><span class="legend-dot" style="background:#2d6a4f"></span>Trips</div>
    </div>
    <div style="position:relative;height:260px">
      <canvas id="tripsChart"></canvas>
    </div>
    <script>
      (function () {
        function draw() {
          var el = document.getElementById('tripsChart');
          if (!el || typeof Chart === 'undefined') return;
          var ctx = el.getContext('2d');
          var g = ctx.createLinearGradient(0, 0, 0, 260);
          g.addColorStop(0, 'rgba(45,106,79,0.30)');
          g.addColorStop(1, 'rgba(45,106,79,0.02)');
          new Chart(ctx, {
            type: 'line',
            data: {
              labels: ['Mon, Aug 10', 'Tue, Aug 11', 'Wed, Aug 12', 'Thu, Aug 13', 'Fri, Aug 14', 'Sat, Aug 15', 'Sun, Aug 16'],
              datasets: [{
                label: 'Trips',
                data: [1, 0, 1, 0, 1, 2, 3],
                borderColor: '#2d6a4f',
                backgroundColor: g,
                fill: true,
                tension: 0.4,
                borderWidth: 3,
                pointBackgroundColor: '#2d6a4f',
                pointBorderColor: '#fff',
                pointBorderWidth: 2,
                pointRadius: 5,
                pointHoverRadius: 7
              }]
            },
            options: {
              responsive: true,
              maintainAspectRatio: false,
              plugins: { legend: { display: false } },
              scales: {
                x: { grid: { display: false }, ticks: { font: { size: 11 }, color: '#9ca3af' } },
                y: { beginAtZero: true, ticks: { stepSize: 1, font: { size: 11 }, color: '#9ca3af' }, grid: { color: '#eef0f2' } }
              }
            }
          });
        }
        if (document.readyState === 'complete') draw();
        else window.addEventListener('load', draw);
      })();
    </script>
  </div>

  <div class="dashboard-grid">
    <div class="kpi-card" style="border-left-color:#2d6a4f">
      <div class="kpi-card-top"><div class="kpi-icon" style="background:rgba(45,106,79,0.1);color:#2d6a4f"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="1" y="3" width="15" height="13" rx="1"/><path d="M16 8h4l3 3v5h-7V8z"/><circle cx="5.5" cy="18.5" r="2.5"/><circle cx="18.5" cy="18.5" r="2.5"/></svg></div></div>
      <h3>Active Vehicles</h3><p class="kpi-value" style="color:#2d6a4f"><asp:Label ID="lblActiveVehicles" runat="server" Text="32"></asp:Label></p>
    </div>
    <div class="kpi-card" style="border-left-color:#10b981">
      <div class="kpi-card-top"><div class="kpi-icon" style="background:rgba(16,185,129,0.1);color:#10b981"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg></div></div>
      <h3>Available Vehicles</h3><p class="kpi-value" style="color:#10b981"><asp:Label ID="lblAvailableVehicles" runat="server" Text="24"></asp:Label></p>
    </div>
    <div class="kpi-card" style="border-left-color:#f59e0b">
      <div class="kpi-card-top"><div class="kpi-icon" style="background:rgba(245,158,11,0.1);color:#f59e0b"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M14.7 6.3a1 1 0 0 0 0 1.4l1.6 1.6a1 1 0 0 0 1.4 0l3.77-3.77a6 6 0 0 1-7.94 7.94l-6.91 6.91a2.12 2.12 0 0 1-3-3l6.91-6.91a6 6 0 0 1 7.94-7.94l-3.76 3.76z"/></svg></div></div>
      <h3>In Maintenance</h3><p class="kpi-value" style="color:#f59e0b"><asp:Label ID="lblMaintenance" runat="server" Text="3"></asp:Label></p>
    </div>
    <div class="kpi-card" style="border-left-color:#8b5cf6">
      <div class="kpi-card-top"><div class="kpi-icon" style="background:rgba(139,92,246,0.1);color:#8b5cf6"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polygon points="3 11 22 2 13 21 11 13 3 11"/></svg></div></div>
      <h3>Active Trips</h3><p class="kpi-value" style="color:#8b5cf6"><asp:Label ID="lblActiveTrips" runat="server" Text="12"></asp:Label></p>
    </div>
    <div class="kpi-card" style="border-left-color:#ef4444">
      <div class="kpi-card-top"><div class="kpi-icon" style="background:rgba(239,68,68,0.1);color:#ef4444"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg></div></div>
      <h3>Pending Trips</h3><p class="kpi-value" style="color:#ef4444"><asp:Label ID="lblPendingTrips" runat="server" Text="5"></asp:Label></p>
    </div>
    <div class="kpi-card" style="border-left-color:#14b8a6">
      <div class="kpi-card-top"><div class="kpi-icon" style="background:rgba(20,184,166,0.1);color:#14b8a6"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg></div></div>
      <h3>Drivers On Duty</h3><p class="kpi-value" style="color:#14b8a6"><asp:Label ID="lblDriversDuty" runat="server" Text="18"></asp:Label></p>
    </div>
    <div class="kpi-card" style="border-left-color:#f97316">
      <div class="kpi-card-top"><div class="kpi-icon" style="background:rgba(249,115,22,0.1);color:#f97316"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="22 12 18 12 15 21 9 3 6 12 2 12"/></svg></div></div>
      <h3>Fleet Utilization</h3><p class="kpi-value" style="color:#f97316"><asp:Label ID="lblUtilization" runat="server" Text="94%"></asp:Label></p>
    </div>
  </div>

  <div class="bottom-grid">
    <div class="recent-trips-panel">
      <div class="panel-header">
        <h3><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#2d6a4f" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polygon points="3 11 22 2 13 21 11 13 3 11"/></svg>Recent Trips</h3>
        <a href="../Dispatcher/Trips.aspx" class="view-all-link">View All &#8594;</a>
      </div>
      <div class="trips-list">
        <asp:GridView ID="gvRecentTrips" runat="server" AutoGenerateColumns="false" GridLines="None" ShowHeader="true">
          <Columns>
            <asp:BoundField DataField="TripCode" HeaderText="Trip" />
            <asp:BoundField DataField="Driver" HeaderText="Driver" />
            <asp:BoundField DataField="Route" HeaderText="Route" />
            <asp:TemplateField HeaderText="Status">
              <ItemTemplate><span class='status-badge <%# Eval("BadgeClass") %>'><%# Eval("Status") %></span></ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Time" HeaderText="Time" />
          </Columns>
        </asp:GridView>
      </div>
    </div>
    <div class="activity-panel">
      <div class="panel-header">
        <h3><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#8b5cf6" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"/><path d="M13.73 21a2 2 0 0 1-3.46 0"/></svg>Activity Feed</h3>
      </div>
      <div class="activity-list">
        <div class="activity-item"><div class="activity-dot" style="background:#2d6a4f"></div><div><p class="activity-text"><strong>Ramesh</strong> dispatched on <strong>MH-12-AB-4521</strong> from Mumbai to Pune</p><span class="activity-time">09:42 AM</span></div></div>
        <div class="activity-item"><div class="activity-dot" style="background:#10b981"></div><div><p class="activity-text"><strong>Suresh</strong> completed trip <strong>Pune &#8594; Nashik</strong></p><span class="activity-time">08:15 AM</span></div></div>
        <div class="activity-item"><div class="activity-dot" style="background:#f59e0b"></div><div><p class="activity-text">Trip <strong>Nashik &#8594; Nagpur</strong> created as Draft</p><span class="activity-time">Yesterday</span></div></div>
        <div class="activity-item"><div class="activity-dot" style="background:#ef4444"></div><div><p class="activity-text"><strong>Vikram</strong> trip <strong>Mumbai &#8594; Surat</strong> cancelled</p><span class="activity-time">Yesterday</span></div></div>
      </div>
    </div>
  </div>
</div>
</asp:Content>
