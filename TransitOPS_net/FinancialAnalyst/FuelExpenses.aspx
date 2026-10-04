<%@ Page Title="Fuel and Expenses" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="FuelExpenses.aspx.cs" Inherits="TransitOPS_net.FinancialAnalyst.FuelExpenses" %>
<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">Expenses - TransitOps Admin</asp:Content>
<asp:Content ID="c1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="c2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="page-header">
  <div>
    <h1>Expenses</h1>
    <p>Log operational costs, fuel purchases, and compute vehicle total costs</p>
  </div>
  <div class="page-header-actions">
    <asp:Button ID="btnFuel" runat="server" Text="+ Log Fuel Purchase" CssClass="btn-primary-sm" OnClick="btnFuel_Click" />
    <asp:Button ID="btnExpense" runat="server" Text="+ Record Expense" CssClass="btn-primary-sm" OnClick="btnExpense_Click" />
  </div>
</div>

<div class="table-card" style="padding:1.25rem;margin-bottom:1.5rem">
  <div class="form-field" style="margin-bottom:0">
    <label class="form-label" style="margin-bottom:0.5rem">Operational Cost Calculator</label>
    <asp:DropDownList ID="ddlInspect" runat="server" CssClass="form-select" Style="max-width:400px" AutoPostBack="true" OnSelectedIndexChanged="ddlInspect_Changed" />
  </div>
  <asp:Panel ID="pnlCost" runat="server" Visible="false">
    <div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(150px,1fr));gap:1rem;margin-top:1.25rem;border-top:1px solid var(--border-color);padding-top:1.25rem">
      <div><div class="stat-card-label">Fuel Cost Sum</div><div class="stat-card-value" style="font-size:1.25rem">$<asp:Label ID="lblFuelSum" runat="server" Text="0" /></div></div>
      <div><div class="stat-card-label">General Expenses</div><div class="stat-card-value" style="font-size:1.25rem">$<asp:Label ID="lblExpSum" runat="server" Text="0" /></div></div>
      <div><div class="stat-card-label">Total Cost</div><div class="stat-card-value" style="font-size:1.25rem;color:var(--accent-brand)">$<asp:Label ID="lblTotalCost" runat="server" Text="0" /></div></div>
    </div>
  </asp:Panel>
</div>

<div class="table-card">
  <div class="table-wrap">
    <asp:GridView ID="gvExpenses" runat="server" AutoGenerateColumns="false" GridLines="None" ShowHeader="true" OnRowCommand="gvExpenses_RowCommand">
      <Columns>
        <asp:TemplateField HeaderText="Vehicle">
          <ItemTemplate><span style="font-weight:700"><%# Eval("VehicleName") %> (<%# Eval("VehicleReg") %>)</span></ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="Category" HeaderText="Expense Category" />
        <asp:BoundField DataField="Description" HeaderText="Description" />
        <asp:TemplateField HeaderText="Date">
          <ItemTemplate><%# Eval("ExpenseDate", "{0:M/d/yyyy}") %></ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Cost Amount">
          <ItemTemplate><span style="font-weight:700;color:#f87171">-$<%# Eval("Amount", "{0:N0}") %></span></ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Action">
          <ItemTemplate>
            <asp:LinkButton ID="lnkDelete" runat="server" CssClass="btn-icon danger" ToolTip="Delete" CommandName="DeleteExpense" CommandArgument='<%# Eval("Id") %>' OnClientClick="return confirm('Delete this entry?');">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="3 6 5 6 21 6"/><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/></svg>
            </asp:LinkButton>
          </ItemTemplate>
        </asp:TemplateField>
      </Columns>
    </asp:GridView>
    <asp:Label ID="lblEmpty" runat="server" CssClass="empty-state" Text="No operational expenses logged. Add logs using the buttons above." Visible="false" />
  </div>
</div>

