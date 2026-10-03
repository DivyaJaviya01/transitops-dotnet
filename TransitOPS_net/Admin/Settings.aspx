<%@ Page Title="Settings" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="TransitOPS_net.Admin.Settings" %>

<asp:Content ID="c1" ContentPlaceHolderID="TitleContent" runat="server">Settings - TransitOps Admin</asp:Content>

<asp:Content ID="c2" ContentPlaceHolderID="head" runat="server">
    <style>
        .settings-container { display: flex; flex-direction: column; gap: 1.5rem; max-width: 640px; }
        .graph-card { background: #fff; padding: 1.5rem; border-radius: 12px; border: 1px solid var(--border-color); box-shadow: 0 1px 3px rgba(0,0,0,0.02); }
        .graph-header h3 { display: flex; align-items: center; gap: 0.5rem; font-family: 'Geist', sans-serif; font-size: 1.1rem; color: var(--text-primary); margin-bottom: 1.5rem; }
        
        .settings-form-group { margin-bottom: 1rem; }
        .settings-label { display: block; font-size: 0.85rem; font-weight: 500; color: var(--text-secondary); margin-bottom: 0.4rem; }
        .settings-input { width: 100%; padding: 0.6rem 0.75rem; border: 1px solid var(--input-border); border-radius: 6px; font-size: 0.95rem; color: var(--text-primary); }
        .settings-input:focus { outline: none; border-color: var(--primary-color); box-shadow: 0 0 0 3px rgba(45, 106, 79, 0.1); }
        
        .role-text { color: var(--text-secondary); font-size: 0.9rem; margin: 0; }
        .role-strong { color: var(--text-primary); font-weight: 600; }
        .role-subtext { color: var(--text-secondary); font-size: 0.85rem; margin-top: 0.5rem; }

        .checkbox-container { display: flex; align-items: center; gap: 0.75rem; cursor: pointer; color: var(--text-primary); font-size: 0.95rem; }
        .checkbox-input { width: 18px; height: 18px; accent-color: #1b4332; cursor: pointer; }

        .save-button-wrapper { margin-top: 0.5rem; }
        .alert-success { background-color: #d1fae5; color: #065f46; padding: 0.75rem 1rem; border-radius: 6px; font-size: 0.9rem; font-weight: 500; display: inline-flex; align-items: center; gap: 0.5rem; margin-bottom: 1.5rem; border: 1px solid #10b981; }
    </style>
</asp:Content>

<asp:Content ID="c3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="content-wrapper">
        <div class="page-header">
            <div>
                <h1>Settings</h1>
                <p>Manage your account preferences and notifications.</p>
            </div>
        </div>

        <asp:Panel ID="pnlSuccess" runat="server" Visible="false" CssClass="alert-success">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>
            <asp:Literal ID="litSuccessMsg" runat="server">Preferences saved successfully!</asp:Literal>
        </asp:Panel>

        <div class="settings-container">
            <!-- Profile Section -->
            <div class="graph-card">
                <div class="graph-header" style="margin-bottom: 1rem;">
                    <h3>
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#1b4332" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
                        Profile
                    </h3>
                </div>
                <div>
                    <div class="settings-form-group">
                        <label class="settings-label">Full Name</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="settings-input"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" ErrorMessage="Name is required" ForeColor="Red" Display="Dynamic" style="font-size: 0.8rem; margin-top: 4px; display: block;" />
                    </div>
                    <div class="settings-form-group" style="margin-bottom: 0;">
                        <label class="settings-label">Email</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="settings-input" TextMode="Email"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required" ForeColor="Red" Display="Dynamic" style="font-size: 0.8rem; margin-top: 4px; display: block;" />
                    </div>
                </div>
            </div>

            <!-- Role & Permissions Section -->
            <div class="graph-card">
                <div class="graph-header" style="margin-bottom: 1rem;">
                    <h3>
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#1b4332" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/></svg>
                        Role & Permissions
                    </h3>
                </div>
                <div>
                    <p class="role-text">
                        Current role: <asp:Label ID="lblRole" runat="server" CssClass="role-strong">Admin</asp:Label>
                    </p>
                    <p class="role-subtext">
                        Role-based access is managed by your administrator. Contact your fleet manager to request role changes.
                    </p>
                </div>
            </div>

            <!-- Notifications Section -->
            <div class="graph-card">
                <div class="graph-header" style="margin-bottom: 1rem;">
                    <h3>
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#1b4332" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"/><path d="M13.73 21a2 2 0 0 1-3.46 0"/></svg>
                        Notifications
                    </h3>
                </div>
                <div>
                    <label class="checkbox-container">
                        <asp:CheckBox ID="chkNotifications" runat="server" CssClass="checkbox-input" />
                        Enable email notifications for trip updates, maintenance alerts, and system announcements
                    </label>
                </div>
            </div>

            <!-- Save Button -->
            <div class="save-button-wrapper">
                <asp:LinkButton ID="btnSave" runat="server" CssClass="btn-primary" style="width: fit-content; display: inline-flex; align-items: center; gap: 0.5rem; text-decoration: none;" OnClick="btnSave_Click">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"/><polyline points="17 21 17 13 7 13 7 21"/><polyline points="7 3 7 8 15 8"/></svg>
                    Save Preferences
                </asp:LinkButton>
            </div>
        </div>
    </div>
</asp:Content>
