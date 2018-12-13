$(document).ready(function (ee) {
    $("#logoutLink").click(function (e) {
        alert("I am ready");
        PageMethods.logoutCustomer(onComplete); // PageMethods.MyCSharpMethod(parameters, onComplete);
    });

    function onComplete(result, response, content) {
        alert(result);
    }

    //cities autocomplete code
    var availableCities = [
        "Hyderabad", "Bangalore", "Chennai", "Kadapa", "Vijayawada", "Pune", "Rajasthan",
        "Delhi", "Mumbai", "Kolkata", "Lucknow", "Visakhapatnam", "Mysore", "Guntur", "Kurnool",
        "Chittoor", "Anantapur", "Nellore", "Pondicherry", "Amaravati", "Srikakulam", "Madanapalle", "Tirupati"
    ];
    $(".suggestions #cities").autocomplete({
        source: availableCities
    });
    // cities autocomplete

    //Search bar dropdown doctors
    $('.search-panel .dropdown-menu').find('a').click(function (e) {
        e.preventDefault();
        var param = $(this).attr("href").replace("#", "");
        var concept = $(this).text();
        $('.search-panel span#search_concept').text(concept);
        $('.input-group #search_param').val(param);
    });
    //search bar dropdown doctors

    //get current city 
    $("#getLocationCities").click(function (e) {

        $.ajax({
            url: "https://geoip-db.com/jsonp",
            jsonpCallback: "callback",
            dataType: "jsonp",
            success: function (location) {
                $('#cities').val(location.city);
            }
        });
    });

    //get current city

    //deactivate account
    $("#deactiveAccount").click(function (e) {
        e.preventDefault();
        e.stopPropagation();
        swal({
            title: "Are you sure?",
            text: "To Permanently Deactive Your Account?",
            icon: "warning",
            buttons: true,
            dangerMode: true,
        }).then((willDelete) => {
            if (willDelete) {

                //send request to set status flag False
                $.ajax({
                    url: 'CustomerService.asmx/DeactiveAccount',
                    method: 'post',
                    dataType: 'xml',
                    success: function (data) {
                        var jQueryXml = $(data);

                        if (jQueryXml.find('statusFlag').text() == 'False') {
                            swal("Your Account Successfully Deactivated !!!", {
                                icon: "success",
                            });
                            window.location.href = "/index.aspx";
                        } else {
                            swal("uh oh !! Sorry..Someething Went Wrong Please Try Again...", {
                                icon: "error",
                            });
                        }
                        //console.log(jQueryXml);

                    },
                    error: function (err) {
                        console.log(err);
                    }
                });
                //send request to set status flag False

            } else {
                swal("Uff.. Your Account is safe !!");
            }
        });
    });
    //deactivate account



    //automacatically get the all doctors list on page load
    var doctorsJsonData;

    $.ajax({
        url: 'DoctorService.asmx/GetAllDoctors',
        dataType: "json",
        method: 'post',
        success: function (data) {
            var doctorsTable = $('#tableDoctors tbody');
            doctorsTable.empty();
            doctorsJsonData = data;
            $(data).each(function (index, doctor) {
                var appendEl = $("<div class='row upperDivSearchResult' ></div>").appendTo("#new_row");
                $("</div><div class='col-sm-8 col-sm-offset-2 doctorsDiv'><div class='container-fluid text-center'><div class='row content'><div class='col-sm-3 sidenav'><div class='col-sm-12' >" + "<img style='height:150px;width:200px;margin-left:-30px; border-radius:10px;' src='../images/uploads/" + doctor.Image + "' alt='Hospital Logo'></div><div class='col-sm-12 ' ><p class='ratingStars'>" +doctor.Rating+ "<i class='fa fa-star' style='font-size: 15px'></i>" + "</p></div></div>" +
                    "<div class='col-sm-9 text-center'> <div class='row'> <div class='col-sm-7 headingName'><p>" + doctor.HospitalName.toUpperCase() + "</p></div> <div class='col-sm-5 '><p class='fee'> Consultancy Fee Rs: " + doctor.ConsultancyFee + "/-</p></div></div>" +
                    " <div class='row'> <div class='col-sm-6'><p> Dr. " + doctor.DoctorName + "</p></div> <div class='col-sm-6'><p> " + doctor.Specialization + "</p></div></div>" +
                    " <div class='row'> <div class='col-sm-6'><p>" + doctor.HospitalLocation + "</p></div> <div class='col-sm-6'><p> " + doctor.HospitalAddress + "</p></div></div>" +
                    " <div class='row'> <div class='col-sm-6'><p class='timings'>" + "10 AM to 8 PM" + "</p></div> <div class='col-sm-6'>" + "<button type='button' class='btn btn-success  btn-block bookNowButton' value='" + doctor.HospitalId +"' id='" + doctor.HospitalId + "' >Book Now</button>" + "</div></div></div>" +
                    "</div></div></div>").appendTo(appendEl);

            });
            
        },
        error: function (err) {
            alert(err);
        }
    });

    //specalizations search
    var specalization;
    $("#specializations li").click(function () {
        specalization = $("a", this).attr('href');
    });

    //specalizations search
  

    //Search button calls the webservice to get doctors data
    function filter_by_city_specalization(city, specalization, obj) {
        var new_obj = {}, total = 0, city = city.toLowerCase();
        if (specalization != undefined)
            specalization = specalization.toLowerCase();
         
        for (var i in obj) {
            var location = obj[i].HospitalLocation.toLowerCase();
                var special = obj[i].Specialization.toLowerCase();
            if (location == city && special == specalization) {
                new_obj[i] = obj[i];
                total++;
            }
            else if (specalization == 'all' || specalization == undefined  && location == city) {
                new_obj[i] = obj[i];
                total++;
            }
            else if (city.length == 0 && specalization == special) {
                new_obj[i] = obj[i];
                total++;
            } else if (specalization == 'all') {
                new_obj[i] = obj[i];
                total++;
            } else if (specalization == 'undefined' && location == city) {
                new_obj[i] = obj[i];
                total++;
            }
        }
        if (total > 0) return new_obj;
        return false;
    }
    $("#searchButton").click(function (e) {
       
        if ($("#cities").val().length == 0 && specalization == undefined) {
                swal("Please Choose Either Your City Or Surgeon Type");
        } else {
            $("#resultHeading").css('color', 'rgba(255,255,255,0.8)');
            if ($("#cities").val().length != 0 && specalization == undefined)
                $("#resultHeading").text("Available Best Doctors in " + $("#cities").val());
            else if (specalization != undefined && $("#cities").val().length == 0)
                $("#resultHeading").text("Available Best " + specalization +"s");

            $(".upperDivSearchResult").remove();
            var filtered_data = filter_by_city_specalization($("#cities").val(), specalization, doctorsJsonData);
           
            if (Object.keys(filtered_data).length > 0) {
                for (var i in filtered_data) {
                    var appendEl = $("<div class='row upperDivSearchResult' ></div>").appendTo("#new_row");
                    $("</div><div class='col-sm-8 col-sm-offset-2 doctorsDiv'><div class='container-fluid text-center'><div class='row content'><div class='col-sm-3 sidenav'><div class='col-sm-12' >" + "<img style='height:150px;width:200px;margin-left:-30px; border-radius:10px;' src='../images/uploads/" + filtered_data[i].Image + "' alt='Hospital Logo'></div><div class='col-sm-12 ' ><p class='ratingStars'>" + filtered_data[i].Rating + "<i class='fa fa-star' style='font-size: 15px'></i>" + "</p></div></div>" +
                        "<div class='col-sm-9 text-center'> <div class='row'> <div class='col-sm-7 headingName'><p>" + filtered_data[i].HospitalName.toUpperCase() + "</p></div> <div class='col-sm-5 '><p class='fee'> Consultancy Fee Rs: " + filtered_data[i].ConsultancyFee + "/-</p></div></div>" +
                        " <div class='row'> <div class='col-sm-6'><p> Dr. " + filtered_data[i].DoctorName + "</p></div> <div class='col-sm-6'><p> " + filtered_data[i].Specialization + "</p></div></div>" +
                        " <div class='row'> <div class='col-sm-6'><p>" + filtered_data[i].HospitalLocation + "</p></div> <div class='col-sm-6'><p> " + filtered_data[i].HospitalAddress + "</p></div></div>" +
                        " <div class='row'> <div class='col-sm-6'><p class='timings'>" + "10 AM to 8 PM" + "</p></div> <div class='col-sm-6'>" + "<button type='button' class='btn btn-success  btn-block bookNowButton' value='" + filtered_data[i].HospitalId +"' id='" + filtered_data[i].HospitalId + "' >Book Now</button>" + "</div></div></div>" +
                        "</div></div></div>").appendTo(appendEl);

                }
            } else {
                var appendEl = $("<div class='row upperDivSearchResult' ></div>").appendTo("#new_row");
                $("</div><div class='col-sm-8 col-sm-offset-2 doctorsDiv'><div class='container-fluid text-center'><div class='row'>" + "<img style='height:100px;width:150px;margin-top:20px;margin-bottom:20px border-radius:10px;' src='../images/noresult.png' alt='Hospital Logo'> " + "</div><div class='row' >" + "<p style='color:rgba(198, 0, 0,0.4) ; font-size: 20px; '><i class='fa fa-chain-broken'></i> uh oh !! Sorry Try Again</p>"+"</div> </div></div>").appendTo(appendEl);
            }
        }

    });
    //Search button calls the webservice to get doctors data

    //Book Now button calls the webservice to get doctors data
    $(' #new_row ').on('click', '.bookNowButton', function () {
        //alert('I am working' + this.value);

    });

    //tool tips
    $('[data-toggle="tooltip"]').tooltip();
    //tool tips


   
});