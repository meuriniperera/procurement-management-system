<%@ Page Title="Account" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Account.aspx.cs" Inherits="Tech_Fix.Account" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="account-section">
        <!-- Login Form -->
<div id="loginForm" class="account-form">
    <h1>Login</h1>
    <asp:TextBox ID="txtLoginUsername" runat="server" CssClass="account-input" Placeholder="Username" ValidationGroup="LoginGroup"></asp:TextBox>
    <asp:TextBox ID="txtLoginPassword" runat="server" CssClass="account-input" TextMode="Password" Placeholder="Password" ValidationGroup="LoginGroup"></asp:TextBox>
    <asp:Button ID="btnLogin" runat="server" CssClass="account-button" Text="Login" OnClick="btnLogin_Click" ValidationGroup="LoginGroup" />
    <asp:RequiredFieldValidator ID="rfvLoginUsername" runat="server" ControlToValidate="txtLoginUsername" ErrorMessage="Username is required" CssClass="error-message" Display="Dynamic" ValidationGroup="LoginGroup" />
    <asp:RequiredFieldValidator ID="rfvLoginPassword" runat="server" ControlToValidate="txtLoginPassword" ErrorMessage="Password is required" CssClass="error-message" Display="Dynamic" ValidationGroup="LoginGroup" />
    <asp:Label ID="lblLoginError" runat="server" CssClass="error-message" Visible="false" />
    <p>Don't have an account? <a href="javascript:void(0);" onclick="showSignupForm();">Sign Up</a></p>
</div>

<!-- Sign Up Form -->
<div id="signupForm" class="account-form" style="display:none;">
    <h1>Sign Up</h1>
    <asp:TextBox ID="txtSignupUsername" runat="server" CssClass="account-input" Placeholder="Username" ValidationGroup="SignupGroup"></asp:TextBox>
    <asp:TextBox ID="txtSignupPassword" runat="server" CssClass="account-input" TextMode="Password" Placeholder="Password" ValidationGroup="SignupGroup"></asp:TextBox>
    <asp:TextBox ID="txtSignupEmail" runat="server" CssClass="account-input" Placeholder="Email" ValidationGroup="SignupGroup"></asp:TextBox>
    <asp:DropDownList ID="ddlSignupRole" runat="server" CssClass="account-input" ValidationGroup="SignupGroup">
        <asp:ListItem Text="Select Role" Value="" />
        <asp:ListItem Text="TechFix" Value="techfix" />
        <asp:ListItem Text="Supplier" Value="supplier" />
    </asp:DropDownList>
    <asp:Button ID="btnSignup" runat="server" CssClass="account-button" Text="Sign Up" OnClick="btnSignup_Click" ValidationGroup="SignupGroup" />
    <asp:RequiredFieldValidator ID="rfvSignupUsername" runat="server" ControlToValidate="txtSignupUsername" ErrorMessage="Username is required" CssClass="error-message" Display="Dynamic" ValidationGroup="SignupGroup" />
    <asp:RequiredFieldValidator ID="rfvSignupPassword" runat="server" ControlToValidate="txtSignupPassword" ErrorMessage="Password is required" CssClass="error-message" Display="Dynamic" ValidationGroup="SignupGroup" />
    <asp:RequiredFieldValidator ID="rfvSignupEmail" runat="server" ControlToValidate="txtSignupEmail" ErrorMessage="Email is required" CssClass="error-message" Display="Dynamic" ValidationGroup="SignupGroup" />
    <asp:RegularExpressionValidator ID="revSignupEmail" runat="server" ControlToValidate="txtSignupEmail" ErrorMessage="Invalid email format" CssClass="error-message" Display="Dynamic" ValidationGroup="SignupGroup" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
    <asp:Label ID="lblSignupError" runat="server" CssClass="error-message" Visible="false" />
    <p>Already have an account? <a href="javascript:void(0);" onclick="showLoginForm();">Login</a></p>
</div>
    </div>

    <script type="text/javascript">
        function showSignupForm() {
            document.getElementById('loginForm').style.display = 'none';
            document.getElementById('signupForm').style.display = 'block';
        }

        function showLoginForm() {
            document.getElementById('signupForm').style.display = 'none';
            document.getElementById('loginForm').style.display = 'block';
        }
    </script>
</asp:Content>
