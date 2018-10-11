/**
 * Created by sri on 25/11/15.
 */
$(document).ready(function () {

    $("#addBranchForm").parsley();

    function pageLoad() {
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
        message: 'Branch created successfully!',
        type: 'success',
        showCloseButton: true
    });

    return false;
}

function addError() {
    Messenger().post({
        message: 'Branch was not created successful. Please contact Administrator',
        type: 'error',
        showCloseButton: true
    });

    return false;
}