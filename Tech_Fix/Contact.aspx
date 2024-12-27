<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="Tech_Fix.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="contact-section">
        <h1>Contact Us</h1>
        <p>If you have any questions or need assistance, feel free to reach out to us using the form below. We will get back to you as soon as possible.</p>
        
         <div class="contact-box">
            <h2>Get in Touch</h2>
            
            <asp:TextBox ID="txtName" runat="server" CssClass="contact-input" Placeholder="Your Name"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" 
                ErrorMessage="Name is required" CssClass="error-message" Display="Dynamic" />
            
            <asp:TextBox ID="txtEmail" runat="server" CssClass="contact-input" Placeholder="Your Email" TextMode="Email"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" 
                ErrorMessage="Email is required" CssClass="error-message" Display="Dynamic" />
            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" 
                ErrorMessage="Invalid email format" CssClass="error-message" Display="Dynamic" 
                ValidationExpression="^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$" />
            
            <asp:TextBox ID="txtSubject" runat="server" CssClass="contact-input" Placeholder="Subject"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvSubject" runat="server" ControlToValidate="txtSubject" 
                ErrorMessage="Subject is required" CssClass="error-message" Display="Dynamic" />
            
            <asp:TextBox ID="txtMessage" runat="server" CssClass="contact-textarea" TextMode="MultiLine" Rows="6" Placeholder="Your Message"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvMessage" runat="server" ControlToValidate="txtMessage" 
                ErrorMessage="Message is required" CssClass="error-message" Display="Dynamic" />
            
            <asp:Button ID="btnSubmit" runat="server" CssClass="contact-button" Text="Send Message" OnClick="btnSubmit_Click" />
        </div>
    </div>
</asp:Content>
