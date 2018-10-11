/**
 * Created by sri on 19/11/15.
 */

var companyId;

$(document).ready(function () {


    function pageLoad() {

        $('#addStaffForm').parsley();

        $("#getUserForm").parsley();


        $('#datePicker').datetimepicker({
            format: 'YYYY-MM-DD'
        });

        $(".select2").each(function () {
            $(this).select2($(this).data());
        });

        $("#companyId").change(function () {
            $("#branchId").select2('val', '');
            companyId = $("#companyId").val();
            getBranchListForCompany(companyId);
        });
        $("#companyId").trigger("change");


    }

    pageLoad();
    SingApp.onPageLoad(pageLoad);

});


function getBranchListForCompany(companyId) {
    $.ajax({
        type: "Get",
        url: 'GetBranchListForCompany',
        data: {companyId: companyId},
        success: function (data) {
            $("#branchId").empty();
            var result = JSON.parse(data);
            for (var i = 0; i < result.length; i++) {
                $("#branchId").append('<option  value=' + result[i].branchId + '>' + result[i].branchName + '</option>');
            }
        },
        error: function () {
            $("#result").html('There is error while submit');
        }
    });
}
