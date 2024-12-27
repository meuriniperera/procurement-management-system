<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="Tech_Fix.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="about-section">
        <h1>About TechFix</h1>
        <p>TechFix is your reliable partner for computer repairs, custom builds, and hardware upgrades. We provide fast, professional services to keep your devices running smoothly.</p>
        
        <div class="about-box about-mission">
            <h2><i class="fa fa-bullseye about-icon"></i> Our Mission</h2>
            <p>Our mission is to deliver top-notch technology solutions with a commitment to quality, speed, and customer satisfaction. Whether you're a home user or a business, we strive to offer the best service possible.</p>
        </div>

        <div class="about-box about-values">
            <h2><i class="fa fa-star about-icon"></i> Our Values</h2>
            <ul>
                <li><i class="fa fa-check-circle about-icon"></i><strong>Quality:</strong> We use high-quality parts and tools to ensure your devices work like new.</li>
                <li><i class="fa fa-check-circle about-icon"></i><strong>Efficiency:</strong> We repair and upgrade your systems quickly to minimize downtime.</li>
                <li><i class="fa fa-check-circle about-icon"></i><strong>Customer-Centric:</strong> We put your needs first, offering transparent and honest communication.</li>
            </ul>
        </div>

        <div class="about-box about-team">
            <h2><i class="fa fa-users about-icon"></i> Meet the Team</h2>
            <p>Our team of experienced technicians is passionate about technology and committed to providing the best solutions for your needs. Whether it's a simple repair or a complex custom build, we've got you covered.</p>
            <!-- You can add an image of the team here -->
            <img src="Images/team.jpg" alt="Our Team" class="about-img">
        </div>
    </div>
</asp:Content>
