jQuery(document).ready(function ($) {

    //login validations
    //login email checking
    var existFlag = 0;
    $("#mailid").keyup(function (e) {
        //Validating Email
       

        if (!ValidateEmail($("#mailid").val())) {
            $("#emailerror").text("✖ Invalid Email Address");
            $('#emailerror').css('color', '#701010');
        }
        else {
            var mailid = $('#mailid').val();
            //alert(mailid);
            $.ajax({
                url: 'CustomerService.asmx/CheckCutomerExist',
                data: { customermail: mailid },
                method: 'post',
                dataType: 'xml',
                success: function (data) {
                    var jQueryXml = $(data);

                    if (jQueryXml.find('customerExist').text() == 'true' && jQueryXml.find('statusFlag').text() =='True') {
                        existFlag = 1;
                        $("#emailerror").text("✔ Valid Email ID");
                        $('#emailerror').css('color', '#3d7a0f');
                       
                    } else if (jQueryXml.find('statusFlag').text() == 'False') {
                        $("#emailerror").text("✖ This Email is Deactived");
                        $('#emailerror').css('color', '#701010');
                    }else {
                        $("#emailerror").text("✖ Email Not Register");
                        $('#emailerror').css('color', '#701010');
                       
                    }
                    //console.log(jQueryXml);

                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function ValidateEmail(email) {
            var expr = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
            return expr.test(email);
        };

        if ($('#mailid').val().length == 0) {
            $("#emailerror").text("✖ Email Required");
            $('#emailerror').css('color', '#701010');
        }
        //Validating Email

    });

    //Validating login Password
    $("#loginpassword").keyup(function (e) {
        if ($('#loginpassword').val().length==0) {
            $("#loginpassworderror").text("✖ Password Required");
            $('#loginpassworderror').css('color', '#701010');
        }
        else {
            $('#loginpassworderror').text("");
        }
    });
    //Validating login Password

    $("#loginButton").click(function (e) {
        e.preventDefault();
        e.stopPropagation();
        var mailid = $('#mailid').val();
        var pswd = $('#loginpassword').val();
        if (existFlag == 1 && pswd.length >= 4) {
            $.ajax({
                url: 'CustomerService.asmx/CheckLogin',
                data: {
                    customermail: mailid,
                    Enteredpassword: pswd
                },
                method: 'post',
                dataType: 'xml',
                success: function (data) {
                    var jQueryXml = $(data);

                    if (jQueryXml.find('validCustomer').text() == 'True' && jQueryXml.find('statusFlag').text() == 'True') {
                        //alert();
                        localStorage.setItem('userName', jQueryXml.find('name').text());
                        if ($('#mailid').val() == 'admin@gmail.com') {
                            window.location.href = "AdminPage.aspx";
                        } else {
                            window.location.href = "HomePage.aspx";
                        }
                       

                    } else {
                        swal("uh ohh !! Wrong Password... ", "Please Enter Correct Password", "error");
                        $("#loginpassworderror").text("✖ Password Incorrect");
                    }
                    //console.log(jQueryXml);

                },
                error: function (err) {
                    console.log(err);
                }
            });
        } else {
            swal("uh ohh !! Wrong Credential... ", "Entered Email & Password Not Matched", "error");
        }
        

    });

    //ShowHide Password in login page
    $('#ShowPassword').click(function () {
        $('#loginpassword').attr('type', $(this).is(':checked') ? 'text' : 'password');
    });  
    //ShowHide Password

    //login validations



    //validations
    $("#email").keyup(function (e) {

        //Validating Email
        
        if (!ValidateEmail($("#email").val())) {
            $("#emailExist").text("✖ Invalid Email Address");
        }
        else {
            var mailid = $('#email').val();
            //alert(mailid);
            $.ajax({
                url: 'CustomerService.asmx/CheckCutomerExist',
                data: { customermail: mailid },
                method: 'post',
                dataType: 'xml',
                success: function (data) {
                    var jQueryXml = $(data);

                    if (jQueryXml.find('customerExist').text() == 'true') {
                        $("#emailExist").text("✖ Email Already Existed");
                    } else {
                        $("#emailExist").text("✔ Valid Email ID");
                        $('#emailExist').css('color', 'green');
                    }
                    //console.log(jQueryXml);

                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        function ValidateEmail(email) {
            var expr = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
            return expr.test(email);
        };

        //Validating Email
        
    });

    //Validating mobile no
    $("#mobile").keyup(function (e) {
        if (validatePhone('mobile')) {
            $("#mobileerror").text("✔ Valid Mobile Number");
            $('#mobileerror').css('color', 'green');
        }
	   else {
            $("#mobileerror").text("✖ Invalid Mobile Number");
        }
    });
    function validatePhone(mobile) {
        var a = document.getElementById(mobile).value;
        var filter = /^[0-9-+]+$/;
        if (filter.test(a) && a.length ==10) {
            return true;
        }
        else {
            return false;
        }
    }
    //Validating mobile no

    //Validating Full Name
    $("#name").keyup(function (e) {
        if (validateName('name')) {
            $("#nameerror").text("✔ Valid Name");
            $('#nameerror').css('color', 'green');
        }
        else {
            $("#nameerror").text("✖ Invalid Name");
        }
    });
    function validateName(i) {
        var a = document.getElementById("name").value;
        var filter = /^[A-Za-z_ ]+$/;
        if (filter.test(a) && a.length >5) {
            return true;
        }
        else {
            return false;
        }
    }
    //Validating Full Name

    //Validating Gender
    $("#male").blur(function (e) {
        $("#gendererror").text("✔ You are Male");
        $('#gendererror').css('color', 'green');
        $('#gendererror').css('margin-left', '290px');
        $('#gendererror').css('margin-top', '3px');
    });
    $("#female").blur(function (e) {
        $("#gendererror").text("✔ You are Female");
        $('#gendererror').css('color', 'green');
        $('#gendererror').css('margin-left', '290px');
        $('#gendererror').css('margin-top', '3px');
    });
    //Validating Gender
    
    //validating cities
    $("#DropDownList1").blur(function (e) {
        if ($('#DropDownList1').val()!="select") {
            $("#cityerror").text("✔ Valid Location");
            $('#cityerror').css('color', 'green');
        }
        else {
            $("#cityerror").text("✖ Invalid Location");
        }
    });
    //validating cities

    //Validating Password
    $("#pswd").keyup(function (e) {
        if ($('#pswd').val().length >= 4) {
            $("#passworderror").text("✔ Valid Password");
            $('#passworderror').css('color', 'green');
        }
        else {
            $("#passworderror").text("✖ Minimum 4 characters");
        }
    });
    //Validating Password



    //sending registrations data to webserive
    
    $("#btnregister").click(function (e) {
        e.preventDefault();
        e.stopPropagation();
        var gen; 
       
        if ($('input[id=male]').is(":checked")) {
            gen = "Male";  
        } else if ($('input[id=female]').is(":checked")) {
            gen = "Female";
        } else {
            gen = "no";
        }

      
        
        
        if ($('input[id=male]').is(":checked") || $('input[id=female]').is(":checked"))
        {
           // alert($('input[id=male]').is(":checked") + " " + $('input[id=female]').is(":checked") + " name leg: " + $('#name').val().length + " locaion: " + $('#DropDownList1 option:selected').text().length + " mail:" + $('#email').val().length + " mobi:" + $('#mobile').val().length + " pass:" + $('#pswd').val().length);
            if ($('#name').val().length > 5 && $('#DropDownList1').val() != "select" && $('#email').val().length > 5 && $('#mobile').val().length == 10 && $('#pswd').val().length >= 4)
            {
                $.ajax({
                    url: 'CustomerService.asmx/Registrations',
                    data: {
                        fullname: $('#name').val(),
                        location: $('#DropDownList1 option:selected').text(), //location
                        gender: gen,
                        customermail: $('#email').val(),
                        mobileno: $('#mobile').val(),
                        password: $('#pswd').val()
                    },
                    method: 'post',
                    dataType: 'xml',
                    success: function (data) {
                        var result = $(data);
                        if (result.find('registrationSuccessFlag').text() == "true") {
                            swal("Registration Successfully !!", "Thanks to join in Health Bridge !!", "success")
                                .then((value) => {
                                    $('#name').val('');
                                    $("#DropDownList1")[0].selectedIndex = 0;
                                    $('input:radio[name=gender]').attr('checked', false);
                                    $('#email').val('');
                                    $('#mobile').val('');
                                    $('#pswd').val('');

                                    // Move to login Division
                                    $("#login-form").delay(100).fadeIn(100);
                                    $("#register-form").fadeOut(100);
                                    $('#register-form-link').removeClass('active');
                                    $(this).addClass('active');

                                    //clear all error reports
                                    $("#nameerror").text("");
                                    $("#cityerror").text("");
                                    $("#gendererror").text("");
                                    $("#emailExist").text("");
                                    $("#mobileerror").text("");
                                    $("#passworderror").text("");
                                })
                        }
                        else
                            swal("Registration Fail !!", "Sorry & Try Again !!", "error");
                    },
                    error: function (err) {
                        swal(" Error !!", "Server Problem Please Try Again", "error");
                    }
                });
            }
            else {
                swal("Please All Fill Columns", "Before Click The SignUp !!", "error");
            }
        } else {
            $("#gendererror").text("✖ Please Choose Gender");
            $('#gendererror').css('margin-left', '290px');
            $('#gendererror').css('margin-top', '3px');
        }
        
        
    });
    //sending registrations data to webserive

});
