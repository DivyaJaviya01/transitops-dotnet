<%@ Page Title="Pricing - TransitOps" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Pricing.aspx.cs" Inherits="TransitOPS_net.Guest.Pricing" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .to-pricing-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 20px;
            align-items: stretch;
        }
        @media (min-width: 1024px) {
            .to-pricing-grid {
                grid-template-columns: repeat(3, 1fr);
            }
        }

        .to-price-card {
            background: #ffffff;
            border: 1px solid var(--to-line);
            border-radius: 16px;
            padding: 36px 32px;
            display: flex;
            flex-direction: column;
            position: relative;
        }
        .to-price-card.is-featured {
            border: 1.5px solid var(--to-ink);
            box-shadow: 0 2px 4px rgba(17, 24, 39, 0.05), 0 24px 64px rgba(17, 24, 39, 0.1);
        }

        .to-price-tag {
            position: absolute;
            top: -13px;
            left: 50%;
            transform: translateX(-50%);
            background: var(--to-ink);
            color: #ffffff;
            font-size: 12px;
            font-weight: 650;
            letter-spacing: 0.04em;
            padding: 5px 14px;
            border-radius: 999px;
            white-space: nowrap;
        }
        .to-price-name {
            font-size: 16px;
            font-weight: 650;
            color: var(--to-ink);
            margin-bottom: 6px;
        }
        .to-price-desc {
            font-size: 14px;
            color: var(--to-ink-soft);
            line-height: 1.6;
            margin-bottom: 28px;
        }

        .to-price-amount {
            display: flex;
            align-items: baseline;
            gap: 6px;
            margin-bottom: 28px;
        }
        .to-price-amount .amount {
            font-size: 2.6rem;
            font-weight: 700;
            letter-spacing: -0.04em;
            color: var(--to-ink);
            line-height: 1;
        }
        .to-price-amount .period {
            font-size: 14px;
            color: var(--to-ink-muted);
        }

        .to-price-list {
            list-style: none;
            margin: 0 0 32px;
            padding: 0;
            display: flex;
            flex-direction: column;
            gap: 13px;
            flex: 1;
        }
        .to-price-list li {
            display: flex;
            align-items: flex-start;
            gap: 10px;
            font-size: 14px;
            color: var(--to-ink-soft);
            line-height: 1.55;
        }

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
            vertical-align: middle;
        }
        .to-table tr:last-child td {
            border-bottom: none;
        }
        .to-table td:first-child {
            color: var(--to-ink);
            font-weight: 600;
        }

        .to-faq-list {
            max-width: 760px;
            margin: 0 auto;
            display: flex;
            flex-direction: column;
            gap: 14px;
        }
        .to-faq-item {
            border: 1px solid var(--to-line);
            border-radius: 12px;
            padding: 24px 28px;
            background: #ffffff;
        }
        .to-faq-q {
            font-size: 15.5px;
            font-weight: 650;
            color: var(--to-ink);
            margin: 0 0 10px;
            letter-spacing: -0.01em;
        }
        .to-faq-a {
            font-size: 14.5px;
            line-height: 1.7;
            color: var(--to-ink-soft);
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
            <span class="to-eyebrow">Pricing</span>
            <h1 class="to-h2" style="font-size: clamp(2.3rem, 4.5vw, 3.4rem); font-weight: 700; letter-spacing: -0.04em; max-width: 760px; margin: 0 auto 20px;">
                Simple pricing that <span class="to-gradient-text">scales with your fleet</span>
            </h1>
            <p class="to-lead" style="max-width: 560px;">
                Start free, upgrade when you grow. Every plan includes the full fleet lifecycle — vehicles, drivers, trips, maintenance, and expenses.
            </p>
        </section>

        <!-- Pricing Cards Section -->
        <section class="to-section hairline-t">
            <div class="landing-container">
                <div class="to-pricing-grid">
                    <asp:Repeater ID="rptPlans" runat="server" OnItemDataBound="Plans_ItemDataBound">
                        <ItemTemplate>
                            <div class='<%# Convert.ToBoolean(Eval("IsFeatured")) ? "to-price-card is-featured" : "to-price-card" %>'>
                                <%# Convert.ToBoolean(Eval("IsFeatured")) ? "<span class=\"to-price-tag\">Most Popular</span>" : "" %>
                                <h3 class="to-price-name"><%# Eval("Name") %></h3>
                                <p class="to-price-desc"><%# Eval("Description") %></p>
                                <div class="to-price-amount">
                                    <span class="amount"><%# Eval("Price") %></span>
                                    <span class="period"><%# Eval("Period") %></span>
                                </div>
                                <ul class="to-price-list">
                                    <asp:Repeater ID="rptFeatures" runat="server" DataSource='<%# Eval("Features") %>'>
                                        <ItemTemplate>
                                            <li>
                                                <span style="color: var(--to-accent); display: inline-flex; margin-top: 2px;">
                                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                                                        <polyline points="20 6 9 17 4 12"></polyline>
                                                    </svg>
                                                </span>
                                                <%# Container.DataItem %>
                                            </li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ul>
                                <a href='<%# ResolveUrl(Eval("TargetUrl").ToString()) %>'
                                   class='<%# Convert.ToBoolean(Eval("IsFeatured")) ? "to-btn to-btn-primary to-btn-lg" : "to-btn to-btn-light to-btn-lg" %>'
                                   style="width: 100%; text-align: center;">
                                    <%# Eval("CtaText") %>
                                </a>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </section>

        <!-- Feature Comparison Section -->
        <section class="to-section hairline-t" id="comparison">
            <div class="landing-container">
                <div class="to-section-head">
                    <span class="to-eyebrow">Compare</span>
                    <h2 class="to-h2">What's in each plan</h2>
                </div>
                <div class="to-table-wrap">
                    <asp:GridView ID="gvComparison" runat="server" AutoGenerateColumns="False" CssClass="to-table" GridLines="None">
                        <Columns>
                            <asp:BoundField DataField="Feature" HeaderText="Feature" HeaderStyle-CssClass="to-table-th" ItemStyle-Font-Weight="Bold" />
                            <asp:BoundField DataField="Starter" HeaderText="Starter" HeaderStyle-CssClass="to-table-th" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                            <asp:BoundField DataField="Growth" HeaderText="Growth" HeaderStyle-CssClass="to-table-th" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                            <asp:BoundField DataField="Enterprise" HeaderText="Enterprise" HeaderStyle-CssClass="to-table-th" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </section>

        <!-- FAQ Section -->
        <section class="to-section hairline-t" id="faq">
            <div class="landing-container">
                <div class="to-section-head">
                    <span class="to-eyebrow">FAQ</span>
                    <h2 class="to-h2">Frequently asked questions</h2>
                </div>
                <div class="to-faq-list">
                    <asp:Repeater ID="rptFaqs" runat="server">
                        <ItemTemplate>
                            <div class="to-faq-item">
                                <h3 class="to-faq-q"><%# Eval("Question") %></h3>
                                <p class="to-faq-a"><%# Eval("Answer") %></p>
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
                <h2 class="to-cta-title">Start your <span class="to-gradient-text">free trial</span> today</h2>
                <p class="to-cta-sub">
                    No credit card required. Set up a workspace and put your fleet, drivers, and trips on one calm, clear platform in minutes.
                </p>
                <div class="to-hero-actions" style="justify-content: center;">
                    <a href='<%= ResolveUrl("~/Guest/SignUp.aspx") %>' class="to-btn to-btn-primary to-btn-lg">Get Started Free</a>
                    <a href='<%= ResolveUrl("~/Guest/Contact.aspx") %>' class="to-btn to-btn-light to-btn-lg">Talk to Sales</a>
                </div>
            </div>
        </section>
    </div>
</asp:Content>
