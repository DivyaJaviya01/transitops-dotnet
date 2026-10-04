<%@ Page Title="Vehicle Registry" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Vehicles.aspx.cs" Inherits="TransitOPS_net.FleetManager.Vehicles" %>
<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">Vehicle Registry - TransitOps Admin</asp:Content>
<asp:Content ID="c1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="c2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="page-header">
  <div>
    <h1>Vehicle Registry</h1>
    <p>Fleet &#8212; All Assets</p>
  </div>
  <div class="page-header-actions">
    <asp:Button ID="btnAddVehicle" runat="server" Text="+ ADD VEHICLE" CssClass="btn-primary-sm" OnClick="btnAddVehicle_Click" />
  </div>
</div>

<div class="stats-grid">
  <div class="stat-card">
    <div class="stat-card-icon" style="background:rgba(27,67,50,0.06);color:var(--accent-brand)"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="1" y="3" width="15" height="13" rx="1"/><path d="M16 8h4l3 3v5h-7V8z"/><circle cx="5.5" cy="18.5" r="2.5"/><circle cx="18.5" cy="18.5" r="2.5"/></svg></div>
    <div class="stat-card-label">Total Fleet</div>
    <div class="stat-card-value"><asp:Label ID="lblTotal" runat="server" Text="8" /> <span class="stat-card-sub">Assets</span></div>
  </div>
  <div class="stat-card">
    <div class="stat-card-icon" style="background:rgba(45,106,79,0.12);color:#2d6a4f"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"/></svg></div>
    <div class="stat-card-label">Active (On Trip)</div>
    <div class="stat-card-value"><asp:Label ID="lblOnTrip" runat="server" Text="2" /> <span class="stat-card-sub">Operational</span></div>
  </div>
  <div class="stat-card">
    <div class="stat-card-icon" style="background:rgba(184,134,11,0.15);color:#fbbf24"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"/></svg></div>
    <div class="stat-card-label">Maintenance</div>
    <div class="stat-card-value"><asp:Label ID="lblInShop" runat="server" Text="2" /> <span class="stat-card-sub">In Shop</span></div>
  </div>
  <div class="stat-card">
    <div class="stat-card-icon" style="background:rgba(27,67,50,0.06);color:var(--accent-brand)"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="9"/></svg></div>
    <div class="stat-card-label">Available</div>
    <div class="stat-card-value"><asp:Label ID="lblAvailable" runat="server" Text="3" /> <span class="stat-card-sub">Ready</span></div>
  </div>
</div>

<div class="filter-bar">
  <div class="filter-bar-left">
    <span class="filter-label">Filters:</span>
    <asp:DropDownList ID="ddlStatus" runat="server" CssClass="filter-select" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed">
      <asp:ListItem Value="" Text="All Statuses" />
      <asp:ListItem Value="Available" Text="Available" />
      <asp:ListItem Value="On Trip" Text="On Trip" />
      <asp:ListItem Value="In Shop" Text="In Shop" />
      <asp:ListItem Value="Retired" Text="Retired" />
    </asp:DropDownList>
    <asp:DropDownList ID="ddlType" runat="server" CssClass="filter-select" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed">
      <asp:ListItem Value="" Text="All Vehicle Types" />
      <asp:ListItem Value="Truck" Text="Truck" />
      <asp:ListItem Value="Van" Text="Van" />
      <asp:ListItem Value="Sedan" Text="Sedan" />
    </asp:DropDownList>
    <asp:Button ID="btnClear" runat="server" Text="Clear All" CssClass="filter-clear" OnClick="btnClear_Click" />
  </div>
  <span class="filter-count"><asp:Label ID="lblCount" runat="server" Text="Showing 8 vehicles" /></span>
</div>

<div class="table-card">
  <div class="table-wrap">
    <asp:GridView ID="gvVehicles" runat="server" AutoGenerateColumns="false" GridLines="None" ShowHeader="true" OnRowCommand="gvVehicles_RowCommand">
      <Columns>
        <asp:TemplateField HeaderText="Vehicle ID" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
          <ItemTemplate>
            <div style="display:flex;flex-direction:column;align-items:center">
              <span style="font-weight:600"><%# Eval("RegistrationNumber") %></span>
              <span style="font-size:0.75rem;color:var(--text-secondary)"><%# Eval("Name") %></span>
            </div>
          </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Name / Type" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
          <ItemTemplate>
            <div style="display:flex;align-items:center;justify-content:center;gap:0.5rem">
              <span><%# GetTypeIcon(Eval("Type")) %></span>
              <span><%# Eval("Type") %></span>
            </div>
          </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Status" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
          <ItemTemplate><span class='badge <%# GetBadgeClass(Eval("Status")) %>'><span class="badge-dot"></span> <%# Eval("Status").ToString().ToUpper() %></span></ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Odometer" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
          <ItemTemplate><%# Eval("OdometerKm", "{0:N0}") %> km</ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Capacity" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
          <ItemTemplate><%# Eval("MaxLoadKg", "{0:N0}") %> kg</ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Actions" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
          <ItemTemplate>
            <div style="display:flex;align-items:center;justify-content:center;gap:0.2rem">
            <asp:LinkButton ID="lnkView" runat="server" CssClass="btn-icon" ToolTip="View Details" CommandName="View" CommandArgument='<%# Eval("RegistrationNumber") %>'>
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
            </asp:LinkButton>
            <asp:LinkButton ID="lnkEdit" runat="server" CssClass="btn-icon" ToolTip="Edit" CommandName="EditVehicle" CommandArgument='<%# Eval("RegistrationNumber") %>'>
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 3a2.83 2.83 0 1 1 4 4L7.5 20.5 2 22l1.5-5.5z"/></svg>
            </asp:LinkButton>
            <asp:LinkButton ID="lnkDelete" runat="server" CssClass="btn-icon danger" ToolTip="Delete" CommandName="DeleteVehicle" CommandArgument='<%# Eval("RegistrationNumber") %>' OnClientClick="return confirm('Delete this vehicle?');">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="3 6 5 6 21 6"/><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/></svg>
            </asp:LinkButton>
            </div>
          </ItemTemplate>
        </asp:TemplateField>
      </Columns>
    </asp:GridView>
    <asp:Label ID="lblEmpty" runat="server" CssClass="empty-state" Text="No vehicles found" Visible="false" />
  </div>
