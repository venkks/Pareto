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
                        <form class="form-horizontal" id="collectPaymentForm" method="post"
                              action="<%=request.getContextPath()%>/CollectPayment">
                            <section class="widget">
                                <fieldset>
                                    <legend>
                                        <b>Collect Payment</b>
                                    </legend>
                                    <div class="form-group">&nbsp;</div>
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label" for="branchId"> Branches
                                            <span class="error">*</span>
                                        </label>

                                        <div class="col-sm-4">
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
                                        <label class="col-sm-4 control-label" for="groupId">Groups
                                            <span class="error">*</span>
                                        </label>

                                        <div class="col-sm-5">
                                            <select data-placeholder="Select Group" id="groupId" name="groupId"
                                                    data-width="auto" data-minimum-results-for-search="5" tabindex="-1"
                                                    class="select2 form-control" required="required">
                                                <option value=""></option>

                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-4 control-label" for="memberId">
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
                                    <div class="form-group">
                                        <label for="amount" class="col-sm-4 control-label">Amount<span class="error">*</span></label>

                                        <div class="col-sm-4">
                                            <div class="input-group">
                                                <%--<span class="input-group-addon">₹</span>--%>
                                                <input id="amount" name="amount" class="form-control parsley-error"
                                                       data-parsley-range="[0, 10000000]" data-parsley-trigger="change"
                                                       data-parsley-validation-threshold="1" data-parsley-id="6177"
                                                       autocomplete="off" type="text"
                                                       placeholder="Amount" >

                                            </div>
                                        </div>
                                    <span id="balanceReminder"></span>
                                    </div>
                                    <div class="form-group">
                                        <label for="cash" class="col-sm-4 control-label">Payment Mode
                                        </label>

                                        <div class="col-sm-5">
                                            <div class="radio radio-primary">
                                                <input type="radio" name="transactionModeId" id="cash" value="1" checked>
                                                <label for="cash"> Cash </label>
                                            </div>
                                            <div class="radio radio-primary">
                                                <input type="radio" name="transactionModeId" id="cheque" value="2">
                                                <label for="cheque"> Cheque </label>
                                            </div>
                                            <div class="radio radio-primary">
                                                <input type="radio" name="transactionModeId" id="onlinepayment" value="3">
                                                <label for="onlinepayment"> Online Payment </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="narration" class="col-sm-4 control-label">Remarks</label>

                                        <div class="col-sm-6">
                                            <textarea id="narration" name="narration" rows="2" class="form-control"></textarea>
                                        </div>
                                    </div>
                                    <input type="hidden" name="${_csrf.parameterName}"
                                           value="${_csrf.token}" />

                                </fieldset>
                                <div>
                                    <div class="row">
                                        <div class="col-sm-offset-4 col-sm-7">
                                            <button type="submit" class="btn btn-primary h" id="collectButton">Save</button>
                                            <button type="button" class="btn btn-inverse">Cancel</button>
                                        </div>
                                    </div>
                                </div>
                            </section>
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
<script src="<%=request.getContextPath()%>/static/vendor/parsleyjs/dist/parsley.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/underscore/underscore-min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/backbone/backbone.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/messenger/build/js/messenger.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/messenger/build/js/messenger-theme-flat.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/messenger/docs/welcome/javascripts/location-sel.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/select2/select2.min.js"></script>
<script src="<%=request.getContextPath()%>/static/js/collectPayment.js"></script>
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

