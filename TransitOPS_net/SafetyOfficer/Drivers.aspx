<%@ Page Title="Drivers" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Drivers.aspx.cs" Inherits="TransitOPS_net.SafetyOfficer.Drivers" %>
<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">Drivers - TransitOps Admin</asp:Content>
<asp:Content ID="c1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="c2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="page-header">
  <div>
    <h1>Drivers</h1>
    <p>Personnel directory, safety scores, and availability</p>
  </div>
  <div class="page-header-actions">
    <asp:Button ID="btnExport" runat="server" Text="Export CSV" CssClass="btn-ghost" OnClick="btnExport_Click" />
    <asp:Button ID="btnAddDriver" runat="server" Text="+ ADD DRIVER" CssClass="btn-primary-sm" OnClick="btnAddDriver_Click" />
  </div>
</div>

<div class="stats-grid">
  <div class="stat-card">
    <div class="stat-card-icon" style="background:rgba(27,67,50,0.06);color:var(--accent-brand)"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg></div>
    <div class="stat-card-label">Total Personnel</div>
    <div class="stat-card-value"><asp:Label ID="lblTotal" runat="server" Text="8" /></div>
  </div>
  <div class="stat-card">
    <div class="stat-card-icon" style="background:rgba(45,106,79,0.12);color:#2d6a4f"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="22 12 18 12 15 21 9 3 6 12 2 12"/></svg></div>
    <div class="stat-card-label">On Trip</div>
    <div class="stat-card-value"><asp:Label ID="lblOnTrip" runat="server" Text="2" /> <span class="stat-card-sub"><asp:Label ID="lblOnTripPct" runat="server" Text="25%" /></span></div>
  </div>
  <div class="stat-card">
    <div class="stat-card-icon" style="background:rgba(27,67,50,0.06);color:var(--accent-brand)"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"/></svg></div>
    <div class="stat-card-label">Available</div>
    <div class="stat-card-value"><asp:Label ID="lblAvailable" runat="server" Text="3" /> <span class="stat-card-sub">Ready</span></div>
  </div>
  <div class="stat-card">
    <div class="stat-card-icon" style="background:rgba(184,134,11,0.15);color:#fbbf24"><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/></svg></div>
    <div class="stat-card-label">Avg Safety Score</div>
    <div class="stat-card-value"><asp:Label ID="lblAvgSafety" runat="server" Text="82.8" /> <span class="stat-card-sub">/ 100</span></div>
  </div>
</div>

<div class="filter-bar">
  <div class="filter-bar-left">
    <span class="filter-label">Status:</span>
    <asp:DropDownList ID="ddlStatus" runat="server" CssClass="filter-select" AutoPostBack="true" OnSelectedIndexChanged="Filter_Changed">
      <asp:ListItem Value="" Text="All Statuses" />
      <asp:ListItem Value="On Trip" Text="On Trip" />
      <asp:ListItem Value="Available" Text="Available" />
      <asp:ListItem Value="Off Duty" Text="Off Duty" />
      <asp:ListItem Value="Suspended" Text="Suspended" />
    </asp:DropDownList>
  </div>
  <span class="filter-count"><asp:Label ID="lblCount" runat="server" Text="Showing 8 drivers" /></span>
</div>