</div>

<asp:Panel ID="pnlDetails" runat="server" Visible="false">
  <div class="modal-overlay">
    <div class="modal-card" style="max-width:420px">
      <div class="modal-header">
        <div>
          <h3><asp:Label ID="lblDReg" runat="server" /></h3>
          <p style="font-size:0.85rem;color:var(--text-secondary);margin:0.1rem 0 0"><asp:Label ID="lblDName" runat="server" /></p>
        </div>
        <asp:Button ID="btnCloseDetails" runat="server" Text="&#10005;" CssClass="modal-close" OnClick="btnCloseDetails_Click" />
      </div>
      <div class="detail-row"><span>Type</span><span><asp:Label ID="lblDType" runat="server" /></span></div>
      <div class="detail-row"><span>Status</span><span><asp:Label ID="lblDStatus" runat="server" /></span></div>
      <div class="detail-row"><span>Odometer</span><span><asp:Label ID="lblDOdo" runat="server" /></span></div>
      <div class="detail-row"><span>Max Load</span><span><asp:Label ID="lblDLoad" runat="server" /></span></div>
      <div class="detail-row"><span>Acquisition Cost</span><span><asp:Label ID="lblDCost" runat="server" /></span></div>
    </div>
  </div>
</asp:Panel>

<asp:Panel ID="pnlAdd" runat="server" Visible="false">
  <div class="modal-overlay">
    <div class="modal-card">
      <div class="modal-header">
        <h3><asp:Label ID="lblFormTitle" runat="server" Text="Add New Vehicle" /></h3>
        <asp:Button ID="btnCloseAdd" runat="server" Text="&#10005;" CssClass="modal-close" CausesValidation="false" OnClick="btnCloseAdd_Click" />
      </div>
      <div class="form-field">
        <label class="form-label">Registration Number</label>
        <asp:TextBox ID="txtReg" runat="server" CssClass="form-input" placeholder="e.g. VT-1234-X" />
        <asp:RequiredFieldValidator ID="rfvReg" runat="server" ControlToValidate="txtReg" ErrorMessage="Registration required" ForeColor="Red" Font-Size="12px" ValidationGroup="AddVehicle" />
      </div>
      <div class="form-field">
        <label class="form-label">Vehicle Name</label>
        <asp:TextBox ID="txtName" runat="server" CssClass="form-input" placeholder="e.g. Volvo FH16" />
        <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" ErrorMessage="Name required" ForeColor="Red" Font-Size="12px" ValidationGroup="AddVehicle" />
      </div>
      <div class="form-row">
        <div class="form-field">
          <label class="form-label">Type</label>
          <asp:DropDownList ID="ddlNewType" runat="server" CssClass="form-select">
            <asp:ListItem Text="Truck" /><asp:ListItem Text="Van" /><asp:ListItem Text="Sedan" />
          </asp:DropDownList>
        </div>
        <div class="form-field">
          <label class="form-label">Status</label>
          <asp:DropDownList ID="ddlNewStatus" runat="server" CssClass="form-select">
            <asp:ListItem Text="Available" /><asp:ListItem Text="On Trip" /><asp:ListItem Text="In Shop" /><asp:ListItem Text="Retired" />
          </asp:DropDownList>
        </div>
      </div>
      <div class="form-row">
        <div class="form-field">
          <label class="form-label">Max Load (kg)</label>
          <asp:TextBox ID="txtLoad" runat="server" CssClass="form-input" TextMode="Number" Text="0" />
          <asp:RangeValidator ID="rvLoad" runat="server" ControlToValidate="txtLoad" MinimumValue="1" MaximumValue="1000000" Type="Integer" ErrorMessage="Load must be > 0" ForeColor="Red" Font-Size="12px" ValidationGroup="AddVehicle" />
        </div>
        <div class="form-field">
          <label class="form-label">Odometer (km)</label>
          <asp:TextBox ID="txtOdo" runat="server" CssClass="form-input" TextMode="Number" Text="0" />
        </div>
      </div>
      <div class="form-field">
        <label class="form-label">Cost ($)</label>
        <asp:TextBox ID="txtCost" runat="server" CssClass="form-input" TextMode="Number" Text="0" />
        <asp:RequiredFieldValidator ID="rfvCost" runat="server" ControlToValidate="txtCost" ErrorMessage="Cost required" ForeColor="Red" Font-Size="12px" ValidationGroup="AddVehicle" />
      </div>
      <div class="form-actions">
        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn-cancel" CausesValidation="false" OnClick="btnCloseAdd_Click" />
        <asp:Button ID="btnSave" runat="server" Text="Save Vehicle" CssClass="btn-submit" ValidationGroup="AddVehicle" OnClick="btnSave_Click" />
      </div>
    </div>
  </div>
</asp:Panel>
</asp:Content>
