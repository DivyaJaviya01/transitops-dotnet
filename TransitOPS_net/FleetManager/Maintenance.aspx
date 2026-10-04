<%@ Page Title="Maintenance" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Maintenance.aspx.cs" Inherits="TransitOPS_net.FleetManager.Maintenance" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">Maintenance - TransitOps Admin</asp:Content>

<asp:Content ID="c1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="c2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  <div class="content-wrapper">
    <div class="page-header">
      <div>
        <h1>Maintenance</h1>
        <p>Schedule services and track active repair logs</p>
      </div>
      <div class="page-header-actions">
        <asp:LinkButton ID="btnOpenModal" runat="server" CssClass="btn-primary-sm" OnClick="btnOpenModal_Click">
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="margin-right: 4px; vertical-align: text-bottom;"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg> Schedule Service
        </asp:LinkButton>
      </div>
    </div>

    <asp:Label ID="lblToast" runat="server" Visible="false" style="display:block; border-radius: 12px; padding: 0.85rem 1rem; margin-bottom: 1.5rem; font-size: 0.9rem; text-align: center;"></asp:Label>

    <div style="margin-top: 1.5rem;">
      <asp:Panel ID="pnlEmpty" runat="server" Visible="false" CssClass="table-card" style="padding: 2.5rem; text-align: center;">
          <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="#1b4332" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="margin-bottom: 1rem;"><path d="M14.7 6.3a1 1 0 0 0 0 1.4l1.6 1.6a1 1 0 0 0 1.4 0l3.77-3.77a6 6 0 0 1-7.94 7.94l-6.91 6.91a2.12 2.12 0 0 1-3-3l6.91-6.91a6 6 0 0 1 7.94-7.94l-3.76 3.76z"/></svg>
          <p class="empty-state">No maintenance logs. Click the button to schedule service.</p>
      </asp:Panel>

      <asp:Panel ID="pnlTable" runat="server" CssClass="table-card">
        <div class="table-wrap">
          <asp:GridView ID="gvLogs" runat="server" AutoGenerateColumns="false" GridLines="None" ShowHeader="true" OnRowCommand="gvLogs_RowCommand" DataKeyNames="Id">
            <Columns>
              <asp:TemplateField HeaderText="Vehicle" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                  <strong style="font-weight: 700;"><%# Eval("VehicleName") %> (<%# Eval("VehicleId") %>)</strong>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:BoundField DataField="Type" HeaderText="Service Type" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
              <asp:TemplateField HeaderText="Cost" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>$<%# Eval("Cost", "{0:n0}") %></ItemTemplate>
              </asp:TemplateField>
              <asp:BoundField DataField="StartDate" HeaderText="Start Date" DataFormatString="{0:M/d/yyyy}" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
              <asp:BoundField DataField="EstimatedCompletionDate" HeaderText="Estimated End" DataFormatString="{0:M/d/yyyy}" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
              <asp:TemplateField HeaderText="Status" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                  <span class='badge <%# Eval("Status").ToString() == "Closed" ? "badge-success" : "badge-warning" %>'>
                    <span class="badge-dot"></span> <%# Eval("Status") %>
                  </span>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Action" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                  <div style="display: flex; gap: 0.4rem; align-items: center; justify-content: center;">
                    <asp:LinkButton ID="btnCloseLog" runat="server" CommandName="CloseLog" CommandArgument='<%# Eval("Id") %>' Visible='<%# Eval("Status").ToString() == "Active" %>' CssClass="btn-ghost" style="font-size: 0.72rem; padding: 0.2rem 0.6rem; gap: 0.2rem; display: flex; align-items: center; text-decoration: none; color: inherit;">
                      <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"/></svg> Close
                    </asp:LinkButton>
                    <asp:LinkButton ID="btnDeleteLog" runat="server" CommandName="DeleteLog" CommandArgument='<%# Eval("Id") %>' Visible='<%# Eval("Status").ToString() == "Active" %>' CssClass="btn-icon danger" ToolTip="Delete" OnClientClick="return confirm('Delete this maintenance entry?');" style="text-decoration: none; color: inherit;">
                      <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="3 6 5 6 21 6"/><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/><line x1="10" y1="11" x2="10" y2="17"/><line x1="14" y1="11" x2="14" y2="17"/></svg>
                    </asp:LinkButton>
                  </div>
                </ItemTemplate>
              </asp:TemplateField>
            </Columns>
          </asp:GridView>
        </div>
      </asp:Panel>
    </div>

    <asp:Panel ID="pnlModal" runat="server" Visible="false" CssClass="modal-overlay">
      <div class="modal-card">
        <div class="modal-header">
          <h3>Schedule Vehicle Maintenance</h3>
          <asp:LinkButton ID="btnCloseModal" runat="server" CssClass="modal-close" OnClick="btnCloseModal_Click" CausesValidation="false">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>
          </asp:LinkButton>
        </div>
        
        <asp:Label ID="lblModalError" runat="server" ForeColor="Red" Visible="false" style="display:block; margin-bottom: 10px; font-weight: bold; font-size: 0.85rem;"></asp:Label>

        <div class="form-field">
          <label class="form-label">Vehicle</label>
          <asp:DropDownList ID="ddlVehicle" runat="server" CssClass="form-select">
             <asp:ListItem Text="-- Select Vehicle --" Value=""></asp:ListItem>
             <asp:ListItem Text="Sprinter Van (MH-12-AB-4521) — Available" Value="MH-12-AB-4521"></asp:ListItem>
             <asp:ListItem Text="Box Truck (MH-14-XY-9081) — Available" Value="MH-14-XY-9081"></asp:ListItem>
          </asp:DropDownList>
        </div>
        <div class="form-field">
          <label class="form-label">Service Type</label>
          <asp:DropDownList ID="ddlType" runat="server" CssClass="form-select">
            <asp:ListItem Text="Routine Oil Change" Value="Routine Oil Change"></asp:ListItem>
            <asp:ListItem Text="Tire Rotation/Replacement" Value="Tire Rotation/Replacement"></asp:ListItem>
            <asp:ListItem Text="Brake Pad Service" Value="Brake Pad Service"></asp:ListItem>
            <asp:ListItem Text="Engine Repair" Value="Engine Repair"></asp:ListItem>
            <asp:ListItem Text="Body work" Value="Body work"></asp:ListItem>
          </asp:DropDownList>
        </div>
        <div class="form-field">
          <label class="form-label">Estimated Cost ($)</label>
          <asp:TextBox ID="txtCost" runat="server" CssClass="form-input" TextMode="Number" placeholder="e.g. 450"></asp:TextBox>
        </div>
        <div class="form-row">
          <div class="form-field">
            <label class="form-label">Start Date</label>
            <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-input" TextMode="Date"></asp:TextBox>
          </div>
          <div class="form-field">
            <label class="form-label">Est. Completion</label>
            <asp:TextBox ID="txtEstCompletion" runat="server" CssClass="form-input" TextMode="Date"></asp:TextBox>
          </div>
        </div>
        <div class="form-actions">
          <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn-cancel" OnClick="btnCloseModal_Click" CausesValidation="false">Cancel</asp:LinkButton>
          <asp:Button ID="btnSubmit" runat="server" Text="Schedule" CssClass="btn-submit" OnClick="btnSubmit_Click" />
        </div>
      </div>
    </asp:Panel>
  </div>
</asp:Content>
