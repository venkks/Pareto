/**
 * Created by sri on 29/10/15.
 */

var branchId;
var id;

//$(document).ready(function () {
(function($){


    function pageLoad() {

        window.ParsleyValidator
            .addValidator('filetype', function (value, requirement) {
                // the value contains the file path, so we can pop the extension
                var fileExtension = value.split('.').pop();

                return fileExtension === requirement;
            }, 32).addMessage('en', 'fileextension', 'The extension doesn\'t match the required format');


        $("#getUserForm").parsley();

        $("#addMemberForm").parsley();

        $("#fileUploadForm").parsley();

        $("input[type=radio][name=addEntityType]").change(function(){

           if (this.value=="memberAndUser"){
               console.log("aft fun 2");
               $("#branchId").prop("disabled",false);
               $("#groupId").prop("disabled",false);
               $("#branchId").prop("required",true);
               $("#groupId").prop("required",true);
           }
            else{
               console.log("aft fun 2");
               $("#branchId").prop("disabled",true);
               $("#groupId").prop("disabled",true);
               $("#branchId").prop("required",false);
               $("#groupId").prop("required",false);
           }
        });


        $('#datePicker').datetimepicker({
           format: 'YYYY-MM-DD'
        });

        $("#dob").inputmask({mask: "9999-99-99"});
        console.log(" before select"+$("#branchId").val());

     //   $(".select2").each(function () {
       //     $(this).select2($(this).data());
       // });

        console.log("id.....");
        $("#branchId").change(function () {
            $("#groupId").select2('val', '');
            branchId = $("#branchId").val();
            console.log("branch");
            getGroups(branchId);
        });
        console.log("aft bran");

        $("#mobileNo").change(function () {
            // $(this).select2($(this).val());
            //validate();
        });

        $(".popupSection").click(function(){
            var data = $(this).attr("id");
            $("#popupId").val(data);
            data = data.replace("popup", "");
            var userData = $("#excelUser"+data).val();
            $("#confirmExcelUser").val(userData);

        });

        //$("#addExcelUser").click(function(){
        //    //alert("click");
        //   addExcelUser();
        //});

        /*For Notifications*/

        $('.widget').widgster();
        var theme = 'air';
        $.globalMessenger({theme: theme});
        Messenger.options = {theme: theme};
        var loc = ['top', 'left'];
        var $lsel = $('.location-selector');
        var update = function () {
            var classes = 'messenger-fixed';
            for (var i = 0; i < loc.length; i++)
                classes += ' messenger-on-' + loc[i];
            $.globalMessenger({extraClasses: classes, theme: theme});
            Messenger.options = {extraClasses: classes, theme: theme};
        };
        update();
        $lsel.locationSelector().on('update', function (pos) {
            loc = pos;
            update();
        });
        /*end notifications*/

    }

    pageLoad();
    SingApp.onPageLoad(pageLoad);

})(jQuery);


function getGroups(branchId) {
    //TODO: only fetch groups which are new and members<total_members.
    $.ajax({
        type: "Get",
        url: 'GetBranchGroupsForAddingMembers',
        data: "branchId=" + branchId,
        success: function (data) {
            $("#groupId").empty();
            var result = JSON.parse(data);
            for (var i = 0; i < result.length; i++) {
                $("#groupId").append('<option  value=' + result[i].groupId + '>' + result[i].groupName + '</option>');
            }
        }
    });
}

function validate() {
    var mobile = $("#contact").val();
    var pattern = /^[\s()+-]*([0-9][\s()+-]*){6,20}$/;
    if (pattern.test(mobile)) {
        //alert("Your mobile number : " + mobileNo);
        return true;
    }
    //alert("It is not valid mobile number");
    return false;

}

function addSuccess() {
    Messenger().post({
        message: 'Member added successfully!',
        type: 'success',
        showCloseButton: true
    });
    return false;
}

function addError() {
    Messenger().post({
        message: 'Member was not added successful. Please contact Administrator',
        type: 'error',
        showCloseButton: true
    });
    return false;
}

function showErrorMessage(message) {
    Messenger().post({
        message: message,
        type: 'error',
        showCloseButton: true
    });
    return false;
}

function importSuccess(msg) {
    Messenger().post({
        message: msg,
        type: 'success',
        showCloseButton: true
    });
    $("#msg").val("");
    return false;
}

//function addExcelUser() {
//    var confirmExcelUser = $("#confirmExcelUser").val();
//
//    confirmExcelUser = confirmExcelUser.replace("ExcelUser{", "");
//    confirmExcelUser = confirmExcelUser.replace("}", "");
//    for(var i=0; i<= confirmExcelUser.length; i++ ){
//        confirmExcelUser = confirmExcelUser.replace("'", "");
//    }
//    $.ajax({
//        type: "Post",
//        url: 'AddExcelUser',
//        data: {confirmExcelUser:confirmExcelUser},
//        success: function (data) {
//           var id = $("#popupId").val();
//            //alert(id);
//            $("#"+id).remove();
//            $.modal.close();
//        }
//    });
//}
