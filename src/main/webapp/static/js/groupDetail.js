/**
 * Created by dell on 13/11/15.
 */
/**
 * Created by sri on 3/11/15.
 */

var branchId;
var groupId;
$(document).ready(function () {

    function pageLoad() {


        $(".select2:not(#member_auctionNumber0)").each(function () {
            $(this).select2($(this).data());
        });
        $("#numAuctionsHappened").prop("disabled",true);

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
            //getGroupNameFromGroupId(groupId);
            initNvd32(collectionTrend);
            initEasyPie();
        });


        $("#concludingDetailsButton").click(function(){
            var serviceTax = $("#serviceTaxPercentage").val();
            updateConcludingAuctionValues(serviceTax);
            getConcludingAuctionWinner(groupId);
        });

        $("#serviceTaxPercentage").change(function(){
            var serviceTax = $("#serviceTaxPercentage").val();
            updateConcludingAuctionValues(serviceTax);
        });

        $("#concludeRequestButton").click(function(e) {
            e.preventDefault();
            //var $form = $("#concludingAuctionForm");
            $.ajax({
                type : "POST",
                url : "/concludingAuctionReport",
                data : $("#concludingAuctionForm").serialize(),
                success : window.location = "/GroupList"

            });

           });

        //Commence Group modal functions

        function initDatePicker(){
            $(".datepicker").datetimepicker({
                format: 'YYYY-MM-DD HH:MM'
            });
        }



        $("input[type=radio][name=groupStatus]").change(function(){
            if (this.value=="newGroup"){
                $("#numAuctionsHappened").prop("disabled",true);
                $("#numAuctionsHappened").prop("required",false);
            }
            else{
                $("#numAuctionsHappened").prop("disabled",false);
                $("#numAuctionsHappened").prop("required",true);
            }
        });

        $(document).on("click","#generateAuctionDetailsForm",function(){
            $("#generateAuctionDetailsForm").prop("disabled",true);
            for(i=0;i<$("#numAuctionsHappened").val();i++){
                var auctionId = "auctionNumber"+(i+1);
                var re = new RegExp("auctionNumber0", 'g');
                var fieldHTML = document.getElementById("hiddenAuctionDetailsForm").innerHTML.replace(re,auctionId);
                appendAndGetNewSelect(fieldHTML);
                $("label[id="+auctionId+"]").append("Auction "+ (i+1));
            }
            $("#hiddenUpcomingAuctionDate").show();
            initSelect2();
            initDatePicker();

        });

        function initSelect2(){
            $("[id^=member_auctionNumber]").each(function () {
                $(this).select2($(this).data());
            });
        }

        function appendAndGetNewSelect(fieldHTML){
            $(".form-group.field_wrapper").append(fieldHTML);
        }

        $("#commenceGroupSubmit").on("click",function(e){
            e.preventDefault();
            populateAuctionDetails();
            $.ajax({
                type : "POST",
                url : "CommenceGroup",
                data : $("#commenceGroupForm").serialize(),
                success : window.location = "GroupList"

            });

        });

        function populateAuctionDetails(){

            var previousAuctionDetails = {};
            var numAuctionsHappened = $("#numAuctionsHappened").val();
            for(i=0;i<numAuctionsHappened;i++){
                var singleAuctionDetails = {};
                singleAuctionDetails["auctionDate"] = $("#auctionDate_auctionNumber"+(i+1)).val();
                singleAuctionDetails["winningMemberId"] = $("#member_auctionNumber"+(i+1)).val();
                singleAuctionDetails["winningValue"] = $("#value_auctionNumber"+(i+1)).val();
                singleAuctionDetails["dividendPaid"] = $("#dividend_auctionNumber"+(i+1)).val();
                if(i==numAuctionsHappened-1){
                    singleAuctionDetails["upcomingAuctionDate"] = $("#upcomingAuctionDate").val();
                }
                else{
                    singleAuctionDetails["upcomingAuctionDate"] = $("#auctionDate_auctionNumber"+Math.max((i+2),numAuctionsHappened)).val();
                }
                previousAuctionDetails[i]=singleAuctionDetails;
            }
            $("#auctionDetails").val(JSON.stringify(previousAuctionDetails));
        }

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
            }
            $("#groupId").val("");
        }
    });
}


function getGroupNameFromGroupId(groupId){
    $.ajax({
        type : "Get",
        url : "getGroupNameFromGroupId",
        data : "groupId=" + groupId,

        success: function(data){
            document.getElementById("groupName").innerHTML = data;
        }
    })
}

function getStatusButtonColor(groupStatus){
    var buttonType;
    if(groupStatus === "New"){
        buttonType = "label label-primary";
    }
    else if (groupStatus === "Active"){
        buttonType = "label label-success";
    }
    else if (groupStatus === "Concluded"){
        buttonType = "label label-default";
    }
    else if (groupStatus === "Cancelled"){
        buttonType = "label label-danger";
    }

    $("#statusButton").addClass(buttonType);
}


function populateHiddenDropdown(data){
    $("#member_auctionNumber0").empty();
    var result = JSON.parse(data);
        for (var i = 0; i < result.length; i++) {
            console.log(result[i].wonAuction);
            if(!result[i].wonAuction){
                $("#member_auctionNumber0").append('<option  value=' + result[i].memberId + '>' + result[i].fullName + ' - (' + result[i].mobileNo + ')' + '</option>');
            }
        }
}


