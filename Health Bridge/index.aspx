<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="Health_Bridge.index" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Health Bridge</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <link href="css/index.css" rel="stylesheet" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="js/index.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>

    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


    <script>
        $(function () {

            $('#login-form-link').click(function (e) {
                $("#login-form").delay(100).fadeIn(100);
                $("#register-form").fadeOut(100);
                $('#register-form-link').removeClass('active');
                $(this).addClass('active');
                e.preventDefault();
            });
            $('#register-form-link').click(function (e) {
                $("#register-form").delay(100).fadeIn(100);
                $("#login-form").fadeOut(100);
                $("#login-form").hide();
                $('#login-form-link').removeClass('active');
                $(this).addClass('active');
                e.preventDefault();
            });

        });
        


    </script>
     <script>
        function ShowMessage(message, messagetype) {
            swal({
                title: messagetype,
                text: message,
                icon: messagetype,
          });
        }
    </script>
</head>
<body>


    <form id="form1" runat="server">

        <div class="container">
            <div class="row ">
                <div class="col-md-8 col-sm-offset-3">
                    <div class="text">
                        <p>Health Bridge </p>
                        <p>
                            <span class="word emergency">Emergency</span>
                            <span class="word guide">Counselor</span>
                            <span class="word doctors">Doctors</span>
                            <span class="word appoint">Appointments</span>
                            <span class="word tips">Fitness`Tips</span>
                            <span class="word medicines">Medicines</span>
                            <span class="word care">Responsible</span>
                        </p>
                    </div>
                    <script src="js/headingAnimation.js"></script>
                    <div id="tagline"><p>Digital Medical Service Platform Between Patients And Doctors <i class="fa fa-stethoscope"></i></p></div>
                     <asp:Image ID="Image3" class="sethoscope" runat="server" AlternateText="Logo" ImageAlign="left" ImageUrl="images/doctor1.png" Height="80px" Width="65px" />
                    <div id="border">
                      <asp:Image ID="Image4" class="border" runat="server" AlternateText="border" ImageAlign="left" ImageUrl="images/border.png" Height="7px" Width="805px" />
                  </div>
                    </div>
            </div>

            <div class="row">
                <div class="col-md-6 col-md-offset-3">
                    <div class="panel panel-login">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-6 ">
                                    <a href="#" class="active" id="login-form-link">Sign In </a>
                                </div>
                                <div class="col-xs-6">
                                    <a href="#" id="register-form-link">Sign Up</a>
                                </div>
                            </div>
                            <hr>
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div id="login-form" role="form" style="display: block;">
                                        
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-sm-1">
                                                    <asp:Image ID="Image1" class="iconImage" runat="server" AlternateText="Image text" ImageAlign="left" ImageUrl="images/mailid.png" Height="50px" Width="50px" />
                                                </div>
                                                <div class="col-sm-11 bug">
                                                    <asp:TextBox class="form-control" name="mailid" ID="mailid" placeholder="Email ID" runat="server" AutoCompleteType="Disabled"></asp:TextBox>
                                                    <div id="emailerror" class="loginerrorReports"><p></p></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-sm-1">
                                                    <asp:Image ID="Image2" class="iconImage" runat="server" AlternateText="Image text" ImageAlign="left" ImageUrl="images/password.png" Height="50px" Width="50px" />
                                                </div>
                                                <div class="col-sm-11 bug">
                                                    <asp:TextBox class="form-control" name="password" ID="loginpassword" placeholder="Password" runat="server" AutoCompleteType="Disabled" TextMode="Password"></asp:TextBox>
                                                       <div id="loginpassworderror" class="loginerrorReports"><p></p></div>
                                               </div>
                                            </div>
                                        </div>
                                        <div class="form-group text-center">
                                            <input type="checkbox" id="ShowPassword" />
                                            <label for="remember" style="zoom:1.001;">  Show Password</label>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-sm-6 col-sm-offset-3">
                                                    <asp:Button ID="loginButton" class="form-control btn btn-login"   runat="server" Text="Sign In" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <div class="text-center">
                                                        <a href="#" tabindex="5" class="forgot-password">Forgot Password?</a>
                                                        <p class="rrs">&copy; RRS Creations</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                         
                                    </div>
                                    <div id="register-form" role="form" style="display: none;">
                                        <div class="form-group">
                                            <asp:TextBox class="form-control name" name="name" ID="name" placeholder="Full Name" runat="server" AutoCompleteType="Disabled"></asp:TextBox>
                                            <div id="nameerror" class="errorReports"><p></p></div>
                                        </div>
                                        <div class="form-group">
                                            <asp:DropDownList ID="DropDownList1" class="form-control city" runat="server" Height="48px" Width="522px">
                                                <asp:ListItem Text="Select City" Value="select" Selected="True"></asp:ListItem>
                                                <asp:ListItem Text="Bangalore" Value="Bangalore"></asp:ListItem>
                                                <asp:ListItem Text="Hyderabad" Value="Hyderabad"></asp:ListItem>
                                                <asp:ListItem Text="Chennai" Value="Chennai"></asp:ListItem>
                                            </asp:DropDownList>
                                           
                                            <div id="cityerror" class="errorReports"><p></p></div>
                                        </div>
                                        <div class="form-group radioGender">
                                            <div class="row ">
                                                <div class="col-sm-4">
                                                    <asp:RadioButton class="radio" ID="male" value="1" Text="Male" runat="server" GroupName="gender" />
                                                </div>
                                                <div class="col-sm-2">
                                                    <asp:RadioButton class="radio" ID="female" value="2" Text="Female" runat="server" GroupName="gender" />
                                                </div>
                                                
                                            </div>
                                            <div id="gendererror" class="errorReports"><p></p></div>
                                        </div>
                                        <div class="form-group">
                                            <asp:TextBox class="form-control email" name="email" ID="email" OnTextChanged="email_TextChanged" placeholder="Mail ID" runat="server" AutoCompleteType="Disabled" TextMode="Email" AutoPostBack="False"></asp:TextBox>
                                            <div id="emailExist" class="errorReports"><p></p></div>
                                        </div>
                                        <div class="form-group">
                                            <asp:TextBox class="form-control mobile"  name="mobile" ID="mobile" placeholder="Mobile Number" runat="server" AutoCompleteType="Disabled" MaxLength="10" TextMode="Phone"></asp:TextBox>
                                            <div id="mobileerror" class="errorReports"><p></p></div>
                                        </div>
                                        <div class="form-group">
                                            <asp:TextBox class="form-control pswd" name="pswd" ID="pswd" placeholder="Password" runat="server" AutoCompleteType="Disabled" TextMode="Password"></asp:TextBox>
                                            <div id="passworderror" class="errorReports"><p></p></div>
                                        </div>
                                        <div class="form-group">
                                            <div class="row">
                                                <div class="col-sm-6 col-sm-offset-3">
                                                    <asp:Button ID="btnregister" name="register-submit"  CssClass="form-control btn btn-register"   runat="server" Text="Sign Up" />
                                                    <p id="rrsReg">&copy;RRSCreations</p>
                                                </div>
                                            </div>
                                        </div>
                                                                               
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
           
        </div>
        <div id="msg">
            <p style="color: white"></p>
            </div>
    </form>
</body>
</html>
