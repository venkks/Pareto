<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Pareto - Dashboard</title>
    <link href="<%=request.getContextPath()%>/static/css/application.css" rel="stylesheet">
    <link rel="stylsheet" type="text/css" media="print" href="<%=request.getContextPath()%>/static/css/print.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" conatent="IE=edge,chrome=1">
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
        <div class="col-md-11">
            <section class="widget widget-invoice">
                <header>
                    <div class="row">
                        <div class="col-sm-6 col-print-6">
                            <h3 class="company-name">
                                Karumbairam Chits Pvt. Ltd.
                            </h3>
                            <h5 class="text-muted">Reddy Rao Tank, Kumbakonam</h5>
                        </div>
                        <div class="col-sm-6 col-print-6">
                            <%--<h3 class="text-align-right">--%>
                                <%--#<span class="fw-semi-bold">324244</span> / <small>16th Jan 2016</small>--%>
                            <%--</h3>--%>
                            <div class="text-muted fs-larger text-align-right">
                                On-boarding Application Form
                            </div>
                        </div>
                    </div>
                </header>
                <div class="widget-body">
                    <div class="row mb-lg">
                        <section class="col-sm-9 col-print-9">
                            <h4 class="text-muted no-margin">Personal Information</h4>
                            <address>
                                <br>
                                <br>
                                <div class="row">
                                    <div class="col-md-3 col-sm-3 col-print-3">Name</div>
                                    <input class="col-md-9 col-sm-9 col-print-9 application-form"></input>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-md-3 col-sm-3 col-print-3">Date of Birth</div>
                                    <input class="col-md-9 col-sm-9 col-print-9 application-form"></input>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-md-3 col-sm-3 col-print-3">Sex</div>
                                    <input class="col-md-9 col-sm-9 col-print-9 application-form"></input>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-md-3 col-sm-3 col-print-3">Current Address</div>
                                    <input class="col-md-9 col-sm-9 col-print-9 application-form"></input>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-md-3 col-sm-3 col-print-3">Permanent Address</div>
                                    <input class="col-md-9 col-sm-9 col-print-9 application-form"></input>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-md-3 col-sm-3 col-print-3">Phone</div>
                                    <input class="col-md-9 col-sm-9 col-print-9 application-form"></input>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-md-3 col-sm-3 col-print-3">E-mail</div>
                                    <input class="col-md-9 col-sm-9 col-print-9 application-form"></input>
                                </div>
                            </address>
                        </section>
                        <div class="col-sm-3 col-print-3 text-align-right">
                            <img src="" width="200px" height="200px"/>
                        </div>
                    </div>


                    <div class="widget-body">
                        <div class="row mb-lg">
                    <section class="col-sm-9 col-print-9">
                        <h4 class="text-muted no-margin">Professional Information</h4>
                        <address>
                            <br>
                            <div class="row">
                                <div class="col-md-3 col-sm-3 col-print-3">Company</div>
                                <input class="col-md-9 col-sm-9 col-print-9 application-form"></input>
                            </div>
                            <br>
                            <div class="row">
                                <div class="col-md-3 col-sm-3 col-print-3">Department</div>
                                <input class="col-md-9 col-sm-9 col-print-9 application-form"></input>
                            </div>
                            <br>
                            <div class="row">
                                <div class="col-md-3 col-sm-3 col-print-3">Designation</div>
                                <input class="col-md-9 col-sm-9 col-print-9 application-form"></input>
                            </div>
                            <br>
                            <div class="row">
                                <div class="col-md-3 col-sm-3 col-print-3">Employee Code</div>
                                <input class="col-md-9 col-sm-9 col-print-9 application-form"></input>
                            </div>
                        </address>
                    </section>
                    </div>
                    </div>


                    <div class="widget-body">
                        <div class="row mb-lg">
                            <section class="col-sm-9 col-print-9">
                                <h4 class="text-muted no-margin">Documentary proofs</h4>
                                <address>
                                    <br>
                                    <div class="row">
                                        <div class="col-md-3 col-sm-3 col-print-3">PAN Card No.</div>
                                        <input class="col-md-9 col-sm-9 col-print-9 application-form"></input>
                                    </div>
                                    <br>
                                    <div class="row">
                                        <div class="col-md-3 col-sm-3 col-print-3">Aadhar Card No.</div>
                                        <input class="col-md-9 col-sm-9 col-print-9 application-form"></input>
                                    </div>
                                    <br>
                                </address>
                            </section>
                        </div>
                    </div>


                    <div class="btn-toolbar mt-lg text-align-right hidden-print">
                        <button id="print" class="btn btn-success">
                            <i class="fa fa-print"></i>
                            &nbsp;&nbsp;
                            Print
                        </button>
                    </div>
                </div>
            </section>
        </div>
    </div>
</main>
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
<script src="<%=request.getContextPath()%>/static/vendor/bootstrap-sass/assets/javascripts/bootstrap/modal.js"></script>


<!-- page specific js -->
<script src="<%=request.getContextPath()%>/static/js/newApplicantDetails.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/magnific-popup/dist/jquery.magnific-popup.min.js"></script>

</body>

</html>
