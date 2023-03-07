<%@ Page Title="Sign Up" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="signUp.aspx.cs" Inherits="db_Proj_2.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <head>
        <link href="signUpStyleSheet.css" rel="stylesheet">
    </head>

    <div class="container">
        <div class="container">

            <div class="row">
                <div class="row justify-content-center">
                    <div class="col-md-12 mx-auto">
                        <center>
                            <center class="textHeading">
                                <img width="150px" src="Images/signUp.jpeg" />
                                <h1>
                                    <br>
                                    SignUp Page</h1>
                            </center>
                            <hr style="-moz-animation-direction">
                        </center>
                    </div>

                </div>
                <div class="col-md-6 mx-auto">

                    <div class="card">
                        <div class="card-body">
                            <div class="row">
                                <div class="col">
                                    <br>
                                    <br>
                                </div>
                            </div>

                            <%--                              <div class="row">
                                         <div class="col">
                                            <center>
                                               <h3 class ="text">Sign Up Page</h3>
                                            </center>
                                         </div>
                                    </div>--%>
                            <div class="row">
                                <div class="col">
                                    <br>
                                    <br>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <center>
                                        <label>Enter Your Name</label>
                                        <div class="form-group">
                                            <asp:TextBox CssClass="form-control" ID="fname_TextBox" runat="server" placeholder="First Name"></asp:TextBox>
                                        </div>

                                        <label>Enter Your National ID</label>
                                        <div class="form-group">
                                            <asp:TextBox CssClass="form-control" ID="lname_TextBox" runat="server" placeholder="National ID"></asp:TextBox>
                                        </div>

                                        <label>Enter Your Email</label>
                                        <div class="form-group">
                                            <asp:TextBox CssClass="form-control" ID="email_TextBox3" runat="server" placeholder="Email" TextMode="Email"></asp:TextBox>
                                        </div>

                                        <label>Enter Password:</label>
                                        <div class="form-group">
                                            <asp:TextBox CssClass="form-control" ID="pwd_TextBox2" runat="server" placeholder="Password" TextMode="Password"></asp:TextBox>
                                        </div>



                                        <div class="form-group">
                                            <%-- class="btn btn-success btn-block btn-lg"   < a href = "signUp.aspx" >< input class="btn btn-info btn-block btn-lg" id="Button2" type="button" value="Sign Up" onclick="Button2_Click" /></a> --%>
                                            <asp:Button class="btn btn-info btn-block btn-lg" ID="Button2" runat="server" Text="Sign Up" OnClick="Button2_Click" />
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
                    <br>
                    <br>
                </div>
                <div class="col-md-6 mx-auto">

                    <div class="container-fluid">
                        <div class="row">
                            <div class="col">
                                <br>
                                <br>
                                <br>
                                <br>
                            </div>
                        </div>



                        <img src="Images/jahaaz2.jpg" class="img-thumbnail" width="100%" />

                    </div>

                </div>
            </div>
        </div>

        <a href="WelcomePage.aspx">
            <div cssclass="ButtonText">
                << Back To Home
            </div>
        </a>
    </div>
</asp:Content>
