<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>Pareto</title>
    <link href="<%=request.getContextPath()%>/static/css/application.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <script>
        /* yeah we need this empty stylesheet here. It's cool chrome & chromium fix
         chrome fix https://code.google.com/p/chromium/issues/detail?id=167083
         https://code.google.com/p/chromium/issues/detail?id=332189
         */
    </script>
</head>
<body>

<%--Including jsp file for sidebar--%>
<%@include file="sidebar.jsp"%>


<div class="content-wrap">
    <main id="content" class="content" role="main">

        <div class="row">
            <h1 class="page-title fw-semi-bold">${groupName}
                &nbsp;
            <span class="label label-success" style="background-image:linear-gradient(#21CE99,#00ABB4)">
                Active
            </span>
            </h1>
        </div>


        <div class="row">
            <div class="col-sm-6">
                <section class="widget">
                    <!-- .widget>header is generally a place for widget title and widget controls. see .widget in _base.scss -->
                    <div class="widget-body">
                        <div class="row">
                            <div class="col-xs-6 text-center">
                                <h4 class="fw-semi-bold">Savings
                                    <i class="fa fa-question-circle" data-toggle="tooltip"
                                       data-placement="bottom" style="cursor: pointer"
                                       title=""
                                       data-original-title="This is the total amount you have contributed towards the group.">
                                    </i>
                                </h4>
                            </div>
                            <div class="col-xs-6 text-center">
                                <h4 class="fw-semi-bold">Dividend
                                    <i class="fa fa-question-circle" data-toggle="tooltip"
                                       data-placement="bottom" style="cursor: pointer"
                                       title=""
                                       data-original-title="Earnings on top of what you have contributed.">
                                    </i></h4>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-6 text-center">
                                <h3><b>₹ ${amountInvested}</b></h3>
                            </div>
                            <div class="col-xs-6 text-center">
                                <h3><b>₹ ${dividendEarned}</b></h3>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
            <div class="col-sm-6">
                <section class="widget">
                    <!-- .widget>header is generally a place for widget title and widget controls. see .widget in _base.scss -->
                    <div class="widget-body">
                        <div class="row">
                            <div class="col-xs-4 text-center">
                                <%--TODO : Make the text bigger.--%>
                                <h4 class="fw-semi-bold">Subscription</h4>
                            </div>
                            <div class="col-xs-4 text-center">
                                <h4 class="fw-semi-bold">Members</h4>
                            </div>
                            <div class="col-xs-4 text-center">
                                <h4 class="fw-semi-bold">Group Value</h4>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-4 text-center">
                                <%--TODO : Make the text bigger.--%>
                                <h3><b>₹ ${subscription}</b></h3>
                            </div>
                            <div class="col-xs-4 text-center">
                                <h3><b>${noOfMembers}</b></h3>
                            </div>
                            <div class="col-xs-4 text-center">
                                <h3><b>₹ ${groupValueCurrency}</b></h3>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </div>


        <div class="widget" id="group-members">
            <div class="center-block">
                <h4 class="fw-semi-bold">Members</h4>
            </div>
            <div class="row">
                <c:forEach items="${userList}" var="member">
                    <div class="col-sm-1 col-xs-6" style="text-align: center;">
                                <span class="thumb-sm">
                                    <img class="img-circle profile" data-name="${member.fullName}" alt="...">
                                </span>
                        <h5>${member.fullName}
                        </h5>
                    </div>
                </c:forEach>
            </div>
        </div>

            <div class="widget">
                <div class="row">
                    <div class="col-sm-3">
                        <h4 class="event-heading">Week ${currentMonth}</h4>
                    </div>
                    <div class="col-sm-9">
                        <section class="event">

                            <br>
                            <c:choose>
                                <c:when test="${status=='Paid advance' || status=='Paid'}">
                                    <p id="paid-message" class="fw-semi-bold" style="color:green">
                                        <img src="<%=request.getContextPath()%>/static/img/icons-collection/png/money.png"
                                             width="32px" height="32px"/>
                                        Paid
                                    </p>
                                    <img src="<%=request.getContextPath()%>/static/img/icons-collection/png/calendar.png"
                                         width="32px" height="32px"/>
                                    <span class="fw-semi-bold">  Next auction</span> : <span id="next-auction"></span>
                                    <br>
                                    <hr>



                                                    <c:choose>
                                                        <c:when test="${memberWonAuction == 'false'}">
                                                            <%--Commenting out bidder initially.--%>
                                                            <div class="auction-bidder">
                                                                    <%--<header>Use the slider to bid for auction.</header>--%>
                                                                    <%--<img src="<%=request.getContextPath()%>/static/img/icons-collection/png/justice.png"
                                                                         width="32px" height="32px"/> Auction
                                                                    <br>--%>
                                                            <div class="row">
                                                                <div class="col-sm-2 col-xs-3">
                                                                    <input class="js-slider" id="slider-bid"
                                                                           type="text" data-slider-orientation="vertical"
                                                                           data-slider-min="0" data-slider-max="${groupValue}"
                                                                           data-slider-step="50" data-slider-value="${currentBidUser.currentBid}"
                                                                        <%--data-slider-ticks = "[0,1000,2000,3000,4000,5000]"--%>
                                                                        <%--data-slider-ticks-labels='["0","₹ 1000","₹ 2000","₹ 3000","₹ 4000","₹ 5000"]'--%>
                                                                        <%--data-slider-ticks-snap-bounds="100"--%>
                                                                        <%--data-slider-slider-horizontal-width="110px"--%>
                                                                    />
                                                                </div>
                                                            <div class="col-sm-10 col-xs-9">
                                                                <h4><b>Bid Summary</b></h4>
                                                                <br>
                                                                <c:choose>
                                                                    <c:when test="${currentBidUser.currentBid==groupValue}">
                                                                        No one has bid for the auction yet. <span style="color:green">
                                                                Bid an amount if you want money.</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <c:choose>
                                                                            <c:when test="${currentBidUser.memberId==memberId}">
                                                                    <span style="color:green">
                                                                        Your bid of ₹ <span id="currentBid">${currentBidUser.currentBid}</span> is lowest and winning.
                                                                    </span>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                ${currentBidUser.fullName} wants the pool for ₹ <span id="currentBid">${currentBidUser.currentBid}</span>.
                                                                                <div style="color:green" class="small fw-semi-bold">
                                                                                    Bid a lower amount if you want money.</div>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                                <br>
                                                                <p id="auction-bid-value"></p>
                                                                <button role='button'
                                                                        style="background-image:linear-gradient(#21CE99,#02926C)"
                                                                        disabled="disabled" class='btn btn-success' id='submit-bid-prompt'>Use slider to place bid</button>
                                                            </div>
                                                        </div>
                                                        </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="auction-bidder">
                                                                ABC
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>



                                </c:when>

                                <c:otherwise>
                                    <p id="not-paid-message">
                                    <i class = "fa fa-money" style="color:red;"></i> <span class="fw-semi-bold">${status}</span>
                                        Please pay ₹ ${currentBalance} by <span id="next-auction-duedate"></span>.
                                    <button style="color:teal;background:none!important;border:none; padding:0!important;font: inherit;border-bottom:1px solid #444; cursor: pointer;"
                                    data-toggle="modal" data-target="#myModal">
                                    How to pay?
                                    </button>
                                    </p>
                                </c:otherwise>
                            </c:choose>
                            <br>
                            <div id="clockdiv" style="color:maroon">
                                Auction ends in <span class="days fw-semi-bold"></span> Days,
                                <span class="hours fw-semi-bold"></span> Hours
                                <span class="minutes fw-semi-bold"></span> Minutes,
                                <span class="seconds fw-semi-bold"></span> Seconds.
                            </div>
                            <br><br>
                        </section>
                    </div>

                </div>



            </div>

        <c:forEach items="${auctionHistoryList}" var="auctionCycle">

            <div class="widget">
                <div class="row">
                    <div class="col-sm-3">
                        <h4 class="event-heading">Week ${auctionCycle.auctionNumber}</h4>
                    </div>
                    <br>
                    <div class="col-sm-9">
                        <section class="event">
                            <p>
                                <img src="<%=request.getContextPath()%>/static/img/icons-collection/png/wallet.png"
                                width="20px" height="20px"/> &nbsp;
                                <span class="fw-semi-bold">${auctionCycle.auctionWinner}</span> won ₹ ${auctionCycle.auctionWinningAmount}.
                            </p>
                            <p>
                                <img src="<%=request.getContextPath()%>/static/img/icons-collection/png/money.png"
                                     width="20px" height="20px"/> &nbsp;
                                You paid ₹ ${auctionCycle.cyclePayment}.
                            </p>
                            <p>
                                <img src="<%=request.getContextPath()%>/static/img/icons-collection/png/piggy-bank.png"
                                     width="20px" height="20px"/> &nbsp;
                                Dividend was ₹ ${auctionCycle.dividend}.
                            </p>
                        </section>
                    </div>
                </div>

            </div>

        </c:forEach>

        <!-- Modal -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">Account Details</h4>
                    </div>
                    <div class="modal-body">
                        Hey, we are working to integrate online payments on Pareto. At the moment, please use Paytm or NEFT
                         to transfer money.
                        <ol>
                            <li>
                                <img src="<%=request.getContextPath()%>/static/img/Paytm-Logo.png" width="64px" height="32 px"/>
                                 transfer to <span class="fw-semi-bold">9833898077</span>.
                            </li>

                            <li>
                                Please add the following account as beneficiary.
                                <br><br>
                                <span class="fw-semi-bold">Account Name</span> : Priya Surya<br>
                                <span class="fw-semi-bold">Account No.</span> : 002001078836<br>
                                <span class="fw-semi-bold">IFSC Code</span> : ICIC0000020<br>
                            </li>
                        </ol>
                        <br>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>

            </div>
        </div>

        <!-- Bid Confirm Modal -->
        <div class="modal fade" id="bidConfirmModal" tabindex="-1" role="dialog" aria-labelledby="bidConfirmModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="bidConfirmModalLabel">Are you sure?</h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal" role="form" action="<%=request.getContextPath()%>/updateBid"
                              method="post" id="submitBidForm">
                            <fieldset>

                                <input type="hidden" name="groupId" value="${groupId}"/>
                                <input type="hidden" name="memberId" value="${memberId}"/>
                                <input type="hidden" name="bidCycle" value="${currentMonth}"/>
                                <input type="hidden" name="biddingAmount" id="biddingAmountFormInput"/>
                                <input type="hidden" name="${_csrf.parameterName}"
                                       value="${_csrf.token}" />


                            </fieldset>
                            <div class="row">
                                <div class="col-sm-offset-4 col-sm-7">
                                    <button type="button" id ="submitBidButton" class="btn btn-primary">Yes, Submit my bid for ₹ <span id="modalBidValue"></span>.</button>
                                    <%--<button type="" class="btn btn-inverse">No.</button>--%>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

            </div>
        </div>



        </main>
        </div>
