/**
 * Created by sri on 27/10/15.
 */

var branchId;

$(document).ready(function () {
    function pageLoad() {

        $("#groupRow").hide();
        $("#collection-trend").hide();

        //Automatically selects first branch
        $("a[id^='branch'] > button")[0].click()

        $(".getBranchGroups").click(function () {
            branchId = this.id;
            getGroupsList(branchId);
            collectionTrend = getCollectionTrend(branchId);
            initNvd32();
        });

        $(".getBranchGroups").click(function () {
            $('.getBranchGroups').widgster();
        });

        /*$('#branches section').on( 'click', 'p', function () {
         if ($(this).hasClass('bg-success')) {

         }else {
         $(this).removeClass('bg-info');
         $(this).addClass('bg-success');
         }
         });
         */


    $("#groupId").click(function () {
        groupId = $("#groupId").val();
        alert("success");
        getUsers(groupId);
    });




}
    pageLoad();
    SingApp.onPageLoad(pageLoad);
});


function getCollectionTrend(rawBranchId){
    var branchId = rawBranchId.substr(6);
    $.ajax({
        type: "Get",
        url: "getCollectionTrend",
        data: "branchId=" + branchId,
        success: function(data){
            var result = JSON.parse(data)
            initNvd31(result);
        }
    })
}

function getGroupsList(id) {
    var branchId = id.substr(6);
    $.ajax({
        type: "Get",
        url: 'getGroupRowDetails',
        data: "branchId=" + branchId,
        success: function (data) {
            $("#groups").html('');
            $("#groupRow").show();
            $("#collection-trend").show();
            var result = JSON.parse(data);
            for (var i = 0; i < result.length; i++) {
                $("#groups").append(getGroupDetailsRow(result[i]));
            }
        },
        error: function () {
            $("#result").html('There is error while submit');
        }
    });
}

function getGroupDetailsRow(element){
    var result = '<section class="">' +
    '<div class=""> ' +
    ' <form class="" role="form">' +
    '<fieldset>' +
    '<div class="" >' +
    '<label class="col-sm-2" >' +
    '<a href="GroupDetail?GroupId=' + element.groupId + '" >' + element.groupName + ' </a>' +
    '<br>' +
    element.noOfMembers + '-Members' +
    '</label>' +
    '<div class="col-sm-5">' +
    '<div class="progress progress-striped active mt">' +
    '<div class="progress-bar progress-bar-info fw-semi-bold"' +
    'style="width: '+ element.auctionProgress+ '%; height: 20px;">'+ element.currentMonth + '/' + element.noOfMembers +  ' auctions done.' +
    '</div>' +
    '</div>' +
    '</div>' +
    '<div class="stats-row mt">' +
    '<div class="stat-item">' +
    '<h6 class="name">Current Balance</h6>' +
    '<p class="value">'+ element.outstandingAmount +'</p>' +
    '</div>' +
    '<div class="stat-item">' +
    '<h6 class="name">Next Auction</h6>' +
    '<p class="value">'+element.nextAuctionDate+'</p>' +
    '</div>' +
    '</div>' +
    '</div>' +
    '</fieldset>' +
    '</form>' +
    '</div>'

    return result;
}

function getGroupDetails(branchId){
    $.ajax(
        {
            type : "Get",
            url : "GroupDetail",
            data : "branchId=" + branchId,
            success : function(data){
                var result = JSON.parse(data);
                return result[0].amount;
            }
        }
    );
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




function initNvd31(collectionTrend){

    nv.addGraph(function() {
        var chart = nv.models.multiBarChart()
            //.margin({left: 28, bottom: 30, right: 0})
            .color(['#F7653F'])

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

        console.log(collectionTrend);
        d3.select('#nvd31 svg')
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

function initNvd32(){

    nv.addGraph(function() {
        var chart = nv.models.multiBarChart()
            //.margin({left: 28, bottom: 30, right: 0})
            .color(['#28bf22','#F7653F'])
            .showControls(true);

        chart.xAxis
            .showMaxMin(false)
            .axisLabel('Date')
            .ticks(1000)
            .tickFormat(function(d) { return d3.time.format('%b')(new Date(d)) });

        chart.yAxis
            .showMaxMin(false)
            .axisLabel('Rupees')
            .ticks(0)
            .tickFormat(function(d) {return '₹' + d3.format(',f')(d)});

//            chart.controls.margin({left: 0});

        d3.select('#nvd32 svg')
            .style('height', '300px')
            .datum(testData(['On-time payment','Late payment'], 3,30).map(function(el, i){
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