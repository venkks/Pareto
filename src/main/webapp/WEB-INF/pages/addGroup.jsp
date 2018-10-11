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
    <!-- main page content. the place to put widgets in. usually consists of .row > .col-md-* > .widget.  -->
    <main id="content" class="content" role="main">
        <div class="row">
            <div class="col-md-6">
                <section class="widget">
                    <div class="widget-body">
                        <form class="form-horizontal"id="addGroupForm"
                              method="post" action="<%=request.getContextPath()%>/AddGroup">
                            <fieldset>
                                <legend>
                                    <b>Create Group</b>
                                </legend>
                                <div class="form-group">
                                    <label class="col-sm-5 control-label" for="branchId">
                                        Branches
                                        <span class="error">*</span>
                                    </label>
                                    <div class="col-sm-7">
                                        <select id="branchId" data-placeholder="Select Branch"
                                                class="select2 form-control" tabindex="-1" name="branchId"
                                                data-minimum-results-for-search="5" required="required">
                                            <option value=""></option>
                                            <c:forEach items="${branchList}" var="branchList">
                                                <option value="${branchList.branchId}">${branchList.branchName} </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-5 control-label" for="groupName">
                                        Group Name
                                        <span class="error">*</span>
                                    </label>

                                    <div class="col-sm-7">
                                        <input type="text" id="groupName" required="required" name="groupName" class="form-control"
                                               placeholder="Group Name">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-5 control-label" for="groupValue">Chit Value
                                        <span class="error">*</span>
                                    </label>

                                    <div class="col-sm-4">
                                        <div class="input-group">
<%--
                                            <span class="input-group-addon">₹</span>
--%>
                                            <input id="groupValue" name="groupValue" class="form-control rupee" required="required"
                                                   data-parsley-type="number" autocomplete="off" type="text">
                                            <%--<span class="input-group-addon">.00</span>--%>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-5 control-label" for="memberCount">Member Count
                                        <span class="error">*</span>
                                    </label>

                                    <div class="col-sm-4">
                                        <div class="input-group">
                                            <input id="memberCount" name="memberCount" required="required"
                                                   data-parsley-type="number" autocomplete="off" type="text">
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-5 control-label" for="auctionDate">Date of 1st
                                        Auction</label>

                                    <div class="col-sm-5">
                                        <div id="datePicker" class="input-group">
                                            <input id="auctionDate" name="auctionDate" placeholder="YYYY-MM-DD"
                                                   type="text" class="form-control">
                                            <span class="input-group-btn"><a href="#" class="btn btn-success"><span
                                                    class="glyphicon-calendar glyphicon"></span></a></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-5 control-label" for="auctionDate">Date of 2nd
                                        Auction</label>

                                    <div class="col-sm-5">
                                        <div id="secondDatePicker" class="input-group">
                                            <input id="secondAuctionDate" name="secondAuctionDate" placeholder="YYYY-MM-DD" type="text" class="form-control">
                                            <span class="input-group-btn"><a href="#" class="btn btn-success"><span
                                                    class="glyphicon-calendar glyphicon"></span></a></span>
                                        </div>
                                    </div>
                                </div>

                                <%--<div class="form-group">
                                    <label class="col-sm-5 control-label" for="auctionFq">Auction Frequency</label>

                                    <div class="col-sm-7" id="auctionFq">
                                        <div class="radio radio-primary">
                                            <input type="radio" name="auctionFrequency" id="monthly" value="30">
                                            <label for="monthly">Monthly</label>
                                        </div>
                                        <div class="radio radio-primary">
                                            <input type="radio" name="auctionFrequency" id="weekly" value="7">
                                            <label for="weekly">Weekly</label>
                                        </div>
                                        <div class="radio radio-primary">
                                            <input type="radio" name="auctionFrequency" id="other">
                                            <label for="other">Other</label>
                                        </div>
                                        <div class="col-sm-12">
                                            <input type="text" id="otherFq" name="otherFq" class="form-control"
                                                   disabled="disabled">
                                        </div>
                                    </div>
                                </div>--%>
                                <div class="form-group">
                                    <label for="smsOptions" class="col-sm-5 control-label">Member Notification</label>

                                    <div class="col-sm-7">
                                        <div class="checkbox-inline checkbox-ios">
                                            <label for="smsOptions">
                                                <input type="checkbox" id="smsOptions" name="smsOptions" checked>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <input type="hidden" name="${_csrf.parameterName}"
                                       value="${_csrf.token}" />
                            </fieldset>
                            <div class="">
                                <div class="row">
                                    <div class="col-sm-offset-4 col-sm-7">
                                        <button type="submit" class="btn btn-primary">Save Changes</button>
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
<script src="<%=request.getContextPath()%>/static/vendor/jquery/dist/jquery.validate.js"></script>

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
<%--<script src="<%=request.getContextPath()%>/static/js/ui-notifications.js"></script>--%>
<script src="<%=request.getContextPath()%>/static/js/addGroup.js"></script>
<script>
    var success =  <%=request.getParameter("success")%>
    if(success == 1){
        addSuccess();
    }else if(success == 0){
        addError();
    }
</script>


</body>
</html>
