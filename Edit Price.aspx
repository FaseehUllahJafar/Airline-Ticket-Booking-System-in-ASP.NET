<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Edit Price.aspx.cs" Inherits="db_Proj_2.Edit_Price" %>



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

    <div class="container-fluid">

        <div class="row">
            <div class="col-md-12 mx-auto">
                <center>
                    <center class="textHeading">
                        <h1>
                            <br>
                            EDIT PRICE</h1>
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
                                    <div class="col-md-6 mx-auto">
                                        <center>
                                            <label class="text">Airplane ID</label>
                                            <div class="form-group">
                                                <asp:DropDownList CssClass="form-control" ID="DropDownList1" runat="server" AutoPostBack="true"></asp:DropDownList>
                                            </div>
                                            <label class="text">Class name</label>
                                            <%--<div class="m-12">--%>
                                            <div class="btn-group">
                                                <asp:DropDownList CssClass="form-control" ID="TextBox2" runat="server" AutoPostBack="true">
                                                    <asp:ListItem Selected="True" Value="business">business</asp:ListItem>
                                                    <asp:ListItem>economy</asp:ListItem>
                                                    <asp:ListItem>exclusive</asp:ListItem>
                                                </asp:DropDownList>

                                                <%--    <button type="button" class="btn  dropdown-toggle" data-bs-toggle="dropdown">Choose class</button>--%>
                                                <%--<div class="dropdown-menu">
                                                            <a href="#" class="dropdown-item">thing 1</a>
                                                            <a href="#" class="dropdown-item">thing 2</a>                                                            
                                                            <a href="#" class="dropdown-item">thing 3</a>
                                                        </div>--%>
                                            </div>
                                            <%--</div>--%>
                                        </center>

                                    </div>
                                    <div class="col-md-6 mx-auto">
                                        <center>

                                            <label class="text">Price</label>
                                            <div class="form-group">
                                                <asp:TextBox CssClass="form-control" ID="TextBox1" runat="server" placeholder="Price" TextMode="Number"></asp:TextBox>
                                        </center>

                                    </div>

                                </div>

                            </div>
                            <div class="form-group">
                                <center>
                                    <%--<a href="#"><input class="btn btn-info btn-block btn-lg" id="Button2" type="button" value="Add" /></a>--%>
                                    <asp:Button class="btn btn-info btn-block btn-lg" ID="Button2" runat="server" Text="Update" OnClick="Button2_Click" />
                                </center>
                            </div>
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
                            <div class="row">
                                <div class="col">
                                    <br>
                                    <br>
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
