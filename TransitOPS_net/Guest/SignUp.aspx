<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="TransitOPS_net.Guest.SignUp" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>SignUp - TransitOps</title>
<style>
/* CSS from Login.css */
@import url('https://fonts.googleapis.com/css2?family=Geist:wght@100..900&display=swap');
body { margin: 0; padding: 0; overflow: hidden; }
.auth-page { display: flex; height: 100vh; font-family: 'Geist', sans-serif; background-color: #ffffff; }
.auth-brand-side { flex: 1; display: flex; flex-direction: column; align-items: center; justify-content: center; padding: 1.5rem; position: relative; background-color: #ffffff; }
.auth-brand-content { display: flex; flex-direction: column; align-items: center; gap: 0.9rem; max-width: 400px; text-align: center; }
.auth-brand-logo { width: 56px; height: 56px; border-radius: 12px; overflow: hidden; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06); }
.auth-brand-logo img { width: 100%; height: 100%; object-fit: cover; }
.auth-brand-text h1 { font-family: 'Geist', sans-serif; font-size: 1.9rem; font-weight: 700; color: #111827; margin: 0 0 0.3rem 0; letter-spacing: -0.03em; }
.auth-brand-text p { font-size: 0.88rem; color: #4b5563; margin: 0; line-height: 1.5; }
.auth-brand-decoration { width: 64px; height: 2px; background: #1b4332; opacity: 0.35; }
.auth-brand-footer { position: absolute; bottom: 0.75rem; font-size: 0.65rem; color: #9ca3af; letter-spacing: 0.1em; font-weight: 500; }
.auth-form-side { flex: 1; display: flex; align-items: center; justify-content: center; padding: 1.25rem; background-color: #ffffff; position: relative; border-left: 1px solid #eef0f2; }
.auth-form-container { width: 100%; max-width: 420px; }
.auth-form-container h2 { font-family: 'Geist', sans-serif; font-size: 1.5rem; font-weight: 700; color: #111827; margin: 0 0 0.2rem 0; letter-spacing: -0.03em; }
.auth-form-container .form-subtitle { color: #4b5563; font-size: 0.82rem; margin: 0 0 1.25rem 0; }
.form-group { margin-bottom: 0.85rem; text-align: left; }
.form-group label { display: block; font-size: 0.65rem; font-weight: 700; color: #4b5563; text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 0.3rem; }
.form-group input, .form-group select { width: 100%; padding: 0.6rem 0.85rem; border-radius: 8px; border: 1px solid #e2e5e9; background-color: #ffffff; color: #111827; font-size: 0.9rem; outline: none; box-sizing: border-box; transition: border-color 0.2s, box-shadow 0.2s; font-family: 'Geist', sans-serif; }
.form-group input:focus, .form-group select:focus { border-color: #1b4332; box-shadow: 0 0 0 3px rgba(27, 67, 50, 0.12); }
.form-group select { appearance: none; background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 24 24' fill='none' stroke='%234b5563' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E"); background-repeat: no-repeat; background-position: right 0.75rem center; padding-right: 2.5rem; cursor: pointer; }
.signin-btn { width: 100%; padding: 0.7rem; border-radius: 8px; border: none; background-color: #111827; color: #ffffff; font-weight: 600; font-size: 0.88rem; cursor: pointer; transition: all 0.2s; margin-bottom: 0.85rem; font-family: 'Geist', sans-serif; }
.signin-btn:hover { background-color: #2a3140; transform: translateY(-1px); box-shadow: 0 4px 12px rgba(17, 24, 39, 0.15); }
.register-btn { width: 100%; padding: 0.7rem; border-radius: 8px; border: 1px solid #e2e5e9; background-color: transparent; color: #111827; font-weight: 600; font-size: 0.88rem; cursor: pointer; transition: all 0.2s; margin-bottom: 0.85rem; font-family: 'Geist', sans-serif; text-decoration: none; display: block; text-align: center; box-sizing: border-box;}
.register-btn:hover { border-color: #1b4332; color: #1b4332; }
.auth-watermark { position: absolute; bottom: 1rem; right: 1.5rem; font-size: 0.65rem; color: #1b4332; opacity: 0.25; letter-spacing: 0.05em; font-weight: 500; }
@media (max-width: 768px) { .auth-page { flex-direction: column; } .auth-brand-side { padding: 3rem 2rem 2rem; border-bottom: 1px solid #eef0f2; } .auth-brand-content { max-width: 100%; } .auth-brand-text h1 { font-size: 1.9rem; } .auth-form-side { padding: 2rem 1.5rem 3rem; border-left: none; } }
</style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="auth-page">
      <div class="auth-brand-side">
        <div class="auth-brand-content">
          <div class="auth-brand-logo">
            <img src='<%= ResolveUrl("~/Images/image.png") %>' alt="TransitOps" />
          </div>
          <div class="auth-brand-text">
            <h1>TransitOps</h1>
            <p>Join the fleet management platform</p>
          </div>
          <div class="auth-brand-decoration"></div>
          <p style="font-size: 0.85rem; color: #9ca3af; line-height: 1.7; margin: 0">
            Create your account and start orchestrating your shipping dispatches, tracking assets, and managing your fleet in one place.
          </p>
        </div>
        <div class="auth-brand-footer">TRANSITOPS &copy; 2026</div>
      </div>

      <div class="auth-form-side">
        <div class="auth-form-container">
          <h2>Create your account</h2>
          <p class="form-subtitle">Fill in the details below to get started</p>

          <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="false" style="display:block; margin-bottom: 15px; text-align: center; font-weight: bold; font-size: 0.85rem;"></asp:Label>
          <asp:Label ID="lblSuccess" runat="server" ForeColor="#166534" Visible="false" style="display:block; border: 1px solid #16a34a; border-radius: 12px; padding: 0.85rem 1rem; margin-bottom: 1.5rem; background-color: #f0fdf4; font-size: 0.9rem; text-align: center;"></asp:Label>

          <div class="form-group">
            <label>Full Name</label>
            <asp:TextBox ID="txtName" runat="server" placeholder="e.g. Jane Smith"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" ErrorMessage="Full name is required." Display="Dynamic" ForeColor="#b91c1c" Font-Size="12px" />
          </div>

          <div class="form-group">
            <label>Email</label>
            <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="you@company.com"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required." Display="Dynamic" ForeColor="#b91c1c" Font-Size="12px" />
            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" ErrorMessage="Enter a valid email address." Display="Dynamic" ForeColor="#b91c1c" Font-Size="12px" />
          </div>

          <div class="form-group">
            <label>Password</label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Minimum 6 characters"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="Password is required." Display="Dynamic" ForeColor="#b91c1c" Font-Size="12px" />
          </div>

          <div class="form-group">
            <label>Confirm Password</label>
            <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" placeholder="Re-enter password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvConfirm" runat="server" ControlToValidate="txtConfirmPassword" ErrorMessage="Confirm your password." Display="Dynamic" ForeColor="#b91c1c" Font-Size="12px" />
            <asp:CompareValidator ID="cvPasswords" runat="server" ControlToValidate="txtConfirmPassword" ControlToCompare="txtPassword" ErrorMessage="Passwords do not match." Display="Dynamic" ForeColor="#b91c1c" Font-Size="12px" />
          </div>

          <div class="form-group">
            <label>Role</label>
            <asp:DropDownList ID="ddlRole" runat="server">
                <asp:ListItem Text="Select your role" Value="" disabled="disabled" Selected="True"></asp:ListItem>
                <asp:ListItem Text="Fleet Manager" Value="Fleet Manager"></asp:ListItem>
                <asp:ListItem Text="Driver" Value="Driver"></asp:ListItem>
                <asp:ListItem Text="Safety Officer" Value="Safety Officer"></asp:ListItem>
                <asp:ListItem Text="Financial Analyst" Value="Financial Analyst"></asp:ListItem>
            </asp:DropDownList>
          </div>

          <asp:Button ID="btnSignUp" runat="server" Text="Sign Up" CssClass="signin-btn" OnClick="btnSignUp_Click" />

          <a href="SignIn.aspx" class="register-btn">Already have an account? Sign In</a>

        </div>
        <div class="auth-watermark">TransitOps</div>
      </div>
    </div>
    </form>
</body>
</html>
