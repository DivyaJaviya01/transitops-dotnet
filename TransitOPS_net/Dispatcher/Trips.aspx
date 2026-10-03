<%@ Page Title="Trips" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Trips.aspx.cs" Inherits="TransitOPS_net.Dispatcher.Trips" %>
<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">Trips - TransitOps Admin</asp:Content>
<asp:Content ID="c1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="c2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="page-header">
  <div>
    <h1>Trips</h1>
    <p>Plan, dispatch, and track active deliveries</p>
  </div>
  <div class="page-header-actions">
    <asp:Button ID="btnNewTrip" runat="server" Text="+ New Trip" CssClass="btn-primary-sm" OnClick="btnNewTrip_Click" />
  </div>
</div>

<div class="table-card">
  <div class="table-wrap">
    <asp:GridView ID="gvTrips" runat="server" AutoGenerateColumns="false" GridLines="None" ShowHeader="true" OnRowCommand="gvTrips_RowCommand">
      <Columns>
        <asp:TemplateField HeaderText="Route">
          <ItemTemplate><span style="font-weight:700"><%# Eval("Source") %> &#8594; <%# Eval("Destination") %></span></ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Cargo Load">
          <ItemTemplate><%# Eval("CargoWeightKg", "{0:N0}") %> kg</ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Distance">
          <ItemTemplate><%# GetDistanceText(Eval("Status"), Eval("ActualKm"), Eval("PlannedKm")) %></ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Vehicle ID">
          <ItemTemplate><%# Eval("VehicleName") %> (<%# Eval("VehicleReg") %>)</ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="DriverName" HeaderText="Driver Name" />
        <asp:TemplateField HeaderText="Status">
          <ItemTemplate><span class='badge <%# GetBadgeClass(Eval("Status")) %>'><span class="badge-dot"></span> <%# Eval("Status") %></span></ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Actions">
          <ItemTemplate>
            <div style="display:flex;gap:0.4rem;align-items:center">
              <asp:LinkButton ID="lnkDispatch" runat="server" CssClass="btn-ghost" ToolTip="Dispatch" CommandName="Dispatch" CommandArgument='<%# Eval("TripCode") %>' Visible='<%# Eval("Status").ToString() == "Draft" %>' style="font-size:0.72rem;padding:0.2rem 0.6rem">&#10148; Dispatch</asp:LinkButton>
              <asp:LinkButton ID="lnkComplete" runat="server" CssClass="btn-ghost" ToolTip="Complete" CommandName="OpenComplete" CommandArgument='<%# Eval("TripCode") %>' Visible='<%# Eval("Status").ToString() == "Dispatched" %>' style="font-size:0.72rem;padding:0.2rem 0.6rem">&#10003; Complete</asp:LinkButton>
              <asp:LinkButton ID="lnkCancel" runat="server" CssClass="btn-icon danger" ToolTip="Cancel Trip" CommandName="CancelTrip" CommandArgument='<%# Eval("TripCode") %>' Visible='<%# Eval("Status").ToString() != "Completed" && Eval("Status").ToString() != "Cancelled" %>' OnClientClick="return confirm('Cancel this trip?');">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
              </asp:LinkButton>
              <asp:LinkButton ID="lnkDelete" runat="server" CssClass="btn-icon danger" ToolTip="Delete" CommandName="DeleteTrip" CommandArgument='<%# Eval("TripCode") %>' Visible='<%# Eval("Status").ToString() == "Draft" %>' OnClientClick="return confirm('Delete this trip?');">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="3 6 5 6 21 6"/><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/></svg>
              </asp:LinkButton>
            </div>
          </ItemTemplate>
        </asp:TemplateField>
      </Columns>
    </asp:GridView>
    <asp:Label ID="lblEmpty" runat="server" CssClass="empty-state" Text="No trip delivery logs. Plan a new trip route above." Visible="false" />
  </div>
</div>

