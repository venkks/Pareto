/**
 * Created by sri on 24/11/15.
 */

$(document).ready(function () {

    function pageLoad() {

        $('#addCompanyForm').parsley();
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
        message: 'Company Created Successfully!',
        type: 'success',
        showCloseButton: true
    });

    return false;
}

function addError() {
    Messenger().post({
        message: 'Company was not created successfully. Please contact Administrator',
        type: 'error',
        showCloseButton: true
    });

    return false;
}

function addStaffSuccess() {
    Messenger().post({
        message: 'Staff added successfully!',
        type: 'success',
        showCloseButton: true
    });

    return false;
}

function addStaffError() {
    Messenger().post({
        message: 'Staff was not added successfully. Please contact Administrator',
        type: 'error',
        showCloseButton: true
    });

    return false;
}