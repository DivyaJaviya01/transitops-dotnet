<%@ Page Title="Fleet Overview" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" %>
<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">Fleet Overview - TransitOps Admin</asp:Content>
<asp:Content ID="c1" ContentPlaceHolderID="head" runat="server">
<style>
.dash-export { display:inline-flex; align-items:center; gap:8px; }
</style>
</asp:Content>
<asp:Content ID="c2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="dash-head">
  <div>
    <h1>Fleet Overview</h1>
    <p>Welcome back — Here's what's happening today.</p>
  </div>
  <div class="dash-actions">
    <asp:Button ID="btnExport" runat="server" Text="Export" CssClass="to-btn to-btn-light" />
    <asp:Button ID="btnNewTrip" runat="server" Text="+ New Trip" CssClass="to-btn to-btn-primary" PostBackUrl="~/Dispatcher/Trips.aspx" />
  </div>
</div>

<div class="kpi-grid">
  <div class="kpi-card" style="border-left-color:#2d6a4f"><h3>Active Vehicles</h3><div class="kpi-value" style="color:#2d6a4f"><asp:Label ID="lblActiveVehicles" runat="server" Text="32"></asp:Label></div></div>
  <div class="kpi-card" style="border-left-color:#10b981"><h3>Available Vehicles</h3><div class="kpi-value" style="color:#10b981"><asp:Label ID="lblAvailableVehicles" runat="server" Text="24"></asp:Label></div></div>
  <div class="kpi-card" style="border-left-color:#f59e0b"><h3>In Maintenance</h3><div class="kpi-value" style="color:#f59e0b"><asp:Label ID="lblMaintenance" runat="server" Text="3"></asp:Label></div></div>
  <div class="kpi-card" style="border-left-color:#8b5cf6"><h3>Active Trips</h3><div class="kpi-value" style="color:#8b5cf6"><asp:Label ID="lblActiveTrips" runat="server" Text="12"></asp:Label></div></div>
  <div class="kpi-card" style="border-left-color:#ef4444"><h3>Pending Trips</h3><div class="kpi-value" style="color:#ef4444"><asp:Label ID="lblPendingTrips" runat="server" Text="5"></asp:Label></div></div>
  <div class="kpi-card" style="border-left-color:#14b8a6"><h3>Drivers On Duty</h3><div class="kpi-value" style="color:#14b8a6"><asp:Label ID="lblDriversDuty" runat="server" Text="18"></asp:Label></div></div>
  <div class="kpi-card" style="border-left-color:#f97316"><h3>Fleet Utilization</h3><div class="kpi-value" style="color:#f97316"><asp:Label ID="lblUtilization" runat="server" Text="94%"></asp:Label></div></div>
</div>

<div class="panel">
  <h3>Trip Activity — Last 7 Days</h3>
  <div class="chart-placeholder">Chart: Mon 4 · Tue 6 · Wed 3 · Thu 7 · Fri 5 · Sat 8 · Sun 6 trips (Chart.js will render here after backend connects)</div>
</div>

<div class="dash-bottom">
  <div class="panel">
    <h3>Recent Trips <a href="../Dispatcher/Trips.aspx" style="margin-left:auto;font-size:13px;color:var(--to-accent)">View All →</a></h3>
    <asp:GridView ID="gvRecentTrips" runat="server" AutoGenerateColumns="false" CssClass="grid-table" GridLines="None">
      <Columns>
        <asp:BoundField DataField="TripCode" HeaderText="Trip" />
        <asp:BoundField DataField="Driver" HeaderText="Driver" />
        <asp:BoundField DataField="Route" HeaderText="Route" />
        <asp:TemplateField HeaderText="Status">
          <ItemTemplate><span class='to-pill <%# Eval("PillClass") %>'><%# Eval("Status") %></span></ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="Time" HeaderText="Time" />
      </Columns>
    </asp:GridView>
  </div>
  <div class="panel">
    <h3>Activity Feed</h3>
    <div class="activity-item"><span class="activity-dot" style="background:#2d6a4f"></span><div><b>Ramesh</b> dispatched on <b>MH-12-AB-4521</b> Mumbai → Pune<br /><span class="activity-time">09:42 AM</span></div></div>
    <div class="activity-item"><span class="activity-dot" style="background:#10b981"></span><div><b>Suresh</b> completed trip <b>Pune → Nashik</b><br /><span class="activity-time">08:15 AM</span></div></div>
    <div class="activity-item"><span class="activity-dot" style="background:#f59e0b"></span><div>Trip <b>Nashik → Nagpur</b> created as Draft<br /><span class="activity-time">Yesterday</span></div></div>
    <div class="activity-item"><span class="activity-dot" style="background:#ef4444"></span><div>Trip <b>TR-1040</b> cancelled — driver off duty<br /><span class="activity-time">Yesterday</span></div></div>
  </div>
</div>
</asp:Content>
