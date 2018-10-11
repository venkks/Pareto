/**
 * Created by sri on 3/11/15.
 */

var branchId;
var groupId;
var memberId;
$(document).ready(function () {
    function pageLoad() {

        $("#collectPaymentForm").parsley();

        $(".select2").each(function () {
            $(this).select2($(this).data());
        });

        $("#branchId").change(function () {
            $("#groupId").select2('val', '');
            $("#memberId").select2('val', '');
            branchId = $("#branchId").val();
            getGroups(branchId);

        });
        $(".h").click(function(){
            $(".h").hide(10);
            $(".h").show(100);
        });

        //$('#collectButton').click(function(){
        //    $('#collectButton').attr("disabled", true);
        //});

        $("#groupId").change(function () {
            $("#memberId").select2('val', '');
            groupId = $("#groupId").val();
            getUsers(groupId);
        });
        $("#memberId").change(function() {
            memberId = $("#memberId").val();
            getMemberCurrentBalance(memberId);
        });
        //$('#branchId').select2().select2('val', $('.select2 option:eq(1)').val());
        //$('#branchId').trigger("change");

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

        $("#collectPaymentForm").validate({

            rules: {
                amount:{
                    required:true
                }
            },
            messages: {
                amount:{
                    required:"Please enter valid amount"
                }
            }
        });
    }

    pageLoad();
    SingApp.onPageLoad(pageLoad);


});


function getGroups(branchId) {
    $.ajax({
        type: "Get",
        url: 'GetBranchGroups',
        data: "branchId=" + branchId,
        success: function (data) {
            $("#groupId").empty();
            $("#memberId").empty();
            var result = JSON.parse(data);
            for (var i = 0; i < result.length; i++) {
                $("#groupId").append('<option  value=' + result[i].groupId + '>' + result[i].groupName + '</option>');
                //$('#groupId').select2().select2('val', $("#groupId option:first").val());
                $('#groupId').trigger("change");

            }
        }
    });
}

function getUsers(groupId) {
    $.ajax({
        type: "Get",
        url: 'GetMembersByGroupId',
        data: "groupId=" + groupId,
        success: function (data) {
            $("#memberId").empty();
            var result = JSON.parse(data);
            $("#memberId").append('<option  value=-1>(All)</option>');
            $('#memberId').select2().select2('val', $("#memberId option:first").val());
            for (var i = 0; i < result.length; i++) {
                $("#memberId").append('<option  value=' + result[i].memberId + '>' + result[i].fullName + ' - (' + result[i].mobileNo + ')' + '</option>');
                $('#memberId').select2().select2('val', $("#memberId option:first").val());
            }
        }
    });
}


function getMemberCurrentBalance(memberId){
    $.ajax({
        type : "Get",
        url : "getMemberCurrentBalance",
        data : "memberId=" + memberId,
        success : function(data){
            var result = JSON.parse(data);
            $("#balanceReminder").text(result['memberCurrentBalance']);
        }
    });
}

function addSuccess() {
    Messenger().post({
        message: 'Payment collected successfully!',
        type: 'success',
        showCloseButton: true
    });

    return false;
}

function addError() {
    Messenger().post({
        message: 'Payment was not collected successful. Please contact Administrator',
        type: 'error',
        showCloseButton: true
    });

    return false;
}
