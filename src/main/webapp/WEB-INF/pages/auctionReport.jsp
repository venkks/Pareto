<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Pareto - Dashboard</title>
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
            <div class="col-md-8">
                <section class="widget">
                    <div class="widget-body">
                        ${success}
                        <form class="form-horizontal" role="form" action="<%=request.getContextPath()%>/AuctionReport"
                              method="post">
                            <fieldset>
                                <legend>
                                    <strong>Auction Reporting</strong>
                                </legend>

                                <div class="form-group">
                                    <label class="col-sm-5 control-label" for="branchId">
                                        Branches
                                        <span class="error">*</span>
                                    </label>

                                    <div class="col-sm-6">
                                        <select id="branchId" data-placeholder="Select Branch"
                                                class="select2 form-control" tabindex="-1" name="branchId"
                                                data-minimum-results-for-search="5">
                                            <option value="">
                                            </option>
                                            <c:forEach items="${branchList}" var="branchList">
                                                <option value="${branchList.branchId}">${branchList.branchName}
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-5 control-label" for="groupId">
                                        Groups
                                        <span class="error">*</span>
                                    </label>

                                    <div class="col-sm-6">
                                        <select data-placeholder="Select Group" id="groupId" name="groupId"
                                                data-width="auto" data-minimum-results-for-search="5" tabindex="-1"
                                                class="select2 form-control">
                                            <option value=""></option>
                                        </select>
                                    </div>
                                </div>
                                <span class="error" id="concludingAuctionError"></span>

                                <div class="form-group">
                                    <label class="col-sm-5 control-label" for="auctionDate">
                                        Date
                                        <span class="error">*</span>
                                    </label>
                                    <div class="col-sm-6">
                                        <div id="datePicker" class="input-group">
                                            <input id="auctionDate" required="required"
                                                   placeholder="YYYY-MM-DD HH:MM" name="auctionDate" type="text" class="form-control">
                                            <span class="input-group-btn"><a href="#" class="btn btn-success"><span
                                                    class="glyphicon-calendar glyphicon"></span></a></span>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-5 control-label" for="commissionPercentage">Commission Percentage</label>

                                    <div class="col-sm-4">
                                        <div class="input-group">
                                            <input id="commissionPercentage" name="commissionPercentage" class="form-control" value="5.0"
                                                   type="text">
                                            <span class="input-group-addon">%</span>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-5 control-label" for="serviceTax">Service Tax</label>

                                    <div class="col-sm-4">
                                        <div class="input-group">
                                            <input id="serviceTax" name="serviceTax" class="form-control" value="14.5"
                                                   type="text">
                                            <span class="input-group-addon">%</span>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-5 control-label" for="bidderCount">Number of Bidders</label>

                                    <div class="col-sm-2">
                                        <div class="input-group">
                                            <input id="bidderCount" name="bidderCount" class="form-control"
                                                   type="text">
                                        </div>
                                    </div>
                                    <button class="btn btn-default btn-sm" type="button" id="enterBidValues">
                                        Enter Bid Values</button>
                                </div>



                                <legend>
                                    <strong>Bid Details</strong>
                                </legend>


                                <div class="form-group field_wrapper">
                                    <div hidden="hidden">
                                    <div id="hiddenBidValueForm">
                                        <label class="control-label" for="bidderNumber0"></label>
                                        <div class="col-sm-6">
                                            <select data-placeholder="Select Member" id="bidderNumber0"
                                            data-width="auto" data-minimum-results-for-search="5" tabindex="-1"
                                            class="select2 form-control" >
                                                <option value="">
                                                </option>
                                            </select>
                                    </div>
                                        <label class="control-label" for="value_bidderNumber0"></label>
                                    <div class="col-sm-4">
                                        <div class="input-group">
                                            <span class="input-group-addon">₹</span>
                                            <input class="form-control" placeholder="Bid Value"
                                                   type="text" id="value_bidderNumber0">
                                        </div>
                                    </div>
                                    <br><br>
                                    </div>
                                    </div>

                                </div>


                                <button class="btn btn-default btn-sm pull-right" type="button" id="calculateAuctionReport">
                                    <i class="glyphicon-plus">Calculate Auction Report</i></button>


                                <input type="hidden" id="dividend" name="dividend">
                                <input type="hidden" id="paymentAmount" name="paymentAmount">
                                <input type="hidden" id="commissionAmount" name="commissionAmount">
                                <input type="hidden" id="serviceTaxAmount" name="serviceTaxAmount">
                                <input type="hidden" id="amount" name="amount">
                                <input type="hidden" id="bidDetails" name="bidDetails">
                                <input type="hidden" id="memberId" name="memberId">

                                <div id="auctionDetails">
                                    <legend><strong>Automatic Calculation</strong></legend>
                                    <div class="form-group">
                                        <label class="col-sm-5 control-label" for="commission">Chit Fund
                                            Commission</label>

                                        <div class="col-sm-4">
                                            <div class="input-group"><%--<span class="input-group-addon">₹</span>--%>
                                                <input id="commission" name="commission" class="form-control rupee"
                                                       type="text" disabled="disabled">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-5 control-label" for="dividend1">Dividend Amount</label>

                                        <div class="col-sm-4">
                                            <div class="input-group"><%--<span class="input-group-addon">₹</span>--%>
                                                <input id="dividend1" name="dividend1" class="form-control rupee" type="text"
                                                       disabled="disabled">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-5 control-label" for="nextMonthPayment">Payment next month
                                            </label>

                                        <div class="col-sm-4">
                                            <div class="input-group"><%--<span class="input-group-addon">₹</span>--%>
                                                <input id="nextMonthPayment" name="nextMonthPayment"
                                                       class="form-control rupee" type="text" disabled="disabled">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-5 control-label" for="winnerAmount">Winner's Amount</label>

                                        <div class="col-sm-4">
                                            <div class="input-group"><%--<span class="input-group-addon">₹</span>--%>
                                                <input id="winnerAmount" name="winnerAmount"
                                                       class="form-control rupee" type="text" disabled="disabled">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-5 control-label" for="taxAmount">Tax Amount</label>

                                        <div class="col-sm-4">
                                            <div class="input-group"><%--<span class="input-group-addon">₹</span>--%>
                                                <input id="taxAmount" name="taxAmount"
                                                       class="form-control rupee" type="text" disabled="disabled">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-5 control-label" for="upcomingAuctionDate">
                                            When is the next auction?
                                            <span class="error">*</span>
                                        </label>

                                        <div class="col-sm-6">
                                            <div id="datePickerNext" class="input-group">
                                                <input id="upcomingAuctionDate"
                                                       required="required" placeholder="YYYY-MM-DD HH:SS" name="upcomingAuctionDate" type="text" class="form-control">
                                            <span class="input-group-btn"><a href="#" class="btn btn-success"><span
                                                    class="glyphicon-calendar glyphicon"></span></a></span>
                                            </div>
                                        </div>
                                    </div>
                                    <input type="hidden" name="${_csrf.parameterName}"
                                           value="${_csrf.token}" />

                                </div>
                                <div class="form-group" id="checkRow">
                                    <label class="col-sm-5 control-label">Is this
                                    right?&nbsp;&nbsp;<a id="correct">Yes</a>&nbsp;&nbsp;<a id="modify">No</a></label>
                                </div>

                            </fieldset>
                            <div class="">
                                <div class="row">
                                    <div class="col-sm-offset-4 col-sm-7">
                                        <button type="submit" id ="submit" class="btn btn-primary">Save</button>
                                        <button type="button" class="btn btn-inverse">Cancel</button>
                                    </div>
                                </div>
                            </div>
                        </form>

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
<script src="<%=request.getContextPath()%>/static/vendor/moment/moment.js"></script>

<!-- common app js -->
<script src="<%=request.getContextPath()%>/static/js/settings.js"></script>
<script src="<%=request.getContextPath()%>/static/js/app.js"></script>

<!-- page specific libs -->
<script src="<%=request.getContextPath()%>/static/vendor/jasny-bootstrap/js/inputmask.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/parsleyjs/dist/parsley.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/moment/min/moment.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/eonasdan-bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/underscore/underscore-min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/backbone/backbone.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/messenger/build/js/messenger.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/messenger/build/js/messenger-theme-flat.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/messenger/docs/welcome/javascripts/location-sel.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/select2/select2.min.js"></script>


<!-- page specific js -->
<script src="<%=request.getContextPath()%>/static/js/auctionReport.js"></script>
<script>
    var success = <%=request.getParameter("success")%>
    if (success == 1) {
        addSuccess();
    } else if (success == 0) {
        addError();
    }
</script>

</body>
</html>
