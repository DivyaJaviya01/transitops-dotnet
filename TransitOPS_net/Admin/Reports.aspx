<%@ Page Title="Reports" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="TransitOPS_net.Admin.Reports" %>

<asp:Content ID="c1" ContentPlaceHolderID="TitleContent" runat="server">Reports - TransitOps Admin</asp:Content>

<asp:Content ID="c2" ContentPlaceHolderID="head" runat="server">
    <style>
        .grid-layout { display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem; margin-top: 1rem; }
        .section-title { font-family: 'Geist', sans-serif; font-weight: 700; letter-spacing: -0.01em; margin-bottom: 0.75rem; font-size: 1rem; color: var(--text-primary); }
        .selected-row { background-color: rgba(27,67,50,0.04) !important; }
        .stat-group { border-bottom: 1px solid var(--border-color); padding-bottom: 0.75rem; margin-bottom: 0.75rem; }
    </style>
</asp:Content>

<asp:Content ID="c3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content-wrapper">
        <div class="page-header">
            <div>
                <h1>Reports & Analytics</h1>
                <p>Analyze vehicle efficiency, ROI metrics, and export reports</p>
            </div>
            <div class="page-header-actions">
                <asp:LinkButton ID="btnExport" runat="server" CssClass="btn-ghost" OnClick="btnExport_Click" style="display: flex; align-items: center; gap: 0.4rem; text-decoration: none; color: inherit;">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="7 10 12 15 17 10"/><line x1="12" y1="15" x2="12" y2="3"/></svg> Export Fleet CSV
                </asp:LinkButton>
            </div>
        </div>

        <div class="grid-layout">
            <!-- Fleet Assets -->
            <div>
                <h3 class="section-title">Fleet Assets</h3>
                <asp:Panel ID="pnlEmpty" runat="server" Visible="false">
                    <p class="empty-state">No vehicles registered yet.</p>
                </asp:Panel>

                <asp:Panel ID="pnlTable" runat="server" CssClass="table-card">
                    <div class="table-wrap">
                        <asp:GridView ID="gvVehicles" runat="server" AutoGenerateColumns="false" GridLines="None" ShowHeader="true" DataKeyNames="RegistrationNumber" OnSelectedIndexChanged="gvVehicles_SelectedIndexChanged">
                            <SelectedRowStyle CssClass="selected-row" />
                            <Columns>
                                <asp:TemplateField HeaderText="Vehicle">
                                    <ItemTemplate>
                                        <strong style="font-weight: 700;"><%# Eval("Name") %> (<%# Eval("RegistrationNumber") %>)</strong>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Type" HeaderText="Type" />
                                <asp:TemplateField HeaderText="Action">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnSelect" runat="server" CommandName="Select" CssClass="btn-ghost" style="font-size: 0.72rem; padding: 0.2rem 0.6rem; text-decoration: none; color: inherit;">
                                            Analyze
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </asp:Panel>
            </div>

            <!-- Analysis View -->
            <div>
                <h3 class="section-title">Vehicle Telemetry & ROI</h3>
                
                <asp:Panel ID="pnlNoSelection" runat="server" CssClass="table-card" style="padding: 2.5rem; text-align: center;">
                    <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="var(--accent-brand)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="margin-bottom: 1rem;"><polyline points="22 12 18 12 15 21 9 3 6 12 2 12"/></svg>
                    <p class="empty-state">Select an asset from the left table to load financial and efficiency analytics.</p>
                </asp:Panel>

                <asp:Panel ID="pnlAnalytics" runat="server" Visible="false" CssClass="table-card" style="padding: 1.5rem;">
                    <h3 style="font-family: 'Geist', sans-serif; font-weight: 700; letter-spacing: -0.01em; margin-bottom: 1rem; font-size: 1.1rem; color: var(--text-primary);">
                        <asp:Label ID="lblSelectedVehicle" runat="server"></asp:Label> Analytics
                    </h3>
                    
                    <div style="display: flex; flex-direction: column;">
                        <div class="stat-group">
                            <div class="stat-card-label">Fuel Efficiency</div>
                            <div style="font-weight: 700; font-size: 1.1rem;"><asp:Label ID="lblFuel" runat="server"></asp:Label> km / Liter</div>
                        </div>
                        <div class="stat-group">
                            <div class="stat-card-label">Total Distance Traveled</div>
                            <div style="font-weight: 700; font-size: 1.1rem;"><asp:Label ID="lblDistance" runat="server"></asp:Label> km</div>
                        </div>
                        <div class="stat-group">
                            <div class="stat-card-label">Operational Costs</div>
                            <div style="font-weight: 700; font-size: 1.1rem; color: #f87171;">-$<asp:Label ID="lblCost" runat="server"></asp:Label></div>
                        </div>
                        <div class="stat-group">
                            <div class="stat-card-label">Estimated Revenue</div>
                            <div style="font-weight: 700; font-size: 1.1rem; color: var(--accent-brand);">+$<asp:Label ID="lblRevenue" runat="server"></asp:Label></div>
                        </div>
                        <div style="margin-top: 0.75rem;">
                            <div class="stat-card-label">Asset ROI</div>
                            <div style="font-weight: 800; font-size: 1.5rem;">
                                <asp:Label ID="lblROI" runat="server"></asp:Label>%
                            </div>
                        </div>
                    </div>
                </asp:Panel>
            </div>
        </div>
    </div>
</asp:Content>
