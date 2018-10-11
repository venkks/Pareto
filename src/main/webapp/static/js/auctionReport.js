/**
 * Created by sri on 16/11/15.
 */

var branchId;
var groupId;

$(document).ready(function () {


    function pageLoad() {
        $("#checkRow").hide();
        $("#auctionDetails").hide();
        $('#submit').prop("disabled", true);

        $(".select2:not(#bidderNumber0)").each(function () {
            $(this).select2($(this).data());
        });

        $("#branchId").change(function () {
            $("#groupId").select2('val', '');
            branchId = $("#branchId").val();
            getGroups(branchId);
        });

        $("#groupId").change(function () {
            groupId = $("#groupId").val();
            getUsers(groupId);

        });

        function initSelect2(){
            $("[id^=bidderNumber]").each(function () {
                $(this).select2($(this).data());
            });
        }

        function appendAndGetNewSelect(fieldHTML){
            $(".form-group.field_wrapper").append(fieldHTML);
        }


        var bidDetailsRow = '<div class="col-sm-6">' +
        '<label class="control-label" for="bidderNumber0"></label>' +
            '<div class="input-group">' +
                '<select data-placeholder="Select Member" name="memberId" id="bidderNumber0"' +
                        'data-width="auto" data-minimum-results-for-search="5" tabindex="-1"' +
                        'class="select2 form-control" >' +
                '</select>' +
            '</div>' +
        '</div>' +
        '<div class="col-sm-4">' +
            '<label class="control-label" for="bidder0_value"></label>' +
            '<div class="input-group">' +
            '<span class="input-group-addon">₹</span>' +
            '<input name="bidderValue" class="form-control" placeholder="Bid Value"' +
        'type="text" id="bidder0_value">' +
            '</div>' +
            '</div>' +
            '<br><br>' +
            '</div>';

        $(document).on("click","#enterBidValues",function(){
            $("#enterBidValues").prop("disabled",true);
            for (var i=0; i< $("#bidderCount").val(); i++){
                var bidderId = "bidderNumber"+(i+1);
                var re = new RegExp("bidderNumber0", 'g');
                var fieldHTML = document.getElementById("hiddenBidValueForm").innerHTML.replace(re,bidderId);
                //var fieldHTML = bidDetailsRow.replace(re,bidderId);
                appendAndGetNewSelect(fieldHTML);
            }
            initSelect2();
        });


        //var bidderCount=1;
        //$("#addBidderButton").on("click",function(){
        //    var find = 'bidder'+bidderCount;
        //    var nextBidder = 'bidder'+(++bidderCount);
        //    var re = new RegExp(find, 'g');
        //    var dropdownHTML = document.getElementById("bidder1").outerHTML.replace(re,nextBidder);
        //    var fieldHTML = '<div><div class="col-sm-6"><div class="input-group">' + dropdownHTML + '</div></div><div class="col-sm-4"><div class="input-group"><span class="input-group-addon">₹</span><input  name="bidderValue" class="form-control" placeholder="Bid Value" type="text"/></div></div><div class="btn-group col-sm-2 remove_button"> <button type="button" class="btn btn-sm btn-default">-</button></div><br><br></div>';
        //    $(".form-group.field_wrapper").append(fieldHTML);
        //    $(dropdownHTML).select2($(this).data());
        //
        //});

        //$(".form-group.field_wrapper").on('click',".remove_button.btn-group.col-sm-2",function(e){
        //   e.preventDefault();
        //    $(this).parent('div').remove();
        //    bidderCount-- ;
        //});


        $("#calculateAuctionReport").on("click",function(){
           calculateAuctionReport();
        });

        $("#auctionDate").inputmask({mask: "9999-99-99"});

        $('#datePicker').datetimepicker({
            format: 'YYYY-MM-DD HH:MM',
            defaultDate: new Date()
        });

        $('#datePickerNext').datetimepicker({
            format: 'YYYY-MM-DD HH:MM'
        });

        //$("#amount").change(function () {
        //    getAuctionDetails();
        //});

        $("#modify").click(function () {
            $('#auctionDetails .form-control').prop("disabled", false);
        });

        $("#correct").click(function(){
            $('#auctionDetails .form-control').prop("disabled", true);
        });

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

});


function getGroups(branchId) {
    $.ajax({
        type: "Get",
        url: 'GetBranchGroups',
        data: "branchId=" + branchId,
        success: function (data) {
            $("#groupId").empty();
            var result = JSON.parse(data);
            for (var i = 0; i < result.length; i++) {
                if(result[i].groupStatus=="2"){
                    $("#groupId").append('<option  value=' + result[i].groupId + '>' + result[i].groupName + '</option>');
                }
            }
            $('#groupId').trigger("change");
        }
    });
}

function getUsers(groupId) {
    $.ajax({
        type: "Get",
        url: 'GetAuctionMembersByGroupId',
        data: "groupId=" + groupId,
        success: function (data) {
            $("#bidderNumber0").empty();
            var result = JSON.parse(data);
            if(result.length == 1){
                $("#concludingAuctionError").append("Please report concluding auction from the group's page.")
            }
            else{
                for (var i = 0; i < result.length; i++) {
                    console.log(result[i].wonAuction);
                    if(!result[i].wonAuction){
                        $("#bidderNumber0").append('<option  value=' + result[i].memberId + '>' + result[i].fullName + ' - (' + result[i].mobileNo + ')' + '</option>');
                    }
                }
            }
        }
    });
}


function calculateAuctionReport(){
    var numBidders = $("#bidderCount").val();
    var groupId = $("#groupId").val();
    var serviceTax = $("#serviceTax").val();
    var commissionPercentage = $("#commissionPercentage").val();
    var auctionDate = new Date($("#auctionDate").val());
    var bidDetails = {};
    var maxDiscount=0;
    var winningMemberId;

    for (var i=0;i<numBidders;i++){
        if ($("#value_bidderNumber"+(i+1)).val() > maxDiscount){
            maxDiscount = $("#value_bidderNumber"+(i+1)).val();
            winningMemberId = $("#bidderNumber"+(i+1)).val();
            console.log("bid "+maxDiscount)
        }
        bidDetails[$("#bidderNumber"+(i+1)).val()] = $("#value_bidderNumber"+(i+1)).val();


    }
    $("#memberId").val(winningMemberId);

    $("#bidDetails").val(JSON.stringify(bidDetails));
    $.ajax({
        type : "Get",
        url : "calculateAuctionReport",
        data : {kasarBalance:maxDiscount,groupId:groupId,serviceTax: serviceTax,
                commissionPercentage:commissionPercentage},
        success : function(data){
            var result = JSON.parse(data);
            $("#checkRow").show();
            $("#auctionDetails").show();
            $("#dividend").val(result.dividend);
            $("#paymentAmount").val(result.payment);
            $("#commission").val(result.commission);
            $("#commissionAmount").val(result.commission);
            $("#dividend1").val(result.dividend);
            $("#nextMonthPayment").val(result.payment);
            $("#winnerAmount").val(result.finalAmount);
            $("#amount").val(result.finalAmount);
            $("#serviceTaxAmount").val(result.taxAmount);
            $("#taxAmount").val(result.taxAmount);
            $('#submit').prop("disabled", false);
        }
    })
}

function addSuccess() {
    Messenger().post({
        message: 'Auction Reported successfully!',
        type: 'success',
        showCloseButton: true
    });

    return false;
}

function addError() {
    Messenger().post({
        message: 'Auction was not Reported  successful. Please contact Administrator',
        type: 'error',
        showCloseButton: true
    });

    return false;
}