<div class="table-card">
  <div class="table-wrap">
    <asp:GridView ID="gvDrivers" runat="server" AutoGenerateColumns="false" GridLines="None" ShowHeader="true" OnRowCommand="gvDrivers_RowCommand">
      <Columns>
        <asp:TemplateField HeaderText="Personnel Name" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
          <ItemTemplate>
            <div style="display:flex;align-items:center;justify-content:center;gap:0.65rem;text-align:left">
              <div style="width:36px;height:36px;border-radius:50%;background:rgba(27,67,50,0.06);color:var(--accent-brand);display:flex;align-items:center;justify-content:center;font-weight:600;font-size:0.75rem;flex-shrink:0"><%# GetInitials(Eval("FullName")) %></div>
              <div>
                <div style="font-weight:600"><%# Eval("FullName") %></div>
                <div style="font-size:0.75rem;color:var(--text-secondary)"><%# Eval("LicenseCategory") %></div>
              </div>
            </div>
          </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="ID / License" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
          <ItemTemplate>#<%# Eval("LicenseNumber") %></ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Status" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
          <ItemTemplate><span class='badge <%# GetBadgeClass(Eval("Status")) %>'><span class="badge-dot"></span> <%# Eval("Status") %></span></ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Safety Score" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
          <ItemTemplate>
            <div style="display:flex;flex-direction:column;align-items:center;gap:0.2rem">
              <span style='<%# "font-weight:700;color:" + GetScoreColor((int)Eval("SafetyScore")) %>'><%# Eval("SafetyScore") %></span>
              <div style="width:64px;height:4px;background:var(--surface-muted);border-radius:2px;overflow:hidden">
                <div style='<%# "height:100%;border-radius:2px;width:" + Eval("SafetyScore") + "%;background:" + GetScoreColor((int)Eval("SafetyScore")) %>'></div>
              </div>
            </div>
          </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="License Expiry" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
          <ItemTemplate>
            <div style="display:flex;flex-direction:column;align-items:center">
            <div style="font-size:0.82rem"><%# Eval("LicenseExpiryDate", "{0:MMM d, yyyy}") %></div>
            <div style='<%# "font-size:0.68rem;font-weight:700;color:" + GetExpiryColor((DateTime)Eval("LicenseExpiryDate")) %>'><%# GetExpiryText((DateTime)Eval("LicenseExpiryDate")) %></div>
            </div>
          </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Actions" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
          <ItemTemplate>
            <div style="display:flex;align-items:center;justify-content:center;gap:0.2rem">
            <asp:LinkButton ID="lnkView" runat="server" CssClass="btn-icon" ToolTip="View Details" CommandName="View" CommandArgument='<%# Eval("LicenseNumber") %>'>
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
            </asp:LinkButton>
            <asp:LinkButton ID="lnkEdit" runat="server" CssClass="btn-icon" ToolTip="Edit" CommandName="EditDriver" CommandArgument='<%# Eval("LicenseNumber") %>'>
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 3a2.83 2.83 0 1 1 4 4L7.5 20.5 2 22l1.5-5.5z"/></svg>
            </asp:LinkButton>
            <asp:LinkButton ID="lnkDelete" runat="server" CssClass="btn-icon danger" ToolTip="Delete" CommandName="DeleteDriver" CommandArgument='<%# Eval("LicenseNumber") %>' OnClientClick="return confirm('Delete this driver?');">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="3 6 5 6 21 6"/><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/></svg>
            </asp:LinkButton>
            </div>
          </ItemTemplate>
        </asp:TemplateField>
      </Columns>
    </asp:GridView>
    <asp:Label ID="lblEmpty" runat="server" CssClass="empty-state" Text="No drivers found" Visible="false" />
  </div>
</div>

<asp:Panel ID="pnlDetails" runat="server" Visible="false">
  <div class="modal-overlay">
    <div class="modal-card" style="max-width:420px">
      <div class="modal-header">
        <div style="display:flex;gap:0.75rem;align-items:center">
          <div style="width:44px;height:44px;border-radius:50%;background:rgba(27,67,50,0.06);color:var(--accent-brand);display:flex;align-items:center;justify-content:center;font-weight:600;font-size:0.9rem;flex-shrink:0"><asp:Label ID="lblDInitials" runat="server" /></div>
          <div>
            <h3 style="margin:0"><asp:Label ID="lblDName" runat="server" /></h3>
            <p style="margin:0.1rem 0 0;font-size:0.82rem;color:var(--text-secondary)"><asp:Label ID="lblDCat" runat="server" /></p>
          </div>
        </div>
        <asp:Button ID="btnCloseDetails" runat="server" Text="&#10005;" CssClass="modal-close" OnClick="btnCloseDetails_Click" />
      </div>
      <div class="detail-row"><span>License Number</span><span><asp:Label ID="lblDLicense" runat="server" /></span></div>
      <div class="detail-row"><span>Status</span><span><asp:Label ID="lblDStatus" runat="server" /></span></div>
      <div class="detail-row"><span>Safety Score</span><span><asp:Label ID="lblDScore" runat="server" /></span></div>
      <div class="detail-row"><span>License Expiry</span><span><asp:Label ID="lblDExpiry" runat="server" /></span></div>
      <div class="detail-row"><span>Contact</span><span><asp:Label ID="lblDContact" runat="server" /></span></div>
    </div>
  </div>
