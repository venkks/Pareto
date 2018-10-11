<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
    <!-- main page content. the place to put widgets in. usually consists of .row > .col-md-* > .widget.  -->
    <main id="content" class="content" role="main">
        <h1 class="page-title"><span class="fw-semi-bold" id="groupName">${groupDetail.groupName}</span>
            &nbsp;
            &nbsp;
                <span id="statusButton">
                    <span> ${groupDetail.groupStatus} </span>
                </span>
        </h1>

        <div class="row">
            <div class="col-md-12">

                <%--<% if (request.getParameter("GroupId") == null) { %>--%>

                <%--<section class="widget">--%>
                <%--<fieldset>--%>

                <%--<div class="form-group">--%>
                <%--<label class="col-sm-3 control-label" for="branchId">Branches</label>--%>

                <%--<div class="col-sm-4">--%>
                <%--<select id="branchId" data-placeholder="Select Branch"--%>
                <%--class="select2 form-control" tabindex="-1" name="branchId"--%>
                <%--data-minimum-results-for-search="5">--%>
                <%--<option value=""></option>--%>
                <%--<c:forEach items="${branchList}" var="branchList">--%>
                <%--<option value="${branchList.branchId}">${branchList.branchName} </option>--%>
                <%--</c:forEach>--%>
                <%--</select>--%>
                <%--</div>--%>
                <%--</div>--%>
                <%--<div class="form-group">&nbsp;</div>--%>
                <%--<div class="form-group">--%>
                <%--<label class="col-sm-3 control-label" for="groupId">Groups</label>--%>

                <%--<div class="col-sm-4">--%>
                <%--<select data-placeholder="Select Group" id="groupId"--%>
                <%--data-width="auto" data-minimum-results-for-search="5" tabindex="-1"--%>
                <%--class="select2 form-control">--%>
                <%--<option value=""></option>--%>
                <%--</select>--%>
                <%--</div>--%>
                <%--</div>--%>
                <%--</fieldset>--%>
                <%--</section>--%>
                <%--<%}%>--%>


                <c:set var="groupStatus" value="${groupDetail.groupStatus}"></c:set>
                <c:set var="percentMembersAdded" value="${groupDetail.percentMembersAdded}"></c:set>
                <c:set var="noOfMembers" value="${groupDetail.noOfMembers}"></c:set>
                <c:set var="currentMonth" value="${groupDetail.currentMonth}"></c:set>
                <c:set var="outstandingAmount" value="${groupDetail.outstandingAmount}"></c:set>
                <c:choose>
                    <c:when test = "${ groupStatus == 'New'}">
                        <div class="row" id="groupStats">
                            <div class="col-md-6 col-sm-6">
                                <section class="widget">
                                    <header>
                                        <h4>
                                            Member Count
                                        </h4>
                                    </header>
                                    <div class="widget-body clearfix">
                                        <h4>${groupDetail.currentMembers}/${groupDetail.noOfMembers}</h4>
                                        <div class="progress progress-xs">
                                            <div class="progress-bar progress-bar-success" style="width: ${groupDetail.percentMembersAdded}%;"></div>
                                        </div>
                                        <p class="fs-mini text-muted">
                                            are added to the Group. Please add all the members.
                                        </p>
                                        <c:choose>
                                            <c:when test="${percentMembersAdded == 100}">
                                                <%--<form method="post" action="<%=request.getContextPath()%>/CommenceGroup">--%>
                                                    <%--<input type="hidden" name="${_csrf.parameterName}"--%>
                                                           <%--value="${_csrf.token}" />--%>
                                                    <%--<input type="hidden" name="groupId" value="${groupDetail.groupId}" />--%>
                                                    <%--<button type="submit" class="btn btn-success">Commence Group</button>--%>
                                                <%--</form>--%>

                                                <button class="btn btn-success" data-toggle="modal" data-target="#commenceModal">
                                                    Commence Group
                                                </button>
                                                <%--Modal--%>
                                                <div class="modal fade" id="commenceModal" tabindex="-1"
                                                     role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                                    <div class="modal-dialog modal-lg">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                                <h4 class="modal-title" id="myModalLabel"><strong>Commence Group</strong></h4>
                                                            </div>
                                                            <div class="modal-body">
                                                                <form class="form-horizontal" role="form" action="<%=request.getContextPath()%>/CommenceGroup"
                                                                      method="post" id="commenceGroupForm">
                                                                <fieldset>
                                                                <div class="form-group">
                                                                    <label class="col-sm-4 control-label">Group Stage</label>
                                                                    <div class="input-group">
                                                                        <div class="radio">
                                                                            <input type="radio" id="newGroup" name="groupStatus" value="newGroup" checked="">
                                                                            <label for="newGroup">
                                                                                New Group
                                                                            </label>
                                                                        </div>
                                                                        <div class="radio">
                                                                            <input type="radio" id="existingGroup" name="groupStatus" value="existingGroup">
                                                                            <label for="existingGroup">
                                                                                Existing Group
                                                                            </label>

                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <br>
                                                                <br>
                                                                <div class="form-group">
                                                                    <label class="col-sm-4 control-label">
                                                                        Number of Auctions
                                                                    </label>
                                                                    <div class="col-sm-4">
                                                                        <div class="input-group">
                                                                            <input class="form-control" id="numAuctionsHappened" name="numAuctionsHappened" type="text">
                                                                        </div>
                                                                    </div>

                                                                    <button class="btn btn-primary btn-sm" id="generateAuctionDetailsForm" type="button">Enter Auction Details</button>
                                                                </div>
                                                                <div class="form-group field_wrapper">
                                                                    <legend>Auction Details</legend>
                                                                    <%--Code to enter auction details. Auction Date, Winner, Amount--%>
                                                                    <div hidden="hidden">
                                                                        <div id="hiddenAuctionDetailsForm">
                                                                            <label class="control-label col-sm-2" id="auctionNumber0"></label>
                                                                            <div class="col-sm-3">
                                                                                <div class="input-group datepicker">
                                                                                    <input id="auctionDate_auctionNumber0"
                                                                                           placeholder="YYYY-MM-DD HH:SS" type="text" class="form-control">
                                                                                    <span class="input-group-btn"><a href="#" class="btn btn-success"><span
                                                                                            class="glyphicon-calendar glyphicon"></span></a></span>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-sm-3">
                                                                                    <select data-placeholder="Select Member" id="member_auctionNumber0"
                                                                                            data-width="auto" data-minimum-results-for-search="5" tabindex="-1"
                                                                                            class="select2 form-control" >
                                                                                        <option value="">
                                                                                        </option>
                                                                                    </select>
                                                                            </div>
                                                                                <%--<label class="control-label" for="value_bidderNumber0"></label>--%>
                                                                            <div class="col-sm-2">
                                                                                <div class="input-group">
                                                                                    <span class="input-group-addon">₹</span>
                                                                                    <input  class="form-control" placeholder="Winning value"
                                                                                           type="text" id="value_auctionNumber0">
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-sm-2">
                                                                                <div class="input-group">
                                                                                    <span class="input-group-addon">₹</span>
                                                                                    <input class="form-control" placeholder="Dividend paid"
                                                                                           type="text" id="dividend_auctionNumber0">
                                                                                </div>
                                                                            </div>
                                                                            <br><br>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                    <div id="hiddenUpcomingAuctionDate" hidden="hidden">
                                                                    <label class="control-label col-sm-2" for="upcomingAuctionDate">Next Auction</label>
                                                                    <div class="col-sm-3">
                                                                        <div class="input-group datepicker">
                                                                            <input id="upcomingAuctionDate" name="upcomingAuctionDate"
                                                                                   placeholder="YYYY-MM-DD HH:SS" type="text" class="form-control">
                                                                                    <span class="input-group-btn"><a href="#" class="btn btn-success"><span
                                                                                            class="glyphicon-calendar glyphicon"></span></a></span>
                                                                        </div>
                                                                    </div>
                                                                    </div>
                                                                    <input type="hidden" name="groupId" value="${groupDetail.groupId}"/>
                                                                    <input type="hidden" name="${_csrf.parameterName}"
                                                                           value="${_csrf.token}" />
                                                                    <input type="hidden" name="auctionDetails" id="auctionDetails"/>


                                                            </fieldset>
                                                                    <br>
                                                                    <br>
                                                                    <div class="row">
                                                                        <div class="col-sm-offset-4 col-sm-7">
                                                                            <button type="button" id ="commenceGroupSubmit" class="btn btn-primary">Commence</button>
                                                                            <%--<button type="button" class="btn btn-inverse">Cancel</button>--%>
                                                                        </div>
                                                                    </div>
                                                            </form>
                                                            </div>
                                                            <%--<div class="modal-footer">--%>
                                                                <%--<button type="submit" id ="submit" class="btn btn-primary">Save</button>--%>
                                                                <%--<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>--%>
                                                            <%--</div>--%>
                                                        </div>
                                                        <!-- /.modal-content -->
                                                    </div>
                                                    <!-- /.modal-dialog -->
                                                </div>
                                        <!-- /.modal -->



                                            </c:when>
                                            <c:otherwise>
                                                <a href="#" class="btn btn-success btn-sm disabled" role="button">Commence Group</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </section>
                            </div>
                        </div>
                    </c:when>
                    <c:when test = "${ groupStatus == 'Active'}">
                        <div class="row" id="groupStats">
                            <div class="col-md-6 col-sm-6">
                                <section class="widget">
                                    <header>
                                        <h4>
                                            <span class="fw-semi-bold">Collection</span> Trends
                                        </h4>
                                    </header>
                                    <div class="widget-body">
                                        <div class="widget-body">
                                            <div id="nvd32">
                                                <svg></svg>
                                            </div>
                                        </div>
                                    </div>
                                </section>
                            </div>
                            <div class="col-md-6 col-sm-6">
                                <section class="widget">
                                    <header>
                                        <h4>
                                            % of total payments collected
                                        </h4>
                                    </header>
                                    <div class="widget-body clearfix">
                                        <div class="text-align-center">
                                            <div class="easy-pie-chart mb-lg" id="easy-pie1" data-percent="${collectionStats.collectionProgress}">
                                                ₹ ${collectionStats.amountCollected}
                                            </div>
                                        </div>
                                        <p class="fs-mini text-muted">
                                        </p>
                                    </div>
                                </section>
                            </div>
                            <div class="col-md-6 col-sm-6">
                                <section class="widget">
                                    <header>
                                        <h4>
                                            Payment Tracker
                                        </h4>
                                    </header>
                                    <div class="widget-body clearfix">
                                        <h4>${collectionStats.paidMembers}/${collectionStats.totalMembers}</h4>
                                        <div class="progress progress-xs">
                                            <div class="progress-bar progress-bar-gray-light" style="width: ${collectionStats.membersProgress}%;"></div>
                                        </div>
                                        <p class="fs-mini text-muted">
                                            have paid for this month's auction.
                                        </p>

                                        <c:choose>

                                            <c:when test="${currentMonth > noOfMembers-1 and outstandingAmount < 100}">
                                                <!-- Button trigger modal -->
                                                <button type="button" class="btn btn-primary" id="concludingDetailsButton" data-toggle="modal" data-target="#myModal">
                                                    Conclude Group
                                                </button>

                                                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                                                    <div class="modal-dialog modal-lg">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                                <h4 class="modal-title">Concluding Auction Details</h4>
                                                            </div>
                                                            <div class="modal-body">
                                                                <form class="form-horizontal" role="form" action="<%=request.getContextPath()%>/concludingAuctionReport"
                                                                      method="post" id="concludingAuctionForm">

                                                                    <div class="form-group">
                                                                        <label class="col-md-6 col-sm-6 fw-semi-bold" for="chitValue">Chit Value</label>
                                                                        <div class="input-group">
                                                                            <input disabled="disabled" class="form-control" id="chitValue" value="${groupDetail.groupValue}"/>
                                                                        </div>
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <label class="col-md-6 col-sm-6 fw-semi-bold">Winner</label>
                                                                        <div class="col-md-6 col-sm-6" id="concludingWinner"></div>
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <label class="col-md-6 col-sm-6 fw-semi-bold">Auction Number</label>
                                                                        <div class="col-md-6 col-sm-6" id="concludingAuctionNumber">${groupDetail.noOfMembers}</div>
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <label class="col-md-6 col-sm-6 fw-semi-bold" for="concludingCommission">Commission</label>
                                                                        <div class="input-group">
                                                                            <input class="form-control" id="concludingCommission" name="commissionAmount"/>
                                                                        </div>
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <label class="col-md-6 col-sm-6 fw-semi-bold" for="serviceTaxPercentage">Service Tax Percentage</label>
                                                                        <div class="input-group col-md-2 col-sm-2">
                                                                            <input class="form-control" id="serviceTaxPercentage" type="text" placeholder="Percentage" value="14.5"/>
                                                                            <span class="input-group-addon">%</span>
                                                                        </div>
                                                                    </div>

                                                                    <div class="form-group">
                                                                        <label class="col-md-6 col-sm-6 fw-semi-bold" for="concludingServiceTax">Service Tax</label>
                                                                        <div class="input-group">
                                                                            <input class="form-control" id="concludingServiceTax" name="serviceTaxAmount"/>
                                                                        </div>
                                                                    </div>


                                                                    <div class="form-group">
                                                                        <label class="col-md-6 col-sm-6 fw-semi-bold" for="concludingPrizeMoney">Prize Money</label>
                                                                        <div class="input-group">
                                                                            <input class="form-control" id="concludingPrizeMoney" name="concludingWinnerAmount"/>
                                                                        </div>
                                                                    </div>

                                                                    <input type="hidden" id="memberId" name="memberId" value=""/>
                                                                    <input type="hidden" id="groupId" name="groupId" value="${groupDetail.groupId}"/>
                                                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                                </form>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                                <button type="button" class="btn btn-primary" id="concludeRequestButton">Conclude Group</button>
                                                            </div>

                                                        </div><!-- /.modal-content -->
                                                    </div><!-- /.modal-dialog -->
                                                </div><!-- /.modal -->

                                                <%--<form method="post" action="<%=request.getContextPath()%>/ConcludeGroup">--%>
                                                <%--<input type="hidden" name="${_csrf.parameterName}"--%>
                                                <%--value="${_csrf.token}" />--%>
                                                <%--<input type="hidden" name="groupId" value="${groupDetail.groupId}" />--%>
                                                <%--<button type="submit" class="btn btn-success">Conclude Group</button>--%>
                                                <%--</form>--%>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                </section>
                            </div>
                        </div>
                    </c:when>
                    <c:when test = "${ groupStatus == 'Concluded'}">
                        <div class="row" id="groupStats">
                            <div class="col-md-6 col-sm-6">
                                <section class="widget">
                                    <header>
                                        <h4>
                                            The Group is concluded.
                                        </h4>
                                    </header>
                                </section>
                            </div>
                        </div>
                    </c:when>
                </c:choose>
                </div>
            </div>


        <div class="row">
            <div class="col-md-12">
                <section class="widget">
                    <header>
                        <h4><span class="fw-semi-bold" >Members list</span></h4>
                    </header>
                    <c:choose>
                        <c:when test="${ groupStatus == 'New'}">
                            <div class="btn-toolbar">
                                <a href="<%=request.getContextPath()%>/AddUserMember" class="btn btn-warning width-110 mb-xs btn btn-sm btn-default pull-right " role="button">ADD MEMBERS</a>
                            </div>
                        </c:when>
                    </c:choose>
                    <div class="widget-body">
                        <div class="mt" id="tableData">


                        </div>
                    </div>

                </section>
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


