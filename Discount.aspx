<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Discount.aspx.cs" Inherits="db_Proj_2.Discount" %>



<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <head>

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

 <%--   <div class="container-fluid">

        <div class="row">
            <div class="col-md-12 mx-auto">
                <center>
                    <center class="textHeading">
                        <h1>
                            <br>
                            DISCOUNTS PAGE</h1>
                    </center>
                    <hr style="-moz-animation-direction">
                </center>
            </div>
        </div>--%>
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
                                            <h1>Edit Discount</h1>
                                            <label class="text">Status</label>
                                            <div class="form-group">
                                                <asp:DropDownList CssClass="form-control" ID="TextBox1" runat="server">
                                                    <asp:ListItem Selected="True">Enable</asp:ListItem>
                                                    <asp:ListItem>Disable</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                            <label class="text">Name</label>
                                            <div class="form-group">
                                                <%--placeholder="Name" OnSelectedIndexChanged="TextBox2_SelectedIndexChanged"--%>
                                                <asp:DropDownList CssClass="form-control" ID="TextBox2" runat="server" AutoPostBack="true"></asp:DropDownList>
                                            </div>
                                            <label class="text">Percentage</label>
                                            <div class="form-group">
                                                <asp:TextBox CssClass="form-control" ID="TextBox3" runat="server" placeholder="Percentage" TextMode="Number"></asp:TextBox>
                                            </div>
                                            <div class="form-group">
                                                <%--<a href="#"><input class="btn btn-info btn-block btn-lg" id="Button2" type="button" value="Add" /></a>--%>
                                                <asp:Button class="btn btn-info btn-block btn-lg" ID="Button2" runat="server" Text="Update" OnClick="Button2_Click" />
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
