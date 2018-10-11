/**
 * Created by sri on 29/10/15.
 */

$(document).ready(function () {

    function pageLoad() {

        $('#addGroupForm').parsley();

        $(".select2").each(function () {
            $(this).select2($(this).data());
        });

        $('#datePicker').datetimepicker({
            format: 'YYYY-MM-DD'
        });

        $("#auctionDate").inputmask({mask: "9999-99-99"});

        $('#secondDatePicker').datetimepicker({
            format: 'YYYY-MM-DD'
        });

        $("#secondAuctionDate").inputmask({mask: "9999-99-99"});

        $("#other").prop('checked', function () {
            $("#otherFq").removeAttr("disable");
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

function addSuccess() {
    Messenger().post({
        message: 'Group added successfully!',
        type: 'success',
        showCloseButton: true
    });

    return false;
}

function addError() {
    Messenger().post({
        message: 'Group was not added successful. Please contact Administrator',
        type: 'error',
        showCloseButton: true
    });

    return false;
}