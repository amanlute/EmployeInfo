
$(document).ready(function () {

    getDesignationDropdown();
    getDepartmentCheck();
    getEmployees(); 
 
});

var ImageUpload = "";

//Upload File
function UploadFilePath() {

    var department = '';
    var ddlDepartment = $("#ddlDepartmentss").val();
    for (var i = 0; i < ddlDepartment.length; i++) {
        department += (department ? ',' : '') + ddlDepartment[i]
    }

    var file = $("#fileUpload")[0].files[0];
    if (file){
        var formData = new FormData();
        formData.append("file", file);
         // To store the uploaded file path

        var fileUploadSuccess = false;

        $.ajax({
            url: "/Emp/UploadFile", // Separate endpoint to upload image
            type: "POST",
            data: formData,
            contentType: false,
            processData: false,  
            success: function (response) {
                if (response.success) {
                    ImageUpload = response.filePath; // Store returned file path                

                    fileUploadSuccess = true;
                    var empData = {
                        EmpID: $('#empID').val(),
                        EmpCode: $('#txtCode').val(),
                        EmpName: $('#txtName').val(),
                        Gender: $('input[name="Gender"]:checked').val(),
                        SelectedDesignation: $('#ddlDesignation').val(),
                        Dept: department,
                        ProfilePicture: ImageUpload
                    };

                    console.log(empData)
                    $.ajax({
                        url: "/Emp/InsertEmployee",
                        type: "POST",
                        data: JSON.stringify(empData),
                        contentType: "application/json; charset=utf-8",
                        success: function (response) {
                            $("#btnSubmit").html("Submit")
                            if (response.success) {
                                alert("Employee inserted successfully!");
                                getEmployees()

                            } else {
                                alert("Failed to insert employee.");
                            }
                            $('#btnclear').click();
                        }
                    });

                } else {
                    alert("File upload failed.");
                    fileUploadSuccess = false;
                }
            },
            error: function () {
                alert("Error uploading file.");
                fileUploadSuccess = false;
            }
        });
      }
 }   
    
// Insert employee
$('#btnSubmit').click(function () {
    //var department = '';
    //var ddlDepartment = $("#ddlDepartmentss").val();
    //for (var i = 0; i < ddlDepartment.length; i++) {
    //    department += (department ? ',' : '') + ddlDepartment[i]
    //}
   
    //validations
    if ($('#txtCode').val() == '') {      //for Code
        iziToast.warning({ title: 'Hey', message: 'Enter Employee Code' });
        $("#txtCode").focus();
        return false;
    }

    if ($('#txtName').val()=='') {       //For Name
        iziToast.warning({ title: 'Hey', message: 'Enter Employee Name' });
        $("#txtName").focus();
        return false;
    }

    if ($('#ddlDepartmentss').val() == '') {       //For Department
        iziToast.warning({ title: 'Hey', message: 'Select At Least One Department' });
        $("#txtName").focus();
        return false;
    }

    if ($('#ddlDesignation').val() =='0') {       //for Designation
        iziToast.warning({ title: 'Hey', message: 'Select One Designation' });
        $("#txtName").focus();
        return false;
    }

    if (!$("input[name='Gender']:checked").val()) {  //For Gender
        iziToast.warning({ title: 'Hey', message: 'Select Gender' });
        return false;
    }
    var fileUploadSuccess = UploadFilePath();
});

// Clear data
$('#btnclear').click(function () {
    resetform()

});

//Edit Employee
$(document).on("click", ".update-btn", function () {
    var empId = $(this).data("id");
    $("#empID").val(empId);

    $.ajax({
        url: "/Emp/EditEmployee",
        type: "POST",
        data: { id: empId },
        success: function (emp) {
        
            //change button text
            $("#empID").val(empId),
            $("#btnSubmit").html("Update"),
            $('#txtCode').val(emp.EmpCode),
                $('#txtName').val(emp.EmpName),
                $("#ddlDesignation").val(emp.designationId).select2(),
                $("#profile").attr('src', emp.ProfilePicture),
          
                DeptValue = emp.Dept;
                var DeptArray = DeptValue.split(",");
            //document.querySelectorAll('.deptCheckbox').forEach((chk) => {
            //    var chkVal = chk.getAttribute('value')
            //    for (i = 0; i < DeptArray.length; i++) {
            //        if (chkVal == DeptArray[i]) {
            //            chk.checked = true;
            //        }
            //    }
            //});
            $('#ddlDepartmentss').val(DeptArray);
            $('#ddlDepartmentss').multiselect('refresh');

           

            if (emp.Gender === 1) {
                $("#male").prop('checked', true);
              
            }
            else {
                $("#female").prop('checked', true);
            }
        }
    });

});

// Delete employee
function deleteEmp(id) {
    
    $.ajax({
        url: "/Emp/DeleteEmp",
        type: "POST",
        data: { id: id },
        success: function (emp) {
            console.log(id);
            getEmployees();
        }
    });
};

function MakeActive(id) {
  
    $.ajax({
        url: "/Emp/MakeActive",
        type: "POST",
        data: { id: id },
        success: function (emp) {
            console.log(id);
            getEmployees();
        }
    });
};