<asp:Panel ID="pnlFuel" runat="server" Visible="false">
  <div class="modal-overlay">
    <div class="modal-card" style="max-width:420px">
      <div class="modal-header">
        <h3>Log Fuel Purchase</h3>
        <asp:Button ID="btnCloseFuel" runat="server" Text="&#10005;" CssClass="modal-close" CausesValidation="false" OnClick="btnCloseFuel_Click" />
      </div>
      <div class="form-field">
        <label class="form-label">Vehicle</label>
        <asp:DropDownList ID="ddlFuelVehicle" runat="server" CssClass="form-select" />
      </div>
      <div class="form-row">
        <div class="form-field">
          <label class="form-label">Liters</label>
          <asp:TextBox ID="txtLiters" runat="server" CssClass="form-input" TextMode="Number" placeholder="e.g. 150" />
          <asp:RequiredFieldValidator ID="rfvLiters" runat="server" ControlToValidate="txtLiters" ErrorMessage="Liters required" ForeColor="Red" Font-Size="12px" ValidationGroup="Fuel" />
        </div>
        <div class="form-field">
          <label class="form-label">Total Cost ($)</label>
          <asp:TextBox ID="txtFuelCost" runat="server" CssClass="form-input" TextMode="Number" placeholder="e.g. 450" />
          <asp:RequiredFieldValidator ID="rfvFuelCost" runat="server" ControlToValidate="txtFuelCost" ErrorMessage="Cost required" ForeColor="Red" Font-Size="12px" ValidationGroup="Fuel" />
        </div>
      </div>
      <div class="form-actions">
        <asp:Button ID="btnCancelFuel" runat="server" Text="Cancel" CssClass="btn-cancel" CausesValidation="false" OnClick="btnCloseFuel_Click" />
        <asp:Button ID="btnSaveFuel" runat="server" Text="Log Purchase" CssClass="btn-submit" ValidationGroup="Fuel" OnClick="btnSaveFuel_Click" />
      </div>
    </div>
  </div>
</asp:Panel>

<asp:Panel ID="pnlExpense" runat="server" Visible="false">
  <div class="modal-overlay">
    <div class="modal-card" style="max-width:420px">
      <div class="modal-header">
        <h3>Record Operational Expense</h3>
        <asp:Button ID="btnCloseExpense" runat="server" Text="&#10005;" CssClass="modal-close" CausesValidation="false" OnClick="btnCloseExpense_Click" />
      </div>
      <div class="form-field">
        <label class="form-label">Vehicle</label>
        <asp:DropDownList ID="ddlExpVehicle" runat="server" CssClass="form-select" />
      </div>
      <div class="form-row">
        <div class="form-field">
          <label class="form-label">Amount ($)</label>
          <asp:TextBox ID="txtAmount" runat="server" CssClass="form-input" TextMode="Number" placeholder="e.g. 200" />
          <asp:RequiredFieldValidator ID="rfvAmount" runat="server" ControlToValidate="txtAmount" ErrorMessage="Amount required" ForeColor="Red" Font-Size="12px" ValidationGroup="Expense" />
        </div>
        <div class="form-field">
          <label class="form-label">Category</label>
          <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-select">
            <asp:ListItem Text="Permit / Tolls" Value="Permit" /><asp:ListItem Text="Insurance Renewal" Value="Insurance" /><asp:ListItem Text="Other Miscellaneous" Value="Other" />
          </asp:DropDownList>
        </div>
      </div>
      <div class="form-field">
        <label class="form-label">Description</label>
        <asp:TextBox ID="txtDesc" runat="server" CssClass="form-input" placeholder="Reason / notes" />
      </div>
      <div class="form-actions">
        <asp:Button ID="btnCancelExpense" runat="server" Text="Cancel" CssClass="btn-cancel" CausesValidation="false" OnClick="btnCloseExpense_Click" />
        <asp:Button ID="btnSaveExpense" runat="server" Text="Record Expense" CssClass="btn-submit" ValidationGroup="Expense" OnClick="btnSaveExpense_Click" />
      </div>
    </div>
  </div>
</asp:Panel>
</asp:Content>