</asp:Panel>

<asp:Panel ID="pnlAdd" runat="server" Visible="false">
  <div class="modal-overlay">
    <div class="modal-card">
      <div class="modal-header">
        <h3><asp:Label ID="lblFormTitle" runat="server" Text="Add New Driver" /></h3>
        <asp:Button ID="btnCloseAdd" runat="server" Text="&#10005;" CssClass="modal-close" CausesValidation="false" OnClick="btnCloseAdd_Click" />
      </div>
      <div class="form-field">
        <label class="form-label">Full Name</label>
        <asp:TextBox ID="txtName" runat="server" CssClass="form-input" />
        <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" ErrorMessage="Name required" ForeColor="Red" Font-Size="12px" ValidationGroup="AddDriver" />
      </div>
      <div class="form-row">
        <div class="form-field">
          <label class="form-label">License Number</label>
          <asp:TextBox ID="txtLicense" runat="server" CssClass="form-input" />
          <asp:RequiredFieldValidator ID="rfvLicense" runat="server" ControlToValidate="txtLicense" ErrorMessage="License required" ForeColor="Red" Font-Size="12px" ValidationGroup="AddDriver" />
        </div>
        <div class="form-field">
          <label class="form-label">License Category</label>
          <asp:DropDownList ID="ddlNewCat" runat="server" CssClass="form-select">
            <asp:ListItem Text="Class A" /><asp:ListItem Text="Class B" /><asp:ListItem Text="Class C" />
          </asp:DropDownList>
        </div>
      </div>
      <div class="form-field">
        <label class="form-label">Contact Number</label>
        <asp:TextBox ID="txtContact" runat="server" CssClass="form-input" placeholder="e.g. +91-98765-43210" />
        <asp:RequiredFieldValidator ID="rfvContact" runat="server" ControlToValidate="txtContact" ErrorMessage="Contact required" ForeColor="Red" Font-Size="12px" ValidationGroup="AddDriver" />
      </div>
      <div class="form-row">
        <div class="form-field">
          <label class="form-label">License Expiry</label>
          <asp:TextBox ID="txtExpiry" runat="server" CssClass="form-input" TextMode="Date" />
          <asp:RequiredFieldValidator ID="rfvExpiry" runat="server" ControlToValidate="txtExpiry" ErrorMessage="Expiry required" ForeColor="Red" Font-Size="12px" ValidationGroup="AddDriver" />
        </div>
        <div class="form-field">
          <label class="form-label">Status</label>
          <asp:DropDownList ID="ddlNewStatus" runat="server" CssClass="form-select">
            <asp:ListItem Text="Available" /><asp:ListItem Text="On Trip" /><asp:ListItem Text="Off Duty" />
          </asp:DropDownList>
        </div>
      </div>
      <div class="form-field">
        <label class="form-label">Safety Score (0-100)</label>
        <asp:TextBox ID="txtScore" runat="server" CssClass="form-input" TextMode="Number" Text="85" />
        <asp:RangeValidator ID="rvScore" runat="server" ControlToValidate="txtScore" MinimumValue="0" MaximumValue="100" Type="Integer" ErrorMessage="Score must be 0-100" ForeColor="Red" Font-Size="12px" ValidationGroup="AddDriver" />
      </div>
      <div class="form-actions">
        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn-cancel" CausesValidation="false" OnClick="btnCloseAdd_Click" />
        <asp:Button ID="btnSave" runat="server" Text="Save Driver" CssClass="btn-submit" ValidationGroup="AddDriver" OnClick="btnSave_Click" />
      </div>
    </div>
  </div>
</asp:Panel>
</asp:Content>
