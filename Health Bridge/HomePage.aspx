<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="Health_Bridge.HomePage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Health Bridge</title>

    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />

    <link href="css/homepage.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="js/homepage.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" />
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>

    <script>
        $(document).ready(function () {
            // $("#welcomeUsername p").text("I am !!! " + localStorage.getItem["userName"]);
            swal("Welcome!! " + '<%=Session["customerName"].ToString()%>', "To Health Bridge", "success");
        });
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

        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
        </asp:ScriptManager>

        <nav class="navbar navbar-inverse navbar-fixed-top">
            <div class="container-fluid topNavBar">
                <div class="navbar-header">
                    <a class="navbar-brand siteName" style="color: white;" href="HomePage.aspx">Health Bridge</a>
                </div>
                <ul class="nav navbar-nav" runat="server">
                    <li class="active"><a href="#">Home</a></li>
                    <li><a href="#">Book Appointment</a></li>
                    <li><a href="#">Tests & Checkups</a></li>
                    <li><a href="#">Order Medicines</a></li>
                    <li><a href="#">Fitness Tips</a></li>
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


        <div class="container">
            <div class="row" style="margin-top: 130px; margin-bottom: 20px;">
                <div class="col-sm-8 col-sm-offset-4">
                    <h3>Find Best Doctors In Your City</h3>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-8 col-sm-offset-2">
                    <div class="input-group suggestions">
                        <div class="input-group-btn search-panel">
                            <button type="button" id="dropdownDoctors" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                                <span id="search_concept">Surgeon Type</span> <span class="caret"></span>
                            </button>
                            <ul class="dropdown-menu" id="specializations" role="menu">
                                <li><a href="Cardiologist">Cardiologist</a></li>
                                <li><a href="Neurologist">Neurologist</a></li>
                                <li><a href="ENT Specialist">ENT Specialist</a></li>
                                <li><a href="Physiologist">Physiologist</a></li>
                                <li><a href="Dermatologist">Dermatologist</a></li>
                                <li><a href="Dentist">Dentist</a></li>
                                <li class="divider"></li>
                                <li><a href="all">All Surgeons</a></li>
                            </ul>
                        </div>
                        <input type="hidden" name="search_param" value="all" id="search_param" />
                        <input type="search" id="cities" class="form-control"  placeholder="Enter Your City Name..." />
                        <span class="input-group-btn getLocationDiv">
                            <button class="btn btn-default getLocation" data-toggle="tooltip" title="Get Your Current Location" id="getLocationCities" type="button"><span class="glyphicon glyphicon-map-marker"></span></button>
                        </span>
                        <span class="input-group-btn searchDiv" id="searchButton">
                            <button class="btn btn-default searchButton" type="button"><span class="glyphicon glyphicon-search"></span></button>
                        </span>
                    </div>
                   
                </div>
            </div>

            <div class="container-fluid" style="margin-top: 50px;">
                <div class="row" style=" margin-bottom: 7px;">
                    <div class="col-sm-8 col-sm-offset-2">
                        <h5 style="color: rgba(255,255,255,0.8)" id="resultHeading">Available Doctors In All Cities</h5>
                    </div>
                </div>
                <div id="new_row">
                    <div class="row">
                    </div>
                </div>
            </div>

        </div>







    </form>
</body>
</html>
