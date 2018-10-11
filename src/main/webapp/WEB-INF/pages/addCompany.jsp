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
         https://code.gwoogle.com/p/chromium/issues/detail?id=332189
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
                        <form class="form-horizontal" id="addCompanyForm" action="<%=request.getContextPath()%>/AddCompany" method="post">
                            <fieldset>
                                <legend>
                                    <strong>Add Company</strong>
                                </legend>
                                <div class="form-group">
                                    <label for="companyName" class="col-sm-4 control-label">Company Name
                                        <span class="error">*</span>
                                    </label>

                                    <div class="col-sm-7">
                                        <input type="text" required="required"
                                               id="companyName" name="companyName" class="form-control"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="emailId" class="col-sm-4 control-label">Email
                                        <span class="error">*</span></label>

                                    <div class="col-sm-7">
                                        <input type="text" required="required"
                                               id="emailId" name="emailId" class="form-control"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="password" class="col-sm-4 control-label">Password
                                        <span class="error">*</span></label>

                                    <div class="col-sm-7">
                                        <input type="password" required="required"
                                               id="password" name="password" class="form-control"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="contact" class="col-sm-4 control-label">Mobile No
                                    <span class="error">*</span>
                                    </label>

                                    <div class="col-sm-4">
                                        <input type="text" id="contact" name="contact" required="required" data-parsley-type="number" autocomplete="off"
                                               class="form-control"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="panNo" class="col-sm-4 control-label">
                                        Pan No
                                    </label>

                                    <div class="col-sm-4">
                                        <input id="panNo" name="panNo" class="form-control" type="text"/>
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
                                    <label for="city" class="col-sm-4 control-label">City <span class="error">*</span></label>

                                    <div class="col-sm-4">
                                        <input type="text" id="city" name="city" class="form-control" required="required"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="zip" class="col-sm-4 control-label">Zipcode</label>

                                    <div class="col-sm-4">
                                        <input type="text" id="zip" name="zip" class="form-control"/>
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
                                <div class="form-group">
                                    <label for="remarks" class="col-sm-4 control-label">Remarks</label>

                                    <div class="col-sm-7">
                                        <textarea id="remarks" name="remarks" rows="2" class="form-control"></textarea>
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
<script src="<%=request.getContextPath()%>/static/vendor/jasny-bootstrap/js/inputmask.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/parsleyjs/dist/parsley.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/moment/min/moment.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/eonasdan-bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/jasny-bootstrap/js/fileinput.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/select2/select2.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/underscore/underscore-min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/backbone/backbone.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/messenger/build/js/messenger.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/messenger/build/js/messenger-theme-flat.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/messenger/docs/welcome/javascripts/location-sel.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/bootstrap-sass/assets/javascripts/bootstrap/tab.js"></script>

<!-- page specific js -->
<script src="<%=request.getContextPath()%>/static/js/companyTable.js"></script>


</body>
</html>
