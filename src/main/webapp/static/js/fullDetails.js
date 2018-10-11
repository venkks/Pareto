/**
 * Created by sri on 30/11/15.
 */

$(document).ready(function () {

    function pageLoad() {

        $("#updateRow").hide();
        $(".error").hide();



        $("#editBtn").click(function () {
            $("editRow").hide();
            $(this).hide();
            $("#updateRow").show();
            $(".error").show();
            $('#fullDetailsForm .form-control').prop("disabled", false);
        });

        $("#updateCancel").click(function(){
            $("editRow").show();
            $("#updateRow").hide();
            $("#editBtn").show();
            $(".error").hide();
            $('#fullDetailsForm .form-control').prop("disabled", true);
            /*location.reload();*/
        });

        $("#fullDetailsForm").parsley();

    }

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

    pageLoad();
    SingApp.onPageLoad(pageLoad);
});

function addSuccess() {
    Messenger().post({
        message: 'Changes saved successfully!',
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