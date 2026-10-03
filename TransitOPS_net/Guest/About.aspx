<%@ Page Title="About Us - TransitOps" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="TransitOPS_net.Guest.About" %>

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

        .to-team-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 20px;
        }
        @media (min-width: 768px) {
            .to-team-grid { grid-template-columns: repeat(2, 1fr); }
        }
        @media (min-width: 1024px) {
            .to-team-grid { grid-template-columns: repeat(4, 1fr); }
        }
        .to-team-card {
            background: #ffffff;
            border: 1px solid var(--to-line);
            border-radius: 14px;
            padding: 28px 24px;
            text-align: center;
        }
        .to-team-card:hover {
            border-color: var(--to-line-strong);
            box-shadow: 0 2px 8px rgba(16,24,40,.04);
        }
        .to-team-avatar {
            width: 56px;
            height: 56px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 16px;
            font-size: 15px;
            font-weight: 700;
        }
        .to-team-name {
            font-size: 15.5px;
            font-weight: 650;
            color: var(--to-ink);
            margin-bottom: 4px;
        }
        .to-team-role {
            font-size: 13.5px;
            color: var(--to-ink-muted);
            margin: 0;
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
            <span class="to-eyebrow">About TransitOps</span>
            <h1 class="to-h2" style="font-size: clamp(2.3rem, 4.5vw, 3.4rem); font-weight: 700; letter-spacing: -0.04em; max-width: 760px; margin: 0 auto 20px;">
                A <span class="to-gradient-text">calmer, clearer</span> way to run a fleet
            </h1>
            <p class="to-lead" style="max-width: 560px;">
                TransitOps is an all-in-one transport operations platform that automates the busywork of dispatch, maintenance, and cost tracking — so operations teams spend their energy on the road, not the paperwork.
            </p>
        </section>

        <!-- Our Story Section -->
        <section class="to-section hairline-t">
            <div class="landing-container">
                <div class="to-section-head">
                    <span class="to-eyebrow">Our Story</span>
                    <h2 class="to-h2">Built for the teams that keep the world moving</h2>
                    <p class="to-lead" style="max-width: 680px;">
                        We watched operations teams juggle disconnected logbooks, printed license checklists, and fuel receipts stuffed in gloveboxes. TransitOps replaces all of it with one platform — where a completed trip creates its own fuel log, and a maintenance order posts its own expense. No double entry, no missing receipts.
                    </p>
                </div>
            </div>
        </section>

        <!-- Values Section -->
        <section class="to-section hairline-t">
            <div class="landing-container">
                <div class="to-section-head">
                    <span class="to-eyebrow">What We Believe</span>
                    <h2 class="to-h2">Four values, one platform</h2>
                </div>
                <div class="to-grid to-grid-2">
                    <asp:Repeater ID="rptValues" runat="server">
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

        <!-- Stats Section -->
        <section class="to-section hairline-t">
            <div class="landing-container">
                <div class="to-stats" style="border: 1px solid var(--to-line); border-radius: 16px; padding: 40px 24px; background: #ffffff;">
                    <asp:Repeater ID="rptStats" runat="server">
                        <ItemTemplate>
                            <div class="to-stat">
                                <div class="to-stat-value" style="color: var(--to-ink);"><%# Eval("Value") %></div>
                                <div class="to-stat-label"><%# Eval("Label") %></div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </section>

        <!-- Team Section -->
        <section class="to-section hairline-t">
            <div class="landing-container">
                <div class="to-section-head">
                    <span class="to-eyebrow">The Team</span>
                    <h2 class="to-h2">People who sweat the details</h2>
                </div>
                <div class="to-team-grid">
                    <asp:Repeater ID="rptTeam" runat="server">
                        <ItemTemplate>
                            <div class="to-team-card">
                                <div class='<%# "to-team-avatar " + Eval("ColorClass") %>'>
                                    <%# Eval("Initials") %>
                                </div>
                                <h3 class="to-team-name"><%# Eval("Name") %></h3>
                                <p class="to-team-role"><%# Eval("Role") %></p>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </section>

        <!-- CTA Section -->
        <section class="to-section hairline-t to-cta">
            <div class="rainbow-line"></div>
            <div class="landing-container">
                <h2 class="to-cta-title">Come <span class="to-gradient-text">run your fleet</span> with us</h2>
                <p class="to-cta-sub">
                    Set up a workspace in minutes and see what calm, clear operations feel like.
                </p>
                <div class="to-hero-actions" style="justify-content: center;">
                    <a href='<%= ResolveUrl("~/Guest/SignUp.aspx") %>' class="to-btn to-btn-primary to-btn-lg">Get Started Free</a>
                    <a href='<%= ResolveUrl("~/Guest/Contact.aspx") %>' class="to-btn to-btn-light to-btn-lg">Contact Us</a>
                </div>
            </div>
        </section>
    </div>
</asp:Content>
