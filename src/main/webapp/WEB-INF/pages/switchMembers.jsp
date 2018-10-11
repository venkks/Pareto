<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <div class="row">
            <div class="col-md-8">
                <section class="widget">
                    <div class="widget-body">
                        <div class="row">
                            <div class="col-md-12">
                                <h4><strong>Switch Member</strong></h4>

                                <div id="wizard" class="form-wizard">
                                    <ul class="nav-justified mb-sm">
                                        <li><a href="#tab1" data-toggle="tab">
                                            <small>1.</small>
                                            Outgoing Member</a></li>
                                        <li><a href="#tab2" data-toggle="tab">
                                            <small>2.</small>
                                            Incoming Member</a></li>
                                        <li><a href="#tab3" data-toggle="tab">
                                            <small>3.</small>
                                            Switch Members</a></li>
                                    </ul>
                                    <div id="bar" class="progress progress-xs">
                                        <div class="progress-bar progress-bar-gray-light"></div>
                                    </div>
                                    <div class="tab-content">
                                        <div class="tab-pane bg-gray-lighter" id="tab1">
                                            <form action='' method="POST"
                                                  data-parsley-priority-enabled="false"
                                                  novalidate="novalidate">
                                                <fieldset>
                                                    <div class="form-group">
                                                        <label class="col-sm-6 control-label" for="branchId"> Branches
                                                            <span class="error">*</span>
                                                        </label>

                                                        <div class="col-sm-6">
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
                                                    <br>
                                                    <div class="form-group">
                                                        <label class="col-sm-6 control-label" for="groupId">Groups
                                                            <span class="error">*</span>
                                                        </label>

                                                        <div class="col-sm-6">
                                                            <select data-placeholder="Select Group" id="groupId"
                                                                    data-width="auto" data-minimum-results-for-search="5" tabindex="-1"
                                                                    class="select2 form-control" required="required">
                                                                <option value=""></option>

                                                            </select>
                                                        </div>
                                                    </div>
                                                    <br>
                                                    <div class="form-group">
                                                        <label class="col-sm-6 control-label" for="memberId">
                                                            Member Name
                                                            <span class="error">*</span>
                                                        </label>

                                                        <div class="col-sm-6">
                                                            <select data-placeholder="Select Member" id="memberId" name="memberId"
                                                                    data-width="auto" data-minimum-results-for-search="5" tabindex="-1"
                                                                    class="select2 form-control" required="required" >
                                                                <%--<option value=""></option>--%>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </form>
                                            <br>
                                            <br>
                                            <div id="incomingMemberDetails" hidden="hidden">
                                                <div class="row">
                                                    <div class="fw-semi-bold col-md-6">Installments Paid</div>
                                                    <div class="col-md-6" id="installmentsPaid"></div>
                                                </div>
                                                <br>
                                                <div class="row">
                                                    <div class="fw-semi-bold col-md-6">Dividend Earned</div>
                                                    <div class="col-md-6" id="dividendEarned"></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="tab-pane bg-gray-lighter" id="tab2">
                                            <form action='' method="GET"
                                                  data-parsley-priority-enabled="false"
                                                  novalidate="novalidate">
                                                <fieldset>
                                                    <div class="form-group">
                                                        <label for="incomingUserName">Incoming Member Name</label>
                                                        <input type="text" id="incomingUserName" name="address" placeholder=""
                                                               class="form-control">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="incomingUserPhone">Incoming Member Phone</label>
                                                        <input type="text" id="incomingUserPhone" name="address" placeholder=""
                                                               class="form-control">
                                                    </div>
                                                </fieldset>
                                                <button class="btn btn-primary btn-rounded pull-right" type="button" id="findUser">
                                                    Find Member
                                                </button>
                                            </form>
                                        </div>
                                        <div class="tab-pane bg-gray-lighter" id="tab3">
                                        <h3>Incoming Member Details</h3>
                                            <div class="row">
                                                <div class="fw-semi-bold col-md-6">Name</div>
                                                <div class="col-md-6" id="summaryIncomingMemberName"></div>
                                            </div>
                                            <div class="row">
                                                <div class="fw-semi-bold col-md-6">Membership Amount</div>
                                                <div class="col-md-6" id="summaryIncomingMembershipAmout"></div>
                                            </div>

                                            <h3>Outgoing Member Details</h3>
                                            <div class="row">
                                                <div class="fw-semi-bold col-md-6">Name</div>
                                                <div class="col-md-3" id="summaryOutgoingMemberName"></div>
                                            </div>
                                            <div class="row">
                                                <div class="fw-semi-bold col-md-6">Refund Amount</div>
                                                <div class="col-md-3" id="summaryOutgoingRefundAmount"></div>
                                            </div>
                                        </div>

                                        <ul class="pager wizard">
                                            <li class="previous">
                                                <button class="btn btn-default btn-rounded pull-left">
                                                    <i class="fa fa-caret-left"></i> &nbsp; Previous
                                                </button>
                                            </li>
                                            <li class="next">
                                                <button class="btn btn-primary btn-rounded pull-right" >
                                                    Next &nbsp; <i class="fa fa-caret-right"></i></button>
                                            </li>
                                            <li class="finish" style="display: none">
                                                <form action="/random" method="post">
                                                    <input type="text" id="incomingUserNameForm" name="incomingUserName" hidden="hidden"/>
                                                    <input type="text" id="incomingUserPhoneForm" name="incomingUserPhone" hidden="hidden"/>
                                                    <input type="text" id="outgoingMemberIdForm" name="outgoingMemberId" hidden="hidden"/>
                                                    <input type="text" id="groupIdForm" name="groupId" hidden="hidden"/>
                                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                    <button type="submit" class="btn btn-success btn-rounded pull-right btn-primary" id="switchMembersFinish" >
                                                        Finish &nbsp; <i class="glyphicon glyphicon-ok"></i>
                                                    </button>
                                                </form>

                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
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
<script src="<%=request.getContextPath()%>/static/vendor/jquery/dist/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/jquery/dist/jquery.validate.js"></script>
<%--<script src="<%=request.getContextPath()%>/static/vendor/jquery/jquery-1.12.2.min.js"></script>--%>
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
<script src="<%=request.getContextPath()%>/static/vendor/parsleyjs/dist/parsley.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/bootstrap-sass/assets/javascripts/bootstrap/tab.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/twitter-bootstrap-wizard/jquery.bootstrap.wizard.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/underscore/underscore-min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/backbone/backbone.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/moment/min/moment.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/messenger/build/js/messenger.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/messenger/build/js/messenger-theme-flat.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/messenger/docs/welcome/javascripts/location-sel.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/select2/select2.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/bootstrap-sass/assets/javascripts/bootstrap/modal.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/bootstrap-sass/assets/javascripts/bootstrap/popover.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/bootstrap-application-wizard/src/bootstrap-wizard.js"></script>
<script src="<%=request.getContextPath()%>/static/js/switchMembers.js"></script>
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

