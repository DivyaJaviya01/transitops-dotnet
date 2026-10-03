<%@ Page Title="Contact Us - TransitOps" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="TransitOPS_net.Guest.Contact" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .contact-hero {
            padding: 4rem 1.5rem 3rem;
            text-align: center;
            background: linear-gradient(135deg, #0f172a, #1e293b);
            color: #ffffff;
            border-radius: 1rem;
            margin-bottom: 3rem;
        }
        .contact-hero h1 {
            font-size: 2.75rem;
            font-weight: 800;
            margin-bottom: 1rem;
            background: linear-gradient(to right, #38bdf8, #818cf8);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .contact-hero p {
            font-size: 1.2rem;
            color: #94a3b8;
            max-width: 40rem;
            margin: 0 auto;
        }
        .contact-layout {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 3rem;
            margin-bottom: 3rem;
        }
        .contact-form-card {
            background: #ffffff;
            border-radius: 0.75rem;
            padding: 2.5rem;
            border: 1px solid #e2e8f0;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
        }
        .contact-form-card h3 {
            font-size: 1.5rem;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 1.5rem;
        }
        .form-group {
            margin-bottom: 1.25rem;
        }
        .form-group label {
            display: block;
            font-weight: 600;
            color: #334155;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
        }
        .form-control-custom {
            width: 100%;
            padding: 0.75rem 1rem;
            border-radius: 0.5rem;
            border: 1px solid #cbd5e1;
            font-size: 0.95rem;
            transition: border-color 0.2s, box-shadow 0.2s;
        }
        .form-control-custom:focus {
            outline: none;
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.15);
        }
        .btn-submit-contact {
            width: 100%;
            padding: 0.875rem;
            background: #2563eb;
            color: #ffffff;
            font-weight: 600;
            border: none;
            border-radius: 0.5rem;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        .btn-submit-contact:hover {
            background: #1d4ed8;
        }
        .contact-info-card {
            background: #f8fafc;
            border-radius: 0.75rem;
            padding: 2.5rem;
            border: 1px solid #e2e8f0;
        }
        .info-item {
            margin-bottom: 2rem;
        }
        .info-item h4 {
            font-size: 1.1rem;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 0.5rem;
        }
        .info-item p {
            color: #64748b;
            margin: 0;
            line-height: 1.5;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container my-4">
        <section class="contact-hero" id="contact-hero-section">
            <h1>Get in Touch with Our Team</h1>
            <p>Have questions about features, pricing, or enterprise integrations? We're here to help.</p>
        </section>

        <section class="contact-layout" id="contact-content">
            <div class="contact-form-card">
                <h3>Send Us a Message</h3>
                <div class="form-group">
                    <label for="txtName">Full Name</label>
                    <input type="text" id="txtName" class="form-control-custom" placeholder="John Doe" required />
                </div>
                <div class="form-group">
                    <label for="txtEmail">Email Address</label>
                    <input type="email" id="txtEmail" class="form-control-custom" placeholder="john@transitcompany.com" required />
                </div>
                <div class="form-group">
                    <label for="ddlSubject">Subject / Department</label>
                    <select id="ddlSubject" class="form-control-custom">
                        <option value="Sales">Sales Inquiry</option>
                        <option value="Support">Technical Support</option>
                        <option value="Partnership">Partnership Opportunities</option>
                        <option value="General">General Questions</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="txtMessage">Message</label>
                    <textarea id="txtMessage" class="form-control-custom" rows="4" placeholder="How can we help your fleet?" required></textarea>
                </div>
                <button type="button" class="btn-submit-contact" id="btnSubmitContact">Send Message</button>
            </div>

            <div class="contact-info-card">
                <div class="info-item">
                    <h4>📍 Head Office</h4>
                    <p>TransitOps Technologies Inc.<br />100 Mobility Boulevard, Suite 500<br />San Francisco, CA 94105</p>
                </div>
                <div class="info-item">
                    <h4>📧 Email & Support</h4>
                    <p>Sales: sales@transitops.io<br />Support: support@transitops.io</p>
                </div>
                <div class="info-item">
                    <h4>📞 Phone Support</h4>
                    <p>Mon - Fri, 8:00 AM - 6:00 PM EST<br />+1 (800) 555-TRAN</p>
                </div>
            </div>
        </section>
    </div>
</asp:Content>