<asp:Panel ID="pnlNew" runat="server" Visible="false">
  <div class="modal-overlay">
    <div class="modal-card">
      <div class="modal-header">
        <h3>Create New Trip</h3>
        <asp:Button ID="btnCloseNew" runat="server" Text="&#10005;" CssClass="modal-close" CausesValidation="false" OnClick="btnCloseNew_Click" />
      </div>
      <div class="form-field">
        <label class="form-label">Source Location</label>
        <asp:TextBox ID="txtSource" runat="server" CssClass="form-input" placeholder="e.g. Mumbai" />
        <asp:RequiredFieldValidator ID="rfvSource" runat="server" ControlToValidate="txtSource" ErrorMessage="Source required" ForeColor="Red" Font-Size="12px" ValidationGroup="NewTrip" />
      </div>
      <div class="form-field">
        <label class="form-label">Destination Location</label>
        <asp:TextBox ID="txtDest" runat="server" CssClass="form-input" placeholder="e.g. Pune" />
        <asp:RequiredFieldValidator ID="rfvDest" runat="server" ControlToValidate="txtDest" ErrorMessage="Destination required" ForeColor="Red" Font-Size="12px" ValidationGroup="NewTrip" />
      </div>
      <div class="form-row">
        <div class="form-field">
          <label class="form-label">Cargo Weight (kg)</label>
          <asp:TextBox ID="txtCargo" runat="server" CssClass="form-input" TextMode="Number" placeholder="e.g. 5000" />
          <asp:RequiredFieldValidator ID="rfvCargo" runat="server" ControlToValidate="txtCargo" ErrorMessage="Weight required" ForeColor="Red" Font-Size="12px" ValidationGroup="NewTrip" />
          <asp:RangeValidator ID="rvCargo" runat="server" ControlToValidate="txtCargo" MinimumValue="1" MaximumValue="1000000" Type="Integer" ErrorMessage="Weight must be > 0" ForeColor="Red" Font-Size="12px" ValidationGroup="NewTrip" />
        </div>
        <div class="form-field">
          <label class="form-label">Planned Distance (km)</label>
          <asp:TextBox ID="txtDist" runat="server" CssClass="form-input" TextMode="Number" placeholder="e.g. 350" />
          <asp:RequiredFieldValidator ID="rfvDist" runat="server" ControlToValidate="txtDist" ErrorMessage="Distance required" ForeColor="Red" Font-Size="12px" ValidationGroup="NewTrip" />
        </div>
      </div>
      <div class="form-field">
        <label class="form-label">Select Vehicle</label>
        <asp:DropDownList ID="ddlVehicle" runat="server" CssClass="form-select" />
      </div>
      <div class="form-field">
        <label class="form-label">Select Driver</label>
        <asp:DropDownList ID="ddlDriver" runat="server" CssClass="form-select" />
      </div>
      <div class="form-actions">
        <asp:Button ID="btnCancelNew" runat="server" Text="Cancel" CssClass="btn-cancel" CausesValidation="false" OnClick="btnCloseNew_Click" />
        <asp:Button ID="btnCreate" runat="server" Text="Create" CssClass="btn-submit" ValidationGroup="NewTrip" OnClick="btnCreate_Click" />
      </div>
    </div>
  </div>
</asp:Panel>

<asp:Panel ID="pnlComplete" runat="server" Visible="false">
  <div class="modal-overlay">
    <div class="modal-card" style="max-width:400px">
      <div class="modal-header">
        <h3>Complete Delivery</h3>
        <asp:Button ID="btnCloseComplete" runat="server" Text="&#10005;" CssClass="modal-close" CausesValidation="false" OnClick="btnCloseComplete_Click" />
      </div>
      <asp:HiddenField ID="hfTrip" runat="server" />
      <div class="form-field">
        <label class="form-label">Actual Distance (km)</label>
        <asp:TextBox ID="txtActualKm" runat="server" CssClass="form-input" TextMode="Number" placeholder="e.g. 340" />
        <asp:RequiredFieldValidator ID="rfvActual" runat="server" ControlToValidate="txtActualKm" ErrorMessage="Actual distance required" ForeColor="Red" Font-Size="12px" ValidationGroup="CompleteTrip" />
      </div>
      <div class="form-field">
        <label class="form-label">Fuel Consumed (liters)</label>
        <asp:TextBox ID="txtFuel" runat="server" CssClass="form-input" TextMode="Number" placeholder="e.g. 120" />
        <asp:RequiredFieldValidator ID="rfvFuel" runat="server" ControlToValidate="txtFuel" ErrorMessage="Fuel required" ForeColor="Red" Font-Size="12px" ValidationGroup="CompleteTrip" />
      </div>
      <div class="form-actions">
        <asp:Button ID="btnCancelComplete" runat="server" Text="Cancel" CssClass="btn-cancel" CausesValidation="false" OnClick="btnCloseComplete_Click" />
        <asp:Button ID="btnDoComplete" runat="server" Text="Save &amp; Complete" CssClass="btn-submit" ValidationGroup="CompleteTrip" OnClick="btnDoComplete_Click" />
      </div>
    </div>
  </div>
</asp:Panel>
</asp:Content>
