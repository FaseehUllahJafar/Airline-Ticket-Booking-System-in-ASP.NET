<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="add_planes.aspx.cs" MasterPageFile="~/Site.Master" Inherits="db_Proj_2.add_planes" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <head>
        <title>Add planes</title>
        <link href="Admin_loginStyleSheet.css" rel="stylesheet">
    </head>

    <div class="row">
        <div class="col">
            <br>
            <br>
        </div>
    </div>

    <div class="row">
        <div class="col">
            <br>
            <br>
        </div>
    </div>

    <div class="container-fluid">

        <div class="row">
            <div class="col-md-12 mx-auto">
                <center>
                    <center class="textHeading">
                        <h1>
                            <br>
                            Adding New Planes</h1>
                    </center>
                    <hr style="-moz-animation-direction">
                </center>
            </div>
        </div>


        <div class="row justify-content-center">
            <div class="col-md-12 mx-auto">
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
                                    <div class="col-md-12 mx-auto">
                                        <center>
                                            <h1>Add Airplane</h1>
                                            <label class="text">Airplane ID</label>
                                            <div class="form-group">
                                                <asp:TextBox CssClass="form-control" ID="memberid_TextBox1" runat="server" placeholder="Airplane ID" TextMode="SingleLine"></asp:TextBox>
                                            </div>
                                            <label class="text">Date/Time of Flight</label>
                                            <div class="form-group">
                                                <asp:TextBox CssClass="form-control" ID="date_time_TextBox2" runat="server" placeholder="yyyy-mm-dd hh:mm:ss" TextMode="DateTime"></asp:TextBox>
                                            </div>
                                            <label class="text">Destination airport Code</label>
                                            <div class="form-group">
                                                <asp:TextBox CssClass="form-control" ID="destination_TextBox" runat="server" placeholder="Destination" OnTextChanged="destination_TextBox_TextChanged"></asp:TextBox>
                                            </div>
                                             <label class="text">Departure airport Code</label>
                                            <div class="form-group">
                                                <asp:TextBox CssClass="form-control" ID="TextBox1" runat="server" placeholder="Departure" OnTextChanged="destination_TextBox_TextChanged"></asp:TextBox>
                                            </div>
                                            <div class="form-group">
                                                <%-- class="btn btn-success btn-block btn-lg"   < a href = "signUp.aspx" >< input class="btn btn-info btn-block btn-lg" id="Button2" type="button" value="Sign Up" onclick="Button2_Click" /></a> --%>
                                               <asp:Button class="btn btn-success btn-block btn-lg" ID="Button3" runat="server" Text="Add" OnClick="Button3_Click" />
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
            <%--  <div class="col-md-6 offset-md-6">
                       <img src="Images/admin_login.jpg" class="img-thumbnail"/>
                   </div>--%>
        </div>


    </div>
</asp:Content>