function getUsers(groupId) {
    $.ajax({
        type: "Get",
        url: 'GetMembersByGroupId',
        data: "groupId=" + groupId,

        success: function (data) {

            populateHiddenDropdown(data);
            renderHTML(data);
        }
    });
}
    function renderHTML(data) {
        var result =JSON.parse(data);

        var renderTable="";
        renderTable="<table id='datatable-table' class='table table-striped table-hover'><thead><tr><th>Member Name</th><th>Contact</th><th>₹ Rs.</th><th>Address</th><th>State</th><th>Country</th></tr></thead><tbody>";
        document.getElementById("tableData").innerHTML=renderTable;

        for(var i=0;i<result.length;i++)
        {
            var amount = result[i].totalAmount;
            amountClr = "green";
            if(amount.charAt(0) == "-"){
                amount = "("+amount+")";
                amountClr = "red";
            }
            if(result[i].deleted==1){
                renderTable+="<tr><td><a href='GetUserTransactionWithDetail?memberId="+result[i].memberId+"'>" + result[i].fullName + " (Switched)</a></td><td>" + result[i].mobileNo +"</td><td class='text-right' style='padding-right: 60px;color: "+ amountClr +" '> " + amount +"</td><td>" + result[i].street + "</td><td>" + result[i].state+"</td><td>" + result[i].country +"</td></tr>";
            }
            else{
                renderTable+="<tr><td><a href='GetUserTransactionWithDetail?memberId="+result[i].memberId+"'>" + result[i].fullName + "</a></td><td>" + result[i].mobileNo +"</td><td class='text-right' style='padding-right: 60px;color: "+ amountClr +" '> " + amount +"</td><td>" + result[i].street + "</td><td>" + result[i].state+"</td><td>" + result[i].country +"</td></tr>";
            }
        }
        document.getElementById("tableData").innerHTML=renderTable;
        document.getElementById("tableData").innerHTML+="</tbody></table>";

        $(function(){
            function pageLoad(){
                $('.widget').widgster();
            }

            pageLoad();
            SingApp.onPageLoad(pageLoad);
        });
    }




function testData(stream_names, pointsCount, daysPerPoint) {
    var now = new Date().getTime(),
        day = 1000 * 60 * 60 * 24, //milliseconds
        daysAgoCount = 30,
        daysAgo = daysAgoCount * day,
        daysAgoDate = now - daysAgo,
        pointsCount = pointsCount || 45; //less for better performance
    //daysPerPoint = daysAgoCount / pointsCount;
    return _stream_layers(stream_names.length, pointsCount, .1).map(function(data, i) {
        return {
            key: stream_names[i],
            values: data.map(function(d,j){
                return {
                    x: daysAgoDate + d.x * day * daysPerPoint,
                    y: Math.floor(d.y * 10000) //just a coefficient,
                }
            })
        };
    });
}

function _stream_layers(n, m, o) {
    if (arguments.length < 3) o = 0;
    function bump(a) {
        var x = 1 / (.1 + Math.random()),
            y = 2 * Math.random() - .5,
            z = 10 / (.1 + Math.random());
        for (var i = 0; i < m; i++) {
            var w = (i / m - y) * z;
            a[i] += x * Math.exp(-w * w);
        }
    }
    return d3.range(n).map(function() {
        var a = [], i;
        for (i = 0; i < m; i++) a[i] = o + o * Math.random();
        for (i = 0; i < 5; i++) bump(a);
        return a.map(function(d, i) {
            return {x: i, y: Math.max(0, d)};
        });
    });
}



function initNvd32(collectionTrend){

    $("#groupStats").show();

    nv.addGraph(function() {
        var chart = nv.models.multiBarChart()
            //.margin({left: 28, bottom: 30, right: 0})
            .color(['#F7653F']);

        chart.xAxis
            .showMaxMin(false)
            .axisLabel('Date')
            .ticks(1000)
            .tickFormat(function(d) { return d3.time.format('%b %d')(new Date(d)) });

        chart.yAxis
            .showMaxMin(false)
            .axisLabel('Rupees')
            .ticks(0)
            .tickFormat(function(d) {return '₹' + d3.format(',f')(d)});

//            chart.controls.margin({left: 0});

        //console.log(collectionTrend);
        d3.select('#nvd32 svg')
            .style('height', '300px')
            //.datum(collectionTrend.map(function(el, i){
            .datum(testData(['Collection'],30,1).map(function(el, i){
                el.area = true;
                return el;
            }))
            .transition().duration(500)
            .call(chart)
        ;


        SingApp.onResize(chart.update);

        return chart;
    });
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


function updateConcludingAuctionValues(serviceTax){
    //var amountCollected = document.getElementById("concludingAmountCollected").innerHTML;
    var amountCollected = $("#chitValue").val();
    var commission = amountCollected * 0.05;
    var serviceTaxAmount = commission * serviceTax / 100;
    var prizeMoney = amountCollected - (commission + serviceTaxAmount);
    console.log(commission+","+serviceTaxAmount+","+prizeMoney);
    document.getElementById("concludingCommission").value = commission.toFixed(2);
    document.getElementById("concludingPrizeMoney").value = prizeMoney.toFixed(2);
    document.getElementById("concludingServiceTax").value = serviceTaxAmount.toFixed(2);
}


function getConcludingAuctionWinner(groupId) {
    $.ajax({
        type: "Get",
        url: 'GetAuctionMembersByGroupId',
        data: "groupId=" + groupId,
        success: function (data) {
            $("#memberId").empty();
            var result = JSON.parse(data);
            if(result.length == 1){
                document.getElementById("concludingWinner").innerHTML = result[0].fullName;
                document.getElementById("memberId").value = result[0].memberId;
            }
            else{

            }
        }
    });
}