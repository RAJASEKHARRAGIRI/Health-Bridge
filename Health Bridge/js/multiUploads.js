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
            $("#count").text("Total Files " + fileList.length);
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
                        $("#count").text("Total Files " + fileList.length);
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
            swal("Please Choose Files", " Before upload", "warning");
        }

    });


    $('#clickLabel').click(function () {
        $('#FileUpload1').click();
    });

});
