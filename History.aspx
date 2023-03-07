<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="History.aspx.cs" Inherits="db_Proj_2.History" %>



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
                            History</h1>
                    </center>
                </center>
            </div>
            <div>
                <hr style="-moz-animation-direction">
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

                                            <asp:GridView ID="gridHistory" runat="server" AutoGenerateColumns="false" ShowHeaderWhenEmpty="True" Width="964px">
                                                <Columns>
                                                    <asp:BoundField DataField="seat_number" HeaderText="Seat Number" />
                                                    <asp:BoundField DataField="cnic" HeaderText="National ID" />
                                                    <asp:BoundField DataField="flight_DateTime" HeaderText="Flight Date&Time" />
                                                    <asp:BoundField DataField="plane_ID" HeaderText="Plane ID" />
                                                    <asp:BoundField DataField="departure_city" HeaderText="Departure City" />
                                                    <asp:BoundField DataField="destination_city" HeaderText="Destination City" />
                                                    <asp:BoundField DataField="offer" HeaderText="Discount Name" />
                                                    <asp:BoundField DataField="d_percentage" HeaderText="Percentage" />
                                                    <asp:BoundField DataField="class" HeaderText="Seat Class" />
                                                    <asp:BoundField DataField="price" HeaderText="Seat Price" />
                                                </Columns>
                                                <EditRowStyle BackColor="#99CCFF" />
                                                <HeaderStyle BackColor="#0066FF" Font-Bold="True" Font-Italic="True" />
                                                <PagerStyle BackColor="#CCFFFF" BorderColor="#66FF66" />
                                                <RowStyle BackColor="#CCFFFF" BorderColor="#9999FF" BorderStyle="None" />
                                            </asp:GridView>

                                            <%--   <table class="table table-condensed">
                                                    <thead>
                                                      <tr>
                                                        <th>Firstname</th>
                                                        <th>Lastname</th>
                                                        <th>Email</th>
                                                      </tr>
                                                    </thead>
                                                    <tbody>
                                                      <tr>
                                                        <td>John</td>
                                                        <td>Doe</td>
                                                        <td>john@example.com</td>
                                                      </tr>
                                                      <tr>
                                                        <td>Mary</td>
                                                        <td>Moe</td>
                                                        <td>mary@example.com</td>
                                                      </tr>
                                                      <tr>
                                                        <td>July</td>
                                                        <td>Dooley</td>
                                                        <td>july@example.com</td>
                                                      </tr>
                                                    </tbody>
                                                  </table>--%>
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
        </div>


    </div>
</asp:Content>
