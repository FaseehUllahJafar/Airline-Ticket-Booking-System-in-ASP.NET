<%@ Page Title="Bookings" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="bookings.aspx.cs" Inherits="db_Proj_2.bookings" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron text-center" style="background-color: #FAF0E6">

        <h1>Book Your Flights</h1>
        <blockqoute>We are always here for the best plan/e?</blockqoute>
        <div class="row">
            <div class="col">
                <br>
                <br>
            </div>
        </div>
    </div>

    <div class="container-fluid" style="background-color: white">

        <div class="row justify-content-center">
            <div class="col-md-6 offset-md-6">
                <div class="row justify-content-center">
                    <div class="col-md-12 mx-auto">
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col">
                                        <br>
                                        <br>
                                    </div>
                                </div>


                                <div class="row">
                                    <div class="col">
                                        <center>
                                            <label class="text">National ID</label>
                                            <div class="form-group">
                                                <asp:TextBox CssClass="form-control" ID="memberid_TextBox1" runat="server" placeholder="Nationa ID" Width="1048px"></asp:TextBox>
                                            </div>

                                            <label class="text">Enter Your Departure City</label>
                                            <div class="form-group">
                                                <asp:DropDownList CssClass="form-control" ID="DropDownList1" runat="server" AutoPostBack="true" Width="1112px" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged1"></asp:DropDownList>
                                            </div>
                                            <label class="text">Enter Your Destination City</label>
                                            <div class="form-group">
                                                <asp:DropDownList CssClass="form-control" ID="TextBox2" runat="server" AutoPostBack="true" Width="1077px" OnSelectedIndexChanged="TextBox2_SelectedIndexChanged"></asp:DropDownList>
                                            </div>
                                            <label class="text">Available Times</label>
                                            <div class="form-group">
                                                <asp:DropDownList CssClass="form-control" ID="DropDownList2" runat="server" AutoPostBack="true" Width="1091px"></asp:DropDownList>
                                            </div>
                                            <label class="text">Seat Class</label>
                                            <div>
                                                <asp:DropDownList CssClass="form-control" ID="DropDownList3" runat="server" Width="1063px">
                                                    <asp:ListItem Selected="True" Value="business">business</asp:ListItem>
                                                    <asp:ListItem>economy</asp:ListItem>
                                                    <asp:ListItem>exclusive</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                            <label class="text">Number of Seats</label>
                                            <div class="form-group">
                                                <asp:TextBox CssClass="form-control" ID="TextBox3" runat="server" placeholder="Seats" TextMode="Number" Width="1080px"></asp:TextBox>
                                            </div>

                                            <div class="form-group">
                                                <asp:Button class="btn btn-success btn-block btn-md" ID="Button1" runat="server" Text="Book Now" OnClick="Button1_Click" />
                                            </div>
                                        </center>

                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col">
                                <br>
                                <br>
                            </div>
                        </div>
                        <a href="WelcomePage.aspx">
                            <div cssclass="ButtonText">
                                << Back To Home
                            </div>
                        </a>
                        <br>
                        <br>
                    </div>
                </div>
            </div>
            <div class="col-md-6 offset-md-6">
                <img src="Images/jahaaz.jpg" class="img-thumbnail" />
            </div>
        </div>


    </div>


</asp:Content>