//Get Designation
function getDesignationDropdown() {
    $.ajax({
        url: "/Emp/GetDesignations",
        type: "GET",
        success: function (data) {
            //   console.log(data);
            $.each(data, function (index, option) {
                console.log(option)
                $('#ddlDesignation').append($('<option></option>').attr('value', option.ID).text(option.DesignationName));
            });
            $('#ddlDesignation').select2();
        }
    });
}

//Get Department
function getDepartmentCheck() {
    $.ajax({
        url: "/Emp/GetDepartments",
        type: "GET",
        success: function (data) {
            $.each(data, function (index, option) {
               // console.log(option)
                $('#ddlDepartmentss').append($('<option></option>').attr('value', option.ID).text(option.DeptName));
            });
      
            $('#ddlDepartmentss').multiselect();
           
        }
    });
}

//Employee Get
function getEmployees() {
    $.ajax({
        url: "/Emp/getEmployees",
        type: "GET",
        success: function (data) {

            $("#tblform").DataTable().destroy();
            $("#employeeTableBody").empty();
            $("#employeeMakeActiveTableBody").empty();

            if (data.length === 0) {
                $("#employeeTableBody").append("<tr><td colspan='8'>No records found</td></tr>");
                $("#employeeGrid").show();
               
            }
            console.log(data);
            $.each(data, function (index, emp) {
               
                var genderVal = emp.Gender === 1 ? "Male" : "Female";             
                if (emp.IsActiveEmp == 1) {
                    var row = "<tr>" +
                        "<td>" + emp.EmpID + "</td>" +
                        "<td>" + emp.EmpCode + "</td>" +
                        "<td>" + emp.EmpName + "</td>" +
                        "<td>" + genderVal + "</td>" +
                        "<td>" + emp.Dept + "</td>" +
                        "<td>" + emp.Designations + "</td>" +
                        "<td><div class='d-flex'><button class='me-1 btn btn-primary update-btn' data-id='" + emp.EmpID + "'><i class='bi bi-pencil - square'></i></button>" +
                        "<button class='me-1 btn btn-danger delete-btn' onclick='deleteEmp(" + emp.EmpID + ")'><i class='bi bi-trash'></i></button>" +
                        "<button class='btn btn-success View-btn' onclick='View(" + emp.EmpID + ")'> <i class='bi bi-eye'></i></button></div></td> " +
                        "</tr>";
                    $("#employeeTableBody").append(row);
                }
                else {
                    var row = "<tr>" +
                        "<td>" + emp.EmpID + "</td>" +
                        "<td>" + emp.EmpCode + "</td>" +
                        "<td>" + emp.EmpName + "</td>" +
                        "<td>" + genderVal + "</td>" +
                        "<td>" + emp.Dept + "</td>" +
                        "<td>" + emp.Designations + "</td>" +
                        "<td><div class='d-flex'><button class='me-1 btn btn-primary update-btn' data-id='" + emp.EmpID + "'><i class='bi bi-pencil - square'></i></button>" +
                        "<button class='me-1 btn btn-warning delete-btn' onclick='MakeActive(" + emp.EmpID + ")'><i class='bi bi-check'></i></button>" +
                        "<button class='btn btn-success View-btn' onclick='View(" + emp.EmpID + ")'> <i class='bi bi-eye'></i></button></div></td> " +
                        "</tr>";
                    $("#employeeMakeActiveTableBody").append(row);
                }
               
            });
          
            $("#employeeGrid").show();
            $('#tblform').DataTable();
        },
        error: function () {
            alert("Failed to load employees.");
        }
    });
}

function View(id) {
    
    console.log("empId" + id);
    $.ajax({
        url: "/Emp/ViewEmployee",
        type: "POST",
        data: { id: id },
        success: function (emp) {
            
            console.log(emp)
            var genderVal = emp.Gender === 1 ? "Male" : "Female";  

            $("#modaltxtname").text(emp.EmpName);
            $("#modaltxtcode").text(emp.EmpCode);
            $("#modalrdogender").text(genderVal);
            // $("#modalchkdepartment").text(emp.Dept);

            var deptArray = emp.Dept.split(",");
            $('#ddlDepartment').val(deptArray).trigger("change");

            $("#modalddldesignation").text(emp.Designations);
            $("#profile").attr("src", emp.ProfilePicture);
            $("#exampleModal").modal("show");

            if (emp.ProfilePicture != "") {
                $(".img").show()
            }
            else {
                $(".img").hide()
            }

                      
        }

    });
}

function imagedownload() {
    var imageUrl = $("#profile").attr("src");
    var link = document.createElement("a");
    link.href = imageUrl;
    link.download = imageUrl; // You can customize the filename
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}

function resetform() {
    $('#txtCode').val('')
    $('#txtName').val('')
    $('input[name="Gender"]').prop('checked', false)
    $('#ddlDesignation').val(0).select2()
    $('#fileUpload').val('')
    $('#ddlDepartmentss option:selected').prop('selected', false);  
    $('#ddlDepartmentss').multiselect('rebuild');
}