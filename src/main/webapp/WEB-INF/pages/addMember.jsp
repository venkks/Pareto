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
                    <header>
                    </header>
                    <div class="widget-body">
                        <form class="form-horizontal" id="addMemberForm"
                              action="<%=request.getContextPath()%>/AddUserMember" method="post">
                            <fieldset>
                                <legend>
                                    <strong>ADD MEMBER/USER</strong>
                                </legend>
                                <c:choose>
                                    <c:when test="${user.userId > 0}">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label">
                                                Create new
                                                <span class="error">*</span>
                                            </label>
                                            <div class="col-sm-5">
                                                <div class="radio">
                                                    <input type="radio" id="createMember" name="addEntityType" value="member" checked="">
                                                    <label for="createMember">
                                                        Member
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label">
                                                Create new
                                                <span class="error">*</span>
                                            </label>
                                            <div class="col-sm-5">
                                                <div class="radio">
                                                    <input type="radio" id="createMemberAndUser" name="addEntityType" value="memberAndUser" checked="">
                                                    <label for="createMemberAndUser">
                                                        Member and User
                                                    </label>
                                                </div>
                                                <div class="radio">
                                                    <input type="radio" id="createUser" name="addEntityType" value="user">
                                                    <label for="createUser">
                                                        User
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </c:otherwise>
                                </c:choose>

                                <div class="form-group">
                                    <label class="col-sm-4 control-label" for="branchId">
                                        Branches
                                        <span class="error">*</span>
                                    </label>

                                    <div class="col-sm-5">
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
                                    <label class="col-sm-4 control-label" for="groupId">
                                        Groups
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
                                    <label for="title" class="col-sm-4 control-label">Title</label>

                                    <div class="col-sm-3">
                                        <select class="form-control" tabindex="-1" id="title" name="title">
                                            <option value="Mr." ${user.title == 'Mr.' ? 'selected' : ''}>Mr.</option>
                                            <option value="Ms." ${user.title == 'Ms.' ? 'selected' : ''}>Ms.</option>
                                            <option value="Mrs." ${user.title == 'Mrs.' ? 'selected' : ''}>Mrs.</option>
                                        </select>
                                    </div>

                                    <div>
                                        <input type="hidden" id="userId" name="userId" value=${user.userId}>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="fullName" class="col-sm-4 control-label">Account Name
                                        <span class="error">*</span>
                                    </label>

                                    <div class="col-sm-5">
                                        <input type="text" id="fullName" name="fullName" class="form-control"
                                               value= "<c:out value="${user.fullName}"/>"
                                               placeholder="User Name" required="required" data-parsley-id="3788">
                                        <ul class="parsley-errors-list" id="parsley-id-3788"></ul>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="userName" class="col-sm-4 control-label">User Name
                                        <span class="error">*</span></label>

                                    <div class="col-sm-7">
                                        <input type="email" id="userName" name="userName" placeholder=""
                                               class="form-control" required="required"
                                               value= "<c:out value="${user.userName}"/>">
                                    </div>
                                </div>


                                <div class="form-group">
                                    <label for="emailId" class="col-sm-4 control-label">Email
                                        <span class="error">*</span></label>

                                    <div class="col-sm-7">
                                        <input type="email" id="emailId" name="emailId" placeholder=""
                                               class="form-control" required="required" data-parsley-trigger="change"
                                               value= "<c:out value="${user.emailId}"/>">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="contact" class="col-sm-4 control-label">Mobile No
                                        <span class="error">*</span>
                                    </label>

                                    <div class="col-sm-4">
                                        <input type="text" id="contact" name="contact" class="form-control" required="required"
                                               value= "<c:out value="${user.contact}"/>">
                                        <span class="help-block">This will be username for account.</span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="password" class="col-sm-4 control-label">Password
                                        <span class="error">*</span>
                                    </label>

                                    <div class="col-sm-4">
                                        <input type="text" id="password" name="password" class="form-control" required="required">
                                        <span class="help-block">This will be password for account.</span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="openBalance" class="col-sm-4 control-label">Open Balance
                                        <span class="error">*</span>
                                    </label>

                                    <div class="col-sm-4">
                                        <input type="text" id="openBalance" name="openBalance" class="form-control" data-parsley-type="number" autocomplete="off" required="required"/>
                                    </div>
                                    <span class="help-block">Enter -1000 if outstanding amount is Rs. 1000.</span>
                                </div>

                                <div class="form-group">
                                    <label for="dob" class="col-sm-4 control-label">D.O.B
                                        <span class="error">*</span>
                                    </label>

                                    <div class="col-sm-6">

                                        <div id="datePicker" class="input-group">
                                            <input type="text" id="dob" name="dob" class="form-control"
                                                   placeholder="YYYY-MM-DD" value= "<c:out value="${user.dob}"/>">
                                            <span class="input-group-btn"> <a href="#" class="btn btn-success"> <span
                                                    class="glyphicon glyphicon-calendar"></span> </a> </span>
                                        </div>
                                        <%--<input type="text" id="dob" name="dob" class="form-control" value=${user.dob}>--%>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="aadharNo" class="col-sm-4 control-label">
                                        Aadhar Card No
                                    </label>

                                    <div class="col-sm-5">
                                        <input id="aadharNo" name="aadharNo" class="form-control" type="text"
                                               placeholder="Aadhar No" data-parsley-minlength="10"
                                               data-parsley-maxlength="12" maxlength="14"
                                               value= "<c:out value="${user.aadharNo}"/>">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-4 control-label" for="memberLocationBranchId">
                                        Member Location
                                        <span class="error">*</span>
                                    </label>

                                    <div class="col-sm-5">
                                        <select id="memberLocationBranchId" data-placeholder="Select Branch"
                                                class="select2 form-control" tabindex="-1" name="memberLocationBranchId"
                                                data-minimum-results-for-search="5" required="required">
                                            <option value=""></option>
                                            <c:forEach items="${branchList}" var="branchList">
                                                <option value="${branchList.branchId}">${branchList.branchName} </option>
                                            </c:forEach>

                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="address1" class="col-sm-4 control-label">Address</label>

                                    <div class="col-sm-7">
                                        <input type="text" id="address1" name="street" class="form-control"
                                               value= "<c:out value="${user.street}"/>">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="address2" class="col-sm-4 control-label">&nbsp;</label>

                                    <div class="col-sm-7">
                                        <input type="text" id="address2" name="place" class="form-control"
                                               value= "<c:out value="${user.place}"/>">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="city" class="col-sm-4 control-label">City</label>

                                    <div class="col-sm-4">
                                        <input type="text" id="city" name="city" class="form-control"
                                               value= "<c:out value="${user.city}"/>">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="zipCode" class="col-sm-4 control-label">Zipcode</label>

                                    <div class="col-sm-4">
                                        <input type="text" id="zipCode" name="zipCode" class="form-control"
                                               value= "<c:out value="${user.zipCode}"/>">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="state" class="col-sm-4 control-label">State</label>

                                    <div class="col-sm-4">
                                        <input type="text" id="state" name="state" class="form-control"
                                               value= "<c:out value="${user.state}"/>">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="country" class="col-sm-4 control-label">Country</label>

                                    <div class="col-sm-4">
                                        <input type="text" id="country" name="country" class="form-control"
                                               value= "<c:out value="${user.country}"/>">
                                    </div>
                                </div>
                                <input type="hidden" name="${_csrf.parameterName}"
                                       value="${_csrf.token}" />
                            </fieldset>
                            <div>&nbsp;</div>
                            <div class="">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <a href="<%=request.getContextPath()%>/AddMember"
                                           class="btn btn-primary btn-sm mb-xs pull-left">
                                            <i class="fa fa-caret-left"></i> &nbsp; Previous
                                        </a>
                                    </div>
                                    <div class="col-sm-7">
                                        <button type="submit" class="btn btn-primary btn-sm mb-xs">Save</button>
                                        <button type="reset" class="btn btn-inverse btn-sm mb-xs">Cancel</button>
                                        <%--<br>
                                        <br>--%>
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

<!-- common app js -->
<script src="<%=request.getContextPath()%>/static/js/settings.js"></script>
<script src="<%=request.getContextPath()%>/static/js/app.js"></script>

<!-- page specific libs -->
<script src="<%=request.getContextPath()%>/static/vendor/underscore/underscore-min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/backbone/backbone.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/messenger/build/js/messenger.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/messenger/build/js/messenger-theme-flat.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/messenger/docs/welcome/javascripts/location-sel.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/jasny-bootstrap/js/inputmask.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/parsleyjs/dist/parsley.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/moment/min/moment.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/eonasdan-bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/select2/select2.min.js"></script>
<!-- page specific js -->
<script src="<%=request.getContextPath()%>/static/js/addMember.js"></script>

</body>
</html>
