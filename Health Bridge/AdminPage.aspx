<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminPage.aspx.cs" Inherits="Health_Bridge.AdminPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Health Bridge</title>

    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />

    <link href="css/adminpage.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="js/adminpage.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>

    <script>

        function ShowMessage(message, messagetype) {
            swal({
                title: messagetype,
                text: message,
                icon: messagetype,
            });
        }
    </script>


    <style>
       

    </style>
</head>

<body style="height: auto">
    <form id="form1" runat="server">
        <div id="divbg"></div>



        <nav class="navbar navbar-inverse navbar-fixed-top">
            <div class="container-fluid topNavBar">
                <div class="navbar-header">
                    <a class="navbar-brand siteName" style="color: white;" href="HomePage.aspx">Health Bridge</a>
                </div>
                <ul class="nav navbar-nav" runat="server">
                    <li class="active"><a href="#">Home</a></li>
                    <li><a href="#">Reports</a></li>
                    <li><a href="#">Booked Appointments</a></li>
                    <li><a href="#">About Us</a></li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="#">
                        <asp:Label ID="welcomeUsername" runat="server" Text="Label"></asp:Label></a></li>
                    <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">Profile <span class="caret"></span></a>
                        <ul class="dropdown-menu subMenu">
                            <li><a href="#">Edit Profile</a></li>
                            <li><a id="deactiveAccount" href="#">Delete account</a></li>
                            <li><a href="#">Help</a></li>
                        </ul>
                    </li>
                    <li>
                        <asp:Button ID="logoutButton" runat="server" CssClass="btn btn-register" OnClick="logoutCustomer" Text="Logout" /></li>
                </ul>

            </div>
        </nav>

        <!--Doctors grid-->
        <div class='col-sm-10 col-sm-offset-1 doctorsDiv' style="padding-top: 120px;">
            <div class='container-fluid text-center'>
                <div class="row">

                    <div class='col-sm-7'>
                        <h4 style="float: left;">DOCTORS LIST</h4>
                    </div>
                    <div class='col-sm-5 ' hidden="hidden" aria-hidden="True">
                        <div class='col-sm-6 '>
                            <asp:DropDownList ID="cities" class="inputField" runat="server" Height="34px" Width="150px" OnSelectedIndexChanged = "cityChanged" AutoPostBack = "true" AppendDataBoundItems = "true">
                                <asp:ListItem Text="Select City" Value="select" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="Bangalore" Value="Bangalore"></asp:ListItem>
                                <asp:ListItem Text="Hyderabad" Value="Hyderabad"></asp:ListItem>
                                <asp:ListItem Text="Vijayawada" Value="Vijayawada"></asp:ListItem>
                                <asp:ListItem Text="Chennai" Value="Chennai"></asp:ListItem>
                                <asp:ListItem Text="Kadapa" Value="Kadapa"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        
                        <div class='col-sm-6'>
                            <asp:DropDownList ID="specialization" class="inputField" runat="server" Height="34px" Width="150px"  OnSelectedIndexChanged = "specializationChanged" AutoPostBack = "true" AppendDataBoundItems = "true">
                                <asp:ListItem Text="Select Specialization" Value="select" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="Cardiologist" Value="Cardiologist"></asp:ListItem>
                                <asp:ListItem Text="Neurologist" Value="Neurologist"></asp:ListItem>
                                <asp:ListItem Text="ENT Specialist" Value="ENT Specialist"></asp:ListItem>
                                <asp:ListItem Text="Physiologist" Value="Physiologist"></asp:ListItem>
                                <asp:ListItem Text="Dermatologist" Value="Dermatologist"></asp:ListItem>
                                <asp:ListItem Text="Dentist" Value="Dentist"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>

                </div>

                <div class="row" style="height: 450px; overflow: scroll; overflow-x: hidden;">
                    <asp:GridView ID="DoctorsView" CssClass="GridStyle" runat="server" Width="1200"></asp:GridView>
                </div>
                <div class="row" id="buttons">
                    <div class='col-sm-3 '>
                        <div class='col-sm-5'>
                            <h4 style="padding-top:12px;">Export to: </h4>
                            </div>
                        <div class='col-sm-3'>
                            <button class="btn btn-primary exportButton" data-toggle="tooltip" title="Export to Pdf" onserverclick="ExporttoPDF_Click" runat="server" type="button"><i class="fa fa-file-pdf-o" aria-hidden="true"></i></button>
                        </div> 
                        <div class='col-sm-3'>
                            <button class="btn btn-success exportButton" data-toggle="tooltip" id="ExportToExcel" onserverclick="ExportToExcelClick" title="Export to Excel" runat="server" type="button"><i class="fa fa-file-excel-o" aria-hidden="true"></i></button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Doctors grid-->

    </form>
</body>
</html>
