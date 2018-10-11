//bootstrap application wizard demo functions


$(function(){
    function pageLoad(){
        $('.widget').widgster();
        //$("#destination").inputmask({mask: "99999"});
        //$("#credit").inputmask({mask: "9999-9999-9999-9999"});
        //$("#expiration-date").datetimepicker({
        //    pickTime: false
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

        $(".select2").each(function () {
            $(this).select2($(this).data());
        });

        $("#branchId").change(function () {
            $("#groupId").select2('val', '');
            $("#memberId").select2('val', '');
            branchId = $("#branchId").val();
            getGroups(branchId);

        });

        $("#groupId").change(function () {
            $("#memberId").select2('val', '');
            groupId = $("#groupId").val();
            getUsers(groupId);
        });

        $("#memberId").change(function(){
            memberId = $("#memberId").val();
            $("#incomingMemberDetails").attr("hidden",false);
            document.getElementById("summaryOutgoingMemberName").innerHTML = $("#memberId option:selected").text();
            document.getElementById("summaryIncomingMemberName").innerHTML = $("#incomingUserName").val();
            getOutgoingMemberDetails(memberId);
        });

        $("#findUser").on('click',function() {
            var userName = $("#incomingUserName").val();
            var userPhone = $("#incomingUserPhone").val();
            findUser(userName,userPhone);
            populateForm(userName,userPhone);
            });

        //$("#switchMembersFinish").on('click', function(){
        //    var incomingUserName = $("#incomingUserName").val();
        //    var incomingUserPhone = $("#incomingUserPhone").val();
        //    var groupId = $("#groupId").val();
        //    var outgoingMemberId = $("#memberId").val();
        //
        //
        //    $.ajax({
        //       method:'post',
        //       url:'random',
        //       data: {'incomingUserName':incomingUserName,'incomingUserPhone':incomingUserPhone,
        //                'groupId':groupId,'outgoingMemberId':outgoingMemberId}
        //   })
        //});

        $('#wizard').bootstrapWizard({
                onTabShow: function($activeTab, $navigation, index) {
                    var $total = $navigation.find('li').length;
                    var $current = index + 1;
                    var $percent = ($current/$total) * 100;
                    var $wizard = $("#wizard");
                    $wizard.find('.progress-bar').css({width: $percent + '%'});

                    if($current >= $total) {
                        $wizard.find('.pager .next').hide();
                        $wizard.find('.pager .finish').show();
                        $wizard.find('.pager .finish').removeClass('disabled');
                    } else {
                        $wizard.find('.pager .next').show();
                        $wizard.find('.pager .finish').hide();
                    }

                    //setting done class
                    $navigation.find('li').removeClass('done');
                    $activeTab.prevAll().addClass('done');
                },

                // validate on tab change
                onNext: function($activeTab, $navigation, nextIndex){
                    var $activeTabPane = $($activeTab.find('a[data-toggle=tab]').attr('href')),
                        $form = $activeTabPane.find('form');

                    // validate form in case there is form
                    if ($form.length){
                        return $form.parsley().validate();
                    }
                },
                //diable tab clicking
                onTabClick: function($activeTab, $navigation, currentIndex, clickedIndex){
                    return $navigation.find('li:eq(' + clickedIndex + ')').is('.done');
                }
            })
            //setting fixed height so wizard won't jump
            .find('.tab-pane').css({height: 444});

        //clear previous wizard if exists
        //causes conflicts when loaded via pjax
        $('.modal.wizard').remove();
        $('.chzn-select').select2();
        var wizard = $('#satellite-wizard').wizard({
            keyboard : false,
            contentHeight : 400,
            contentWidth : 700,
            backdrop: 'static'
        });

        $('#fqdn').on('input', function() {
            if ($(this).val().length != 0) {
                $('#ip').val('').attr('disabled', 'disabled');
                $('#fqdn, #ip').parents('.form-group').removeClass('has-error has-success');
            } else {
                $('#ip').val('').removeAttr('disabled');
            }
        });

        var pattern = /\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b/;
        x = 46;

        $('#ip').on('input', function() {
            if ($(this).val().length != 0) {
                $('#fqdn').val('').attr('disabled', 'disabled');
            } else {
                $('#fqdn').val('').removeAttr('disabled');
            }
        }).keypress(function(e) {
            if (e.which != 8 && e.which != 0 && e.which != x && (e.which < 48 || e.which > 57)) {
                console.log(e.which);
                return false;
            }
        }).keyup(function() {
            var $this = $(this);
            if (!pattern.test($this.val())) {
                //$('#validate_ip').text('Not Valid IP');
                console.log('Not Valid IP');
                $this.parents('.form-group').removeClass('has-error has-success').addClass('has-error');
                while ($this.val().indexOf("..") !== -1) {
                    $this.val($this.val().replace('..', '.'));
                }
                x = 46;
            } else {
                x = 0;
                var lastChar = $this.val().substr($this.val().length - 1);
                if (lastChar == '.') {
                    $this.val($this.val().slice(0, -1));
                }
                var ip = $this.val().split('.');
                if (ip.length == 4) {
                    //$('#validate_ip').text('Valid IP');
                    console.log('Valid IP');
                    $this.parents('.form-group').removeClass('has-error').addClass('has-success');
                }
            }
        });

        wizard.on('closed', function() {
            wizard.reset();
        });

        wizard.on("reset", function() {
            wizard.modal.find(':input').val('').removeAttr('disabled');
            wizard.modal.find('.form-group').removeClass('has-error').removeClass('has-succes');
            wizard.modal.find('#fqdn').data('is-valid', 0).data('lookup', 0);
        });

        wizard.on("submit", function(wizard) {
            var submit = {
                "hostname": $("#new-server-fqdn").val()
            };

            this.log('seralize()');
            this.log(this.serialize());
            this.log('serializeArray()');
            this.log(this.serializeArray());

            setTimeout(function() {
                wizard.trigger("success");
                wizard.hideButtons();
                wizard._submitting = false;
                wizard.showSubmitCard("success");
                wizard.updateProgressBar(0);
            }, 2000);
        });

        wizard.el.find(".wizard-success .im-done").click(function() {
            wizard.hide();
            setTimeout(function() {
                wizard.reset();
            }, 250);

        });

        wizard.el.find(".wizard-success .create-another-server").click(function() {
            wizard.reset();
        });

        wizard.el.find('.wizard-progress-container .progress').removeClass('progress-striped')
            .addClass('progress-xs');

        $(".wizard-group-list").click(function() {
            alert("Disabled for demo.");
        });

        $('#open-wizard').click(function(e) {
            e.preventDefault();
            wizard.show();
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
            for (var i = 0; i < result.length; i++) {
                $("#memberId").append('<option  value=' + result[i].memberId + '>' + result[i].fullName + ' - (' + result[i].mobileNo + ')' + '</option>');
                $('#memberId').select2();
                    //.select2('val', $("#memberId option:first").val());
            }
        }
    });
}

function findUser(userName,userPhone){
    $.ajax({
        type: "Get",
        url: "GetUserDetails",
        data: "userName=" + userName + "&userPhone=" + userPhone,
        success: function(data){
            var result = JSON.parse(data)[0];
            if(result['userExists']==true){
                userFindSuccess();
            }
            else{
                userFindError();
            }
        }
    })
}

function userFindSuccess() {
    Messenger().post({
        message: 'User was successfully verified.',
        type: 'success',
        showCloseButton: true
    });

    return false;
}

function userFindError() {
    Messenger().post({
        message: 'Sorry, User was not found. Please try again!',
        type: 'error',
        showCloseButton: true
    });

    return false;
}


function getOutgoingMemberDetails(memberId){
    $.ajax({
        type: "Get",
        url: "getOutgoingMemberDetails",
        data: "memberId=" + memberId,
        success: function(data){
            var result = JSON.parse(data)[0];
            document.getElementById("installmentsPaid").innerHTML = result['amountInvested'];
            document.getElementById("dividendEarned").innerHTML = result['dividendEarned'];
            document.getElementById("summaryIncomingMembershipAmout").innerHTML = result['amountInvested'];
            document.getElementById("summaryOutgoingRefundAmount").innerHTML = result['amountInvested'];
        }
    })
}


function populateForm(incomingUserName,incomingUserPhone){
    var groupId = $("#groupId").val();
    var outgoingMemberId = $("#memberId").val();
    $("#incomingUserNameForm").val(incomingUserName);
    $("#incomingUserPhoneForm").val(incomingUserPhone);
    $("#outgoingMemberIdForm").val(outgoingMemberId);
    $("#groupIdForm").val(groupId);

}