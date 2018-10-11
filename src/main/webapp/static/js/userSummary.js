
$(document).ready(function () {

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

        $('.widget').widgster();

        $('[data-toggle=tooltip]').tooltip();
        initEasyPie();
        initializeClock('clockdiv', deadline);
        if(memberWonAuction=='false'){
            initBidSlider();
        }
    }

    $('#submit-bid-prompt').on('click',function(){
        checkBiddingValue();
    });

    $("#submitBidButton").on("click",function(e){
        e.preventDefault();
        $.ajax({
            type : "POST",
            url : "updateBid",
            data : $("#submitBidForm").serialize(),
            success : function(){
                Messenger().post({
                    message: "Your bid is successfully submitted.",
                    type: 'success',
                    showCloseButton: true
                });
                window.location = "GetUserTransactionWithDetail?memberId=" + memberId
            }

        });

    });

    pageLoad();
    SingApp.onPageLoad(pageLoad);

    $('.profile').initial();
});


function checkBiddingValue(){
    var newBid = $("#slider-bid").val();
    if(newBid < currentBid){
        $("#biddingAmountFormInput").val(newBid);
        $("#modalBidValue").text(newBid);
        $('#bidConfirmModal').modal('show');
    }
    //Add a condition so that new bid is not less than 60% of bid price.
    else{
        Messenger().post({
            message: "Your bid value should be less than ₹ " + currentBid,
            type: 'error',
            showCloseButton: true
        });
    }

}


function initEasyPie(){
    $('#easy-pie1').easyPieChart({
        barColor: '#5dc4bf',
        trackColor: '#ddd',
        scaleColor: false,
        lineWidth: 10,
        size: 120
    });
}


function initBidSlider(){
    var bidSlider = $('#slider-bid').slider({
            id: "sliderbid",
            reversed : true,
            tooltip: 'always',
            ticks: [0, 1000, 2000, 3000, 4000, 5000],
            ticks_labels: ["0","₹ 1000","₹ 2000","₹ 3000","₹ 4000","₹ 5000"],
            ticks_snap_bounds: 30
        }
    );

    bidSlider.one('change',function(){
        $('#submit-bid-prompt').prop("disabled",false);
    });

    bidSlider.on('change',function(){

        var bidValue = bidSlider.slider('getValue');
        var totalValue = bidSlider.slider('getAttribute','max');
        var dividend = totalValue - bidValue;
        $('#submit-bid-prompt').html('Get ₹' + String(bidValue).bold());
        //$('#auction-bid-value').html('You get ₹ '+ String(bidValue).bold() + '. ' +
        //    'Dividend adjusted against next month is ₹ '+ dividend + '/' + noOfMembers + ' = ₹ ' + String(Math.floor(dividend/noOfMembers)).bold());
    });
}

function getTimeRemaining(endtime){
    var t = Date.parse(endtime) - Date.parse(new Date());
    var seconds = Math.floor( (t/1000) % 60 );
    var minutes = Math.floor( (t/1000/60) % 60 );
    var hours = Math.floor( (t/(1000*60*60)) % 24 );
    var days = Math.floor( t/(1000*60*60*24) );
    return {
        'total': t,
        'days': days,
        'hours': hours,
        'minutes': minutes,
        'seconds': seconds
    };
}


function initializeClock(id, endtime){
    var clock = document.getElementById(id);
    var daysSpan = clock.querySelector('.days');
    var hoursSpan = clock.querySelector('.hours');
    var minutesSpan = clock.querySelector('.minutes');
    var secondsSpan = clock.querySelector('.seconds');
    function updateClock(){
        var t = getTimeRemaining(endtime);
        daysSpan.innerHTML = t.days;
        hoursSpan.innerHTML = t.hours;
        minutesSpan.innerHTML = t.minutes;
        secondsSpan.innerHTML = t.seconds;
        if(t.total<=0){
            clearInterval(timeinterval);
        }
    }
    updateClock(); // run function once at first to avoid delay
    var timeinterval = setInterval(updateClock,1000);
}