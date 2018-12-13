<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CapricornUploads.aspx.cs" Inherits="Health_Bridge.CapricornUploads" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="css/modal.css" rel="stylesheet" />
      <script src="//code.jquery.com/jquery-1.10.2.js"></script>
     <style>
      
        .pip {
            display: inline-block;
            margin: 10px 10px 0 0;
            max-width: 100px;

        }
       
        .remove {
            padding:4px;
            width: 15px;
            height:15px;
            margin-left:18px;
            display: block;
            background-color: rgba(255,0,0,0.6);
            color: white;
            text-align: center;
            border-radius:50px;
            cursor: pointer;
            font-size:15px;
            box-shadow: 0px 3px 6px rgba(0,0,0,0.4);
        }

            .remove:hover {
              background-color: rgba(255,0,0,0.8);
                color: white;
                transition-duration:0.1s;
            }
       

        .imageThumb {
            height: 50px;
            width: 50px;
            margin: 10px 10px 0 0;
            padding: 1px;
            border-radius: 5px 5px 0px 0px;
            border: 1px solid cadetblue;
        }
        .imageThumb:hover{
            border: 1px solid black;
            cursor: pointer;
        }
         .openModel {
                padding: 8px;
                background-color: rgba(255,255,255,0.9);
                text-decoration: none;
                text-align: center;
                font-size:13px;
                font-weight: bold;
                color: rgba(0,0,0,0.6);
                position: absolute;
                margin-top:22px;
                border: 1px dashed rgba(0,0,0,0.5);
         }
 

    </style>

   
    <script>
        
        $(function () {
            var chooseId, ids;
            var fileList = {};
            var list = [];
            var filesLength;
            var files;
            var duplicateFlag;
            var inModal = "#modalRow";
            $('.fileChoose').on("change", function (e) {
                chooseId = $(this).attr('id');
                ids = "#div_" + $(this).attr('id'); //N~1~11~File
                files = e.target.files;
           
                //alert('File Choosed' + chooseId)

                filesLength = files.length;

                var filesArr = Array.prototype.slice.call(files);
                filesArr.forEach(function (f) {
                   duplicateFlag = checkDuplicate(f.name);
                    if (duplicateFlag == 0)
                        list.push(f);
                    else if (duplicateFlag == 1) {
                       
                    }
                        
                });
                
               
                if (fileList[chooseId]!=null) {
                     list=list.concat(fileList[chooseId]);
                }
               
                fileList[chooseId] = list;
                generateImages(chooseId,"initial");
                list = [];
                //console.log('I am' + chooseId);
                $(this).val('');
                console.log(fileList);
               
                return (false)
            });

            function checkDuplicate(fileName) {
                for(var i in fileList[chooseId]) {
                   // console.log("Name: " +);
                    if (fileList[chooseId][i].name == fileName) {
                        return 1;
                        break;
                    }
                   
                }
                return 0;
            }

            var modalID,deleteList=[];
            function generateImages(indexid, flag) {
                if (flag == "initial") {
                     var getDivId = "#div_"+indexid;
                    $(getDivId).html("");
                   
                    for (var i = 0; i < fileList[indexid].length; i++) {
                        if (i < 10) {
                            //console.log('Hai');
                            var f =  fileList[indexid][i];
                            var fileReader = new FileReader();
                            fileReader.fileName =  fileList[indexid][i].name;
                            fileReader.onload = (function (e) {
                                var file = e.target;

                                $("<span class=\"pip\" id =\"" + e.target.fileName + "\">" +
                                    "<img class=\"imageThumb\"  title=\""+ e.target.fileName+"\" src=\"" + e.target.result + "\" +data-file=\"" + f.name + "\" id=\"" + indexid + "\"/>" +
                                    "<br/><span class=\"remove\"  id =\"" + indexid + "\">&times;</span>" +
                                    "</span>").prependTo(getDivId);

                                 $(".imageThumb").unbind().click(function (event) {
                                     console.log($(this).attr("id"));
                                     for (var i in fileList[$(this).attr("id")]) {
                                        if (fileList[$(this).attr("id")][i].name == $(this).parent(".pip").attr("id")) {
                                           var ff =  fileList[$(this).attr("id")][i];
                                            var fileReader1 = new FileReader();
                                            fileReader1.onload = (function (ee) {
                                                url = ee.target.result;
                                                img = '<img src="'+url+'" >';
                                                var w = window.open("", "_blank", "width=750,height=500,resizable=no,top=100,left=350").document.write(img);
                                               
                                            });
                                             fileReader1.readAsDataURL(ff);
                                            break;
                                        }
                                    }   
                                });
                               

                                $(".remove").unbind().click(function (event) {
                                   // alert($(this).parent(".pip").attr("id"));
                                    $(this).parent(".pip").remove();
                                    for (var i in fileList[$(this).attr("id")]) {
                                        if (fileList[$(this).attr("id")][i].name == $(this).parent(".pip").attr("id")) {
                                            fileList[$(this).attr("id")].splice(i, 1);
                                            break;
                                        }
                                    }
                                     generateImages($(this).attr("id"), "initial");
                                     console.log(fileList);
                                });

                            });
                            fileReader.readAsDataURL(f);
                        } else if (i == 10) {
                            var remainFile = fileList[indexid].length - 10;
                            $("<a href=\"#example2\" class=\"openModel\" id=\"" + indexid + "\">" +"+"+remainFile+"<br>More"+ " </a>").prependTo(getDivId);

                            $(".openModel").unbind().click(function (ee) {
                                modalID = $(this).attr("id");
                                generateImages($(this).attr("id"), "modal");
                            });
                        }
                    }
                }
                else if (flag=="modal")
                {
                    $("#modalRow").html("");
                    
                    for(var i = 0; i < fileList[indexid].length; i++) {
                        var f = fileList[indexid][i];
                        var fileReader = new FileReader();
                        fileReader.fileName =  fileList[indexid][i].name;
                        fileReader.onload = (function (e) {
                            var file = e.target;

                            $("<span class=\"pip\" id =\"" + e.target.fileName + "\">" +
                                "<img class=\"imageThumb\" title=\""+ e.target.fileName+"\" src=\"" + e.target.result + "\" +title=\"" + f.name + "\"+ id=\"" + indexid + "\"/>" +
                                "<br/><span class=\"remove\"  id =\"" + indexid + "\">&times;</span>" +
                                "</span>").prependTo(".experiment #modalRow");


                             $(".imageThumb").unbind().click(function (event) {
                                     console.log($(this).attr("id"));
                                     for (var i in fileList[$(this).attr("id")]) {
                                        if (fileList[$(this).attr("id")][i].name == $(this).parent(".pip").attr("id")) {
                                           var ff =  fileList[$(this).attr("id")][i];
                                            var fileReader1 = new FileReader();
                                            fileReader1.onload = (function (ee) {
                                                url = ee.target.result;
                                                img = '<img src="'+url+'" style="width:700px;">';
                                                window.open("","_blank","width=750,height=500,resizable=no,top=100,left=350").document.write(img);                        
                                            });
                                             fileReader1.readAsDataURL(ff);
                                            break;
                                        }
                                    }   
                                });


                            $(".remove").unbind().click(function (event) {
                                $(this).parent(".pip").remove();
                                deleteList.push($(this).parent(".pip").attr("id"));
                            });
                        });
                        fileReader.readAsDataURL(f);
                    }
                }
            }



            $(".cancel").click(function () {
                generateImages(modalID, "initial");
                window.location.href = '#close';

            });
             $(".close").click(function () {
                generateImages(modalID, "initial");
                window.location.href = '#close';

            });
             $(".save").click(function () {
                // alert(modalID);
                 for (var i = 0; i < deleteList.length; i++) {
                     for (var j = 0; j < fileList[modalID].length;j++) {
                         if (deleteList[i] == fileList[modalID][j].name) {
                             fileList[modalID].splice(j, 1);
                         }
                     }
                }
                 console.log(fileList);
                 $("#div_" + modalID).html("");
                 window.location.href = '#close';
                 generateImages(modalID, "initial");
                 deleteList = [];
            });

            /*window.onresize = function() {
                $("#demoText").text($(window).width());
                $("#mydiv").width(width);
            }*/
           
        });

     </script>
 
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table id="handler">
                <tr>
                    
                    <td>
                         <asp:FileUpload ID="FileUpload123" class="fileChoose" runat="server" Width="95" AllowMultiple="true" />
                        <div id="div_FileUpload123"></div>
                       
                    </td>
                </tr>
                <tr>
                  
                    <td>
                         <asp:FileUpload ID="FileUpload456" class="fileChoose"  Width="95" runat="server" AllowMultiple="true" />
                        <div id="div_FileUpload456"></div>
                    </td>
                </tr>
                <tr>
                    
                    <td>
                         <asp:FileUpload ID="FileUpload789" class="fileChoose"  Width="95" runat="server" AllowMultiple="true" />
                        <div id="div_FileUpload789"></div>
                    </td>
                </tr>
            </table>
        </div>


         <div class="experiment">
            <div class="wrapper"> 
                <aside id="example2" class="modal">
                    <div class="innerModal">
                         <div id="header">
                             <img src="images/favicon.ico" />
                         </div>
                        <h3>Crew Visit</h3>
                         <h4>Selected Files</h4>
                        <div id="modalRow"></div>
                        
                        <div id="options">
                            <input type="button" class="cancel" value="Cancel"/>
                            <input type="button" class="save" value="Ok"/>
                        </div>
                    </div>
                </aside>

            </div>

        </div>

       <!-- <p id="demoText"></p>-->
    </form>
</body>
</html>
