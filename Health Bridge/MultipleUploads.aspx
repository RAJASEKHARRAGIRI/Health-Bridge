<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MultipleUploads.aspx.cs" Inherits="Health_Bridge.MultipleUploads" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Multiple Uploads</title>
    <link rel="stylesheet" href="css/style.css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <style>
        body {
            
            background-color: aliceblue;
        }
        .pip {
            display: inline-block;
            margin: 10px 10px 0 0;
            max-width: 100px;

        }
        .fileName{
            display:inline-block;
            max-width:75px;
            max-height: 20px;
            overflow: hidden;
            position:absolute;
            font-size:9px;
            color: black;
            padding-left:2px;
        }
        .remove {
            padding-left:3px;
            padding-right:3px;
            display: block;
            background-color: aqua;
            color: black;
            text-align: right;
            cursor: pointer;
            font-size:15px;
            box-shadow: 0px 5px 10px rgba(0,0,0,0.4);
        }

            .remove:hover {
              background-color: aqua;
                color: indianred;
                transition-duration:0.1s;
            }
        #up {
            display: none;
        }
            #uploadgif p{
                font-size:14px;
                color: darkmagenta;
                text-align: left;
                padding-left:5px;
            }

        .imageThumb {
            height: 100px;
            width: 100px;
            margin: 10px 10px 0 0;
            padding: 1px;
            border-radius: 5px 5px 0px 0px;
            border: 1px solid cadetblue;
        }
        .imageThumb:hover{
            cursor:pointer;
            transform: scale(2.5,2.5);
            transition-delay:0.5s;
            border: none;
        }

        input[type="file"] {
            display: none;
        }
        #count{
            font-weight: bold;
        }
    #form1 .custom-file-upload {
        background-color: aliceblue;
        border: 1px solid #ccc;
        box-shadow: 3px 3px 5px black;
        display: inline-block;
        padding: 6px 12px;
        cursor: pointer;
    }
        #btnUpload {
        margin-top:2px;
        box-shadow: 2px 2px 10px black;
        font-size:15px;
        }

        

    </style>
    <script>
        $(document).ready(function () {
        
                 var fileList = [];
                 var filesLength;
                 if (window.File && window.FileList && window.FileReader) {
                     $("#FileUpload1").on("change", function (e) {
                         var files = e.target.files,
                             filesLength = files.length;

                         var filesArr = Array.prototype.slice.call(files);
                         filesArr.forEach(function (f) {
                             fileList.push(f);
                         });
                         $("#count").text("Total Files "+fileList.length);
                         console.log(fileList);

                         for (var i = 0; i < filesLength; i++) {
                             var f = files[i];
                             var fileReader = new FileReader();
                             fileReader.fileName = $("#FileUpload1")[0].files[i].name;
                             
                             fileReader.onload = (function (e) {
                                 var file = e.target;
                                 console.log(e.target.fileName);
                                 // var appendEl = $("<div class='row upperDivSearchResult' ></div>").appendTo("#new_row");
                                 $("<span class=\"pip\" id =\"" + e.target.fileName + "\">" +
                                     "<img class=\"imageThumb\" src=\"" + e.target.result + "\"  id=\"" + e.target.fileName + "\"/>" +
                                     "<br/><div class=\"fileName\">" + e.target.fileName + "</div><span class=\"remove\"><i class='fa fa-trash' title=\"Delete\"></i></span>" +
                                     "</span>").insertAfter("#newrow");


                                 $(".remove").unbind().click(function (event) {
                                     $(this).parent(".pip").remove();
                                     fileList.splice(fileList[0].name.indexOf($(this).parent(".pip").attr("id")), 1);
                                     console.log(fileList);
                                      $("#count").text("Total Files "+fileList.length);
                                 });
                                 
                                



                             });
                             fileReader.readAsDataURL(f);
                         }
                     });
                 } else {
                     alert("Your browser doesn't support to File API")
                 }

                 $("#btnUpload").click(function (e) {
                     e.preventDefault();
                     if (fileList.length > 0) {
                         $("#up").show();
                         var data = new FormData();

                         for (var i = 0, len = fileList.length; i < len; i++) {
                             data.append('FileUpload1', fileList[i]);
                         }

                         $.ajax({
                             type: "POST",
                             url: "UploadImages.ashx",
                             data: data,
                             contentType: false,
                             processData: false,
                             success: function (response) {
                                 $("#up").hide();
                                 swal("Successfully Uploaded!!!", fileList.length + " Files", "success")
                                     .then((value) => {
                                         location.reload();
                                     });

                             },
                             error: function (err) {
                                 alert("Error");
                             }
                         });
                     } else {
                         swal("Please Choose Files" ," Before upload", "warning");
                     }
                     
                });

                
                $('#clickLabel').click( function () {
                    $('#FileUpload1').click();
                });

        });


    </script>

</head >
<body>
    <form id="form1" runat="server">
        <div class="field">
            <div class="row" style="margin-top:100px;">
                <div class="col-sm-10 col-sm-offset-1">
                     <div class="row">
                         <div class="col-sm-3 ">
                             <h3><b>Upload Multiple Files </b></h3>
                          </div>
                        </div><br />
                        <div class="row">
                            <div class="col-sm-3 " id="rowChoose">
                                 <label for="file-upload" class="custom-file-upload btn-block" id="clickLabel">
                                    <i class="fa fa-cloud-upload"></i> Upload Your Files
                                </label>
                                <asp:FileUpload ID="FileUpload1"  runat="server" AllowMultiple="true" />
                            </div>
                            <div class="col-sm-2" >
                                <asp:Button ID="btnUpload" class="btn btn-primary btn-block" runat="server" Text="Upload" />
                            </div>
                        </div>
                        <h6 id="count">Total Files 0</h6>
                        <div class="row">
                            <div class="col-sm-2 col-sm-offset-5" id="up">
                                <div id="uploadgif"><img src="images/sending.gif" width="110"/><p>Files Uploading....</p></div>
                            </div>
                        </div>

                        <hr />
                        <div class="row" id="newrow">

                        </div>
                    </div>
                    
                </div>
            </div>
            
       

    </form>
</body>
</html>
