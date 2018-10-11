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
            <div class="col-md-6">
                <section class="widget">
                    <div class="widget-body">
                        <form class="form-horizontal" id="addStaffForm" action="<%=request.getContextPath()%>/AddStaffForCompany" method="post">
                            <fieldset>
                                <legend>
                                    <strong>Add Staff</strong>
                                </legend>
                                <div class="form-group">
                                    <label class="col-sm-4 control-label" for="companyId">
                                        Company
                                    <span class="error">*</span>
                                    </label>

                                    <div class="col-sm-6">
                                        <select id="companyId" data-placeholder="Select Company" required="required"
                                                class="select2 form-control" tabindex="-1" name="companyId"
                                                data-minimum-results-for-search="5">
                                            <option value=""></option>
                                            <c:forEach items="${companyList}" var="companyList">
                                                <option value="${companyList.companyId}">${companyList.companyName} </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-4 control-label"  for="branchId">
                                        Branches
                                    <span class="error">*</span>
                                    </label>

                                    <div class="col-sm-6">
                                        <select id="branchId" data-placeholder="Select Branch" required="required"
                                                class="select2 form-control" tabindex="-1" name="branchId"
                                                data-minimum-results-for-search="5">
                                            <option value=""></option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="title" class="col-sm-4 control-label">Role</label>

                                    <div class="col-sm-3">
                                        <select class="select2 form-control" data-placeholder="Role" tabindex="-1"
                                                id="roleId" name="roleId" data-minimum-results-for-search="5">
                                            <option value=""></option>
                                            <option value=2>Head</option>
                                            <option value=3>Staff</option>
                                        </select>
                                    </div>
                                </div>
                                <%--<div>
                                    <input type="hidden" id="userId" name="userId">
                                </div>--%>
                                <div class="form-group">
                                    <label for="title" class="col-sm-4 control-label">Title</label>

                                    <div class="col-sm-6">
                                        <select class="select2 form-control" tabindex="-1"
                                                data-minimum-results-for-search="5" id="title" name="title">
                                            <option value="Mr.">Mr.</option>
                                            <option value="Ms.">Ms.</option>
                                            <option value="Mrs.">Mrs.</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="fullName" class="col-sm-4 control-label">
                                        Full Name
                                    <span class="error">*</span>
                                    </label>

                                    <div class="col-sm-7">
                                        <input type="text" required="required" id="fullName"
                                               name="fullName" class="form-control"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="emailId" class="col-sm-4 control-label">Email
                                    <span class="error">*</span></label>

                                    <div class="col-sm-7">
                                        <input type="text" id="emailId" required="required"
                                               name="emailId" class="form-control"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="contact" class="col-sm-4 control-label">
                                        Mobile No
                                    <span class="error">*</span>
                                    </label>

                                    <div class="col-sm-4">
                                        <input type="text" id="contact" name="contact" class="form-control"
                                                required="required"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="designation" class="col-sm-4 control-label">
                                        Designation
                                        <span class="error">*</span>
                                    </label>

                                    <div class="col-sm-4">
                                        <input type="text" id="designation" name="designation" class="form-control"
                                               required="required"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="dob" class="col-sm-4 control-label">D.O.B
                                        <span class="help-block">YYYY-MM-DD</span>
                                        <span class="error">*</span></label>

                                    <div class="col-sm-6">

                                        <div id="datePicker" class="input-group">
                                            <input type="text" id="dob" name="dob" class="form-control"
                                                   placeholder="YYYY-MM-DD" required="required">
                                            <span class="input-group-btn"> <a href="#" class="btn btn-success"> <span
                                                    class="glyphicon glyphicon-calendar"></span> </a> </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="aadharNo" class="col-sm-4 control-label">
                                        Aadhar Card No
                                    </label>

                                    <div class="col-sm-7">
                                        <input id="aadharNo" name="aadharNo" class="form-control" type="text"
                                               placeholder="Aadhar No" data-parsley-minlength="10"
                                               data-parsley-maxlength="12" maxlength="14"
                                               data-parsley-type="number">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="address1" class="col-sm-4 control-label">Address</label>

                                    <div class="col-sm-7">
                                        <input type="text" id="address1" name="street" class="form-control"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="address2" class="col-sm-4 control-label">&nbsp;</label>

                                    <div class="col-sm-7">
                                        <input type="text" id="address2" name="place" class="form-control"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="city" class="col-sm-4 control-label">City</label>

                                    <div class="col-sm-4">
                                        <input type="text" id="city" name="city" class="form-control"/>
                                    </div>

                                </div>
                                <div class="form-group">
                                    <label for="zipCode" class="col-sm-4 control-label">Zipcode</label>

                                    <div class="col-sm-4">
                                        <input type="text" id="zipCode" name="zipCode" class="form-control"/>
                                    </div>

                                </div>
                                <div class="form-group">
                                    <label for="state" class="col-sm-4 control-label">State</label>

                                    <div class="col-sm-4">
                                        <input type="text" id="state" name="state" class="form-control"/>
                                    </div>

                                </div>
                                <div class="form-group">
                                    <label for="country" class="col-sm-4 control-label">Country</label>

                                    <div class="col-sm-4">
                                        <input type="text" id="country" name="country" class="form-control"/>
                                    </div>
                                </div>
                                <input type="hidden" name="${_csrf.parameterName}"
                                       value="${_csrf.token}" />
                            </fieldset>
                            <div>&nbsp;</div>
                            <div class="">
                                <div class="row">
                                    <div class="col-sm-4">
                                        &nbsp;
                                    </div>
                                    <div class="col-sm-7">
                                        <button type="submit" class="btn btn-primary btn-sm mb-xs">Save</button>
                                        <button type="reset" class="btn btn-inverse btn-sm mb-xs">Cancel</button>
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
<script src="<%=request.getContextPath()%>/static/js/addStaff.js"></script>

</body>
</html>

