<%@ Page Title="Features - TransitOps" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Features.aspx.cs" Inherits="TransitOPS_net.Guest.Features" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .to-icon-tile {
            width: 42px;
            height: 42px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 20px;
        }
        .to-icon-tile.is-blue { background: rgba(59, 130, 246, 0.1); color: #2563eb; }
        .to-icon-tile.is-green { background: var(--to-accent-soft); color: var(--to-accent); }
        .to-icon-tile.is-orange { background: rgba(245, 158, 11, 0.1); color: #d97706; }
        .to-icon-tile.is-pink { background: rgba(236, 72, 153, 0.1); color: #db2777; }

        .to-table-wrap {
            border: 1px solid var(--to-line-strong);
            border-radius: 14px;
            overflow: hidden;
            background: #ffffff;
        }
        .to-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14.5px;
        }
        .to-table th {
            text-align: left;
            font-size: 12.5px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.1em;
            color: var(--to-ink-muted);
            padding: 16px 24px;
            border-bottom: 1px solid var(--to-line);
            background: #fafbfc;
        }
        .to-table td {
            padding: 16px 24px;
            border-bottom: 1px solid var(--to-line);
            color: var(--to-ink-soft);
            vertical-align: top;
        }
        .to-table tr:last-child td {
            border-bottom: none;
        }
        .to-table td:first-child {
            color: var(--to-ink);
            font-weight: 600;
        }
        .rainbow-line {
            height: 2px;
            background: linear-gradient(90deg, #3b82f6, #10b981, #f59e0b, #ec4899);
            width: 100%;
            margin-bottom: 40px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="landing-body">
        <!-- Page Hero -->
        <section class="landing-container to-page-hero" style="padding-top: 140px; padding-bottom: 70px; text-align: center;">
            <span class="to-eyebrow">Everything Included</span>
            <h1 class="to-h2" style="font-size: clamp(2.3rem, 4.5vw, 3.4rem); font-weight: 700; letter-spacing: -0.04em; max-width: 760px; margin: 0 auto 20px;">
                One platform for the <span class="to-gradient-text">entire fleet lifecycle</span>
            </h1>
            <p class="to-lead" style="max-width: 560px;">
                Seven modules that talk to each other — from acquisition and driver compliance to dispatch, maintenance, and cost analytics. Nothing gets lost between a fuel log and a work order.
            </p>
        </section>

        <!-- Seven Modules Section -->
        <section class="to-section hairline-t">
            <div class="landing-container">
                <div class="to-section-head">
                    <h2 class="to-h2">The seven modules</h2>
                    <p class="to-lead">Every module enforces the business rules that keep your operations honest.</p>
                </div>
                <div class="to-grid to-grid-3">
                    <asp:Repeater ID="rptModules" runat="server">
                        <ItemTemplate>
                            <div class="to-card">
                                <div class='<%# "to-icon-tile " + Eval("ColorClass") %>'>
                                    <%# Eval("IconSvg") %>
                                </div>
                                <h3 class="to-card-title"><%# Eval("Title") %></h3>
                                <p class="to-card-desc"><%# Eval("Description") %></p>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </section>

        <!-- Business Rules Section -->
        <section class="to-section hairline-t" id="business-rules">
            <div class="landing-container">
                <div class="to-section-head">
                    <span class="to-eyebrow">Powered by Business Rules</span>
                    <h2 class="to-h2">Software that guards the details your team forgets</h2>
                    <p class="to-lead">
                        Ten mandatory business rules keep the fleet safe — from capacity checks to license expiry validation.
                    </p>
                </div>
                <div class="to-table-wrap">
                    <asp:GridView ID="gvBusinessRules" runat="server" AutoGenerateColumns="False" CssClass="to-table" GridLines="None">
                        <Columns>
                            <asp:BoundField DataField="RuleId" HeaderText="Rule" ItemStyle-Width="90px" HeaderStyle-Width="90px" />
                            <asp:BoundField DataField="Name" HeaderText="Name" ItemStyle-Width="280px" HeaderStyle-Width="280px" />
                            <asp:BoundField DataField="Description" HeaderText="What it enforces" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </section>

        <!-- CTA Section -->
        <section class="to-section hairline-t to-cta">
            <div class="rainbow-line"></div>
            <div class="landing-container">
                <h2 class="to-cta-title">Ready to take your fleet operations seriously?</h2>
                <p class="to-cta-sub">
                    Set up a workspace in minutes and get your fleet, drivers, and trips on one calm, clear platform today.
                </p>
                <div class="to-hero-actions" style="justify-content: center;">
                    <a href='<%= ResolveUrl("~/Guest/SignUp.aspx") %>' class="to-btn to-btn-primary to-btn-lg">
                        Get Started Free
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M5 12h14"></path>
                            <path d="m12 5 7 7-7 7"></path>
                        </svg>
                    </a>
                    <a href='<%= ResolveUrl("~/Guest/Contact.aspx") %>' class="to-btn to-btn-light to-btn-lg">Talk to Sales</a>
                </div>
            </div>
        </section>
    </div>
</asp:Content>
