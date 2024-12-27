<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Tech_Fix._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="landing-section">
        <div class="landing-text">
            <h1>Welcome to TechFix!</h1>
            <p>Your one-stop shop for computer repairs, upgrades, and custom builds.</p>
            <asp:Button ID="btnGetQuote" runat="server" CssClass="btn-primary" Text="Get a Quote" OnClick="btnGetQuote_Click" />
        </div>
        <div class="landing-image">
            <img src="Images/tech_banner.jpg" alt="TechFix Banner" />
        </div>
    </div>
    <div class="features-section">
        <div class="feature-box">
            <h2>Fast Repairs</h2>
            <p>Get your devices repaired quickly and efficiently.</p>
        </div>
        <div class="feature-box">
            <h2>Custom Builds</h2>
            <p>We build high-performance PCs tailored to your needs.</p>
        </div>
        <div class="feature-box">
            <h2>Hardware Upgrades</h2>
            <p>Upgrade your system with the latest components.</p>
        </div>
    </div>
</asp:Content>