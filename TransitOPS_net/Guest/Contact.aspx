<%@ Page Title="Contact Us - TransitOps" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="TransitOPS_net.Guest.Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .to-contact-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 48px;
        }
        @media (min-width: 1024px) {
            .to-contact-grid {
                grid-template-columns: 1fr 1fr;
                gap: 72px;
            }
        }

        .to-form {
            display: flex;
            flex-direction: column;
            gap: 18px;
        }
        .to-field {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        .to-field label {
            font-size: 13.5px;
            font-weight: 600;
            color: var(--to-ink);
        }
        .to-input,
        .to-textarea,
        .to-select {
            width: 100%;
            border: 1px solid var(--to-line-strong);
            border-radius: 10px;
            padding: 12px 16px;
            font-size: 14.5px;
            font-family: inherit;
            color: var(--to-ink);
            background: #ffffff;
            transition: border-color 0.2s ease, box-shadow 0.2s ease;
            box-sizing: border-box;
        }
        .to-input:focus,
        .to-textarea:focus,
        .to-select:focus {
            outline: none;
            border-color: var(--to-accent);
            box-shadow: 0 0 0 3px rgba(27, 67, 50, 0.12);
        }
        .to-textarea {
            min-height: 130px;
            resize: vertical;
        }

        .to-contact-info {
            display: flex;
            flex-direction: column;
            gap: 14px;
        }
        .to-contact-item {
            display: flex;
            align-items: flex-start;
            gap: 14px;
            padding: 20px 22px;
            border: 1px solid var(--to-line);
            border-radius: 12px;
            background: #ffffff;
        }
        .to-contact-icon {
            flex: none;
            width: 38px;
            height: 38px;
            border-radius: 9px;
            background: var(--to-accent-soft);
            color: var(--to-accent);
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .to-contact-item h4 {
            font-size: 14.5px;
            font-weight: 650;
            color: var(--to-ink);
            margin: 0 0 4px;
        }
        .to-contact-item p {
            font-size: 14px;
            color: var(--to-ink-soft);
            margin: 0;
            line-height: 1.55;
        }
        .to-form-note {
            font-size: 12.5px;
            color: var(--to-ink-muted);
            text-align: center;
            margin: 0;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="landing-body">
        <!-- Page Hero -->
        <section class="landing-container to-page-hero" style="padding-top: 140px; padding-bottom: 70px; text-align: center;">
            <span class="to-eyebrow">Contact</span>
            <h1 class="to-h2" style="font-size: clamp(2.3rem, 4.5vw, 3.4rem); font-weight: 700; letter-spacing: -0.04em; max-width: 760px; margin: 0 auto 20px;">
                Talk to the <span class="to-gradient-text">team behind TransitOps</span>
            </h1>
            <p class="to-lead" style="max-width: 560px;">
                Questions about pricing, onboarding, or a custom setup? We usually reply within one business day.
            </p>
        </section>

        <!-- Main Section -->
        <section class="to-section hairline-t">
            <div class="landing-container">
                <div class="to-contact-grid">
                    <!-- Left: Form or Success State -->
                    <div>
                        <asp:Panel ID="pnlSuccess" runat="server" Visible="false" CssClass="to-card" style="text-align: center; padding: 48px 32px;">
                            <div style="width: 48px; height: 48px; border-radius: 50%; background: var(--to-accent-soft); color: var(--to-accent); display: flex; align-items: center; justify-content: center; margin: 0 auto 18px;">
                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
                                    <polyline points="22 4 12 14.01 9 11.01"></polyline>
                                </svg>
                            </div>
                            <h3 class="to-card-title" style="font-size: 20px;">Message sent</h3>
                            <p class="to-card-desc" style="max-width: 320px; margin: 0 auto;">
                                Thanks for reaching out. Our team will get back to you within one business day.
                            </p>
                        </asp:Panel>

                        <asp:Panel ID="pnlForm" runat="server" CssClass="to-form">
                            <div class="to-field">
                                <label for="<%= txtName.ClientID %>">Full name</label>
                                <asp:TextBox ID="txtName" runat="server" CssClass="to-input" placeholder="Jane Cooper" />
                                <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" ErrorMessage="Full name is required." Display="Dynamic" ForeColor="Red" Font-Size="12px" />
                            </div>

                            <div class="to-field">
                                <label for="<%= txtEmail.ClientID %>">Work email</label>
                                <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="to-input" placeholder="jane@company.com" />
                                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Work email is required." Display="Dynamic" ForeColor="Red" Font-Size="12px" />
                                <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" ErrorMessage="Enter a valid email address." Display="Dynamic" ForeColor="Red" Font-Size="12px" />
                            </div>

                            <div class="to-field">
                                <label for="<%= txtCompany.ClientID %>">Company</label>
                                <asp:TextBox ID="txtCompany" runat="server" CssClass="to-input" placeholder="Acme Logistics" />
                            </div>

                            <div class="to-field">
                                <label for="<%= ddlSubject.ClientID %>">What can we help with?</label>
                                <asp:DropDownList ID="ddlSubject" runat="server" CssClass="to-select">
                                    <asp:ListItem Text="General question" Value="General question" Selected="True" />
                                    <asp:ListItem Text="Sales &amp; pricing" Value="Sales &amp; pricing" />
                                    <asp:ListItem Text="Onboarding &amp; training" Value="Onboarding &amp; training" />
                                    <asp:ListItem Text="Partnership" Value="Partnership" />
                                    <asp:ListItem Text="Something else" Value="Something else" />
                                </asp:DropDownList>
                            </div>

                            <div class="to-field">
                                <label for="<%= txtMessage.ClientID %>">Message</label>
                                <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Rows="4" CssClass="to-textarea" placeholder="Tell us about your fleet..." />
                                <asp:RequiredFieldValidator ID="rfvMessage" runat="server" ControlToValidate="txtMessage" ErrorMessage="Message is required." Display="Dynamic" ForeColor="Red" Font-Size="12px" />
                            </div>

                            <asp:Button ID="btnSubmit" runat="server" Text="Send Message" CssClass="to-btn to-btn-primary to-btn-lg" OnClick="btnSubmit_Click" />

                            <p class="to-form-note">
                                By submitting, you agree to our Privacy Policy. We never share your data.
                            </p>
                        </asp:Panel>
                    </div>

                    <!-- Right: Contact Info -->
                    <div class="to-contact-info">
                        <div class="to-contact-item">
                            <span class="to-contact-icon">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path>
                                    <polyline points="22,6 12,13 2,6"></polyline>
                                </svg>
                            </span>
                            <div>
                                <h4>Email</h4>
                                <p>hello@transitops.dev</p>
                            </div>
                        </div>

                        <div class="to-contact-item">
                            <span class="to-contact-icon">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path>
                                </svg>
                            </span>
                            <div>
                                <h4>Phone</h4>
                                <p>+1 (555) 010-2030</p>
                            </div>
                        </div>

                        <div class="to-contact-item">
                            <span class="to-contact-icon">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path>
                                    <circle cx="12" cy="10" r="3"></circle>
                                </svg>
                            </span>
                            <div>
                                <h4>Office</h4>
                                <p>Operations Hub, Fleet District, Bengaluru, India</p>
                            </div>
                        </div>

                        <div class="to-card" style="margin-top: 6px;">
                            <h3 class="to-card-title">Prefer to start right away?</h3>
                            <p class="to-card-desc" style="margin-bottom: 20px;">
                                Set up a workspace in minutes — no credit card required. No sales call needed to see the product.
                            </p>
                            <a href='<%= ResolveUrl("~/Guest/SignUp.aspx") %>' class="to-btn to-btn-primary to-btn-lg">Get Started Free</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</asp:Content>