<!-- The Loader. Is shown when pjax happens -->
<div class="loader-wrap hiding hide">
    <i class="fa fa-circle-o-notch fa-spin-fast"></i>
</div>


<!-- common libraries. required for every page-->

<!-- common libraries. required for every page-->
<script src="<%=request.getContextPath()%>/static/vendor/jquery/dist/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/jquery-pjax/jquery.pjax.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/bootstrap-sass/assets/javascripts/bootstrap/transition.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/bootstrap-sass/assets/javascripts/bootstrap/collapse.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/bootstrap-sass/assets/javascripts/bootstrap/dropdown.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/bootstrap-sass/assets/javascripts/bootstrap/button.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/bootstrap-sass/assets/javascripts/bootstrap/tooltip.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/bootstrap-sass/assets/javascripts/bootstrap/alert.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/slimScroll/jquery.slimscroll.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/widgster/widgster.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/pace.js/pace.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/jquery-touchswipe/jquery.touchSwipe.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/bootstrap-sass/assets/javascripts/bootstrap/modal.js"></script>


<!-- common app js -->
<script src="<%=request.getContextPath()%>/static/js/settings.js"></script>
<script src="<%=request.getContextPath()%>/static/js/app.js"></script>

<!-- page specific libs -->
<%--<script src="<%=request.getContextPath()%>/static/vendor/moment/min/moment.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/eonasdan-bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/select2/select2.min.js"></script>--%>
<script src="<%=request.getContextPath()%>/static/vendor/underscore/underscore-min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/backbone/backbone.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/backbone.paginator/lib/backbone.paginator.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/backgrid/lib/backgrid.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/backgrid-paginator/backgrid-paginator.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/datatables/media/js/jquery.dataTables.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/bootstrap-select/dist/js/bootstrap-select.min.js"></script>
<%--page specfic for datatables--%>

<script src="<%=request.getContextPath()%>/static/vendor/messenger/build/js/messenger.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/messenger/build/js/messenger-theme-flat.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/messenger/docs/welcome/javascripts/location-sel.js"></script>
<script src="<%=request.getContextPath()%>/static/js/group-table.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/d3/d3.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/nvd3/build/nv.d3.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/jquery.easy-pie-chart/dist/jquery.easypiechart.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/seiyria-bootstrap-slider/dist/bootstrap-slider.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/moment/moment.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/initial.js-master/dist/initial.min.js"></script>

<script src="<%=request.getContextPath()%>/static/js/userSummary.js"></script>
<script>
    var currentBid = "${currentBidUser.currentBid}";
    var noOfMembers = "${noOfMembers}";
    var dividendEarned = "${dividendEarned}";
    var memberWonAuction = "${memberWonAuction}";

    var deadline = "${nextAuction}";
    var memberId = "${memberId}";
    initializeClock('clockdiv', deadline);

    var formattedDate = moment("${nextAuction}").format("Do MMMM YY");
    $("#next-auction").text(formattedDate);
    $("#next-auction-duedate").text(formattedDate);
</script>


</body>
</html>