<!-- common app js -->
<script src="<%=request.getContextPath()%>/static/js/settings.js"></script>
<script src="<%=request.getContextPath()%>/static/js/app.js"></script>

<!-- page specific libs -->
<script src="<%=request.getContextPath()%>/static/vendor/moment/min/moment.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/eonasdan-bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/underscore/underscore-min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/backbone/backbone.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/backbone.paginator/lib/backbone.paginator.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/backgrid/lib/backgrid.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/backgrid-paginator/backgrid-paginator.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/datatables/media/js/jquery.dataTables.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/bootstrap-select/dist/js/bootstrap-select.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/d3/d3.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/nvd3/build/nv.d3.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/jquery.easy-pie-chart/dist/jquery.easypiechart.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/bootstrap-sass/assets/javascripts/bootstrap/modal.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/eonasdan-bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js"></script>
<%--page specfic for datatables--%>
<script src="<%=request.getContextPath()%>/static/vendor/select2/select2.min.js"></script>
<script src="<%=request.getContextPath()%>/static/js/groupDetail.js"></script>

<script>
    function loadElements(groupId,collectionTrend){
        $("#groupStats").show();
        initNvd32(collectionTrend);
        initEasyPie();
//        getGroupNameFromGroupId(groupId);
        var groupStatus = "${groupDetail.groupStatus}";
        var percentMembersAdded = "${groupDetail.percentMembersAdded}";
        getStatusButtonColor(groupStatus);
        getUsers(groupId);
    }

    var groupId = <%=request.getParameter("GroupId")%>;
    var collectionTrend = ${collectionTrend};
    if(groupId != null){
        window.onload = loadElements(groupId,collectionTrend);
    }
    else{
        $("#groupStats").hide();
    }
</script>

</body>
</html>
