<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignIn.aspx.cs" Inherits="TransitOPS_net.Guest.SignIn" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>SignIn - TransitOps</title>
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
.form-row { display: flex; align-items: center; justify-content: space-between; margin-bottom: 1rem; }
.checkbox-group { display: flex; align-items: center; gap: 0.5rem; color: #4b5563; font-size: 0.85rem; cursor: pointer; }
.checkbox-group input[type="checkbox"] { appearance: none; width: 18px; height: 18px; border: 1.5px solid #d4d4d8; border-radius: 4px; background-color: #ffffff; cursor: pointer; position: relative; flex-shrink: 0; margin: 0; transition: all 0.2s; }
.checkbox-group input[type="checkbox"]:checked { background-color: #1b4332; border-color: #1b4332; }
.checkbox-group input[type="checkbox"]:checked::after { content: ''; position: absolute; left: 5px; top: 1px; width: 5px; height: 9px; border: solid white; border-width: 0 2px 2px 0; transform: rotate(45deg); }
.forgot-link { color: #1b4332; font-size: 0.85rem; text-decoration: none; font-weight: 600; transition: opacity 0.2s; }
.forgot-link:hover { opacity: 0.7; text-decoration: underline; }
.signin-btn { width: 100%; padding: 0.7rem; border-radius: 8px; border: none; background-color: #111827; color: #ffffff; font-weight: 600; font-size: 0.88rem; cursor: pointer; transition: all 0.2s; margin-bottom: 0.85rem; font-family: 'Geist', sans-serif; }
.signin-btn:hover { background-color: #2a3140; transform: translateY(-1px); box-shadow: 0 4px 12px rgba(17, 24, 39, 0.15); }
.register-btn { width: 100%; padding: 0.7rem; border-radius: 8px; border: 1px solid #e2e5e9; background-color: transparent; color: #111827; font-weight: 600; font-size: 0.88rem; cursor: pointer; transition: all 0.2s; margin-bottom: 0.85rem; font-family: 'Geist', sans-serif; text-decoration: none; display: block; text-align: center; box-sizing: border-box;}
.register-btn:hover { border-color: #1b4332; color: #1b4332; }
.scope-notes { font-size: 0.7rem; color: #9ca3af; line-height: 1.5; border-top: 1px solid #eef0f2; padding-top: 0.75rem; text-align: left; }
.scope-notes strong { color: #4b5563; font-weight: 600; }
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
            <p>Smart Transport Operations Platform</p>
          </div>
          <div class="auth-brand-decoration"></div>
          <p style="font-size: 0.78rem; color: #9ca3af; line-height: 1.5; margin: 0">
            Orchestrate your shipping dispatches, automate preventive care, track asset locations, and audit operations in an editorial workspace designed for modern fleets.
          </p>
        </div>
        <div class="auth-brand-footer">TRANSITOPS &copy; 2026</div>
      </div>

      <div class="auth-form-side">
        <div class="auth-form-container">
          <h2>Sign in to your account</h2>
          <p class="form-subtitle">Enter your credentials to continue</p>

          <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="false" style="display:block; margin-bottom: 15px; text-align: center; font-weight: bold; font-size: 0.85rem;"></asp:Label>

          <div class="form-group">
            <label>Email</label>
            <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="example@gmail.com"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required." Display="Dynamic" ForeColor="#b91c1c" Font-Size="12px" />
            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" ErrorMessage="Enter a valid email address." Display="Dynamic" ForeColor="#b91c1c" Font-Size="12px" />
          </div>

          <div class="form-group">
            <label>Password</label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="12345678"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="Password is required." Display="Dynamic" ForeColor="#b91c1c" Font-Size="12px" />
          </div>

          <div class="form-group">
            <label>Role (RBAC)</label>
            <asp:DropDownList ID="ddlRole" runat="server">
                <asp:ListItem Text="Fleet Manager" Value="Fleet Manager"></asp:ListItem>
                <asp:ListItem Text="Dispatcher" Value="Dispatcher"></asp:ListItem>
                <asp:ListItem Text="Safety Officer" Value="Safety Officer"></asp:ListItem>
                <asp:ListItem Text="Financial Analyst" Value="Financial Analyst"></asp:ListItem>
            </asp:DropDownList>
          </div>

          <div class="form-row">
            <label class="checkbox-group">
              <asp:CheckBox ID="chkRemember" runat="server" Checked="true" />
              Remember me
            </label>
            <a href="#" class="forgot-link" onclick="return false;">Forgot password?</a>
          </div>

          <asp:Button ID="btnSignIn" runat="server" Text="Sign In" CssClass="signin-btn" OnClick="btnSignIn_Click" />

          <a href="SignUp.aspx" class="register-btn">Create Account</a>

          <div class="scope-notes">
            <strong>Access is scoped by role after login</strong><br />
            Fleet Manager &rarr; Fleet, Maintenance<br />
            Dispatcher &rarr; Dashboard, Trips<br />
            Safety Officer &rarr; Drivers, Compliance<br />
            Financial Analyst &rarr; Fuel &amp; Expenses, Analytics
          </div>
        </div>
        <div class="auth-watermark">TransitOps</div>
      </div>
    </div>
    </form>
</body>
</html>
