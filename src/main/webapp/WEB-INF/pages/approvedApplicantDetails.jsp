<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
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
        <div class="col-md-11">
            <section class="widget widget-invoice">
                <header>
                    <div class="row">
                        <div class="col-sm-6 col-print-6">
                            <h3 class="company-name">
                                Acme Chit Funds
                            </h3>
                        </div>
                        <div class="col-sm-6 col-print-6">
                            <h3 class="text-align-right">
                                #<span class="fw-semi-bold">324244</span> / <small>16th Jan 2016</small>
                            </h3>
                            <div class="text-muted fs-larger text-align-right">
                                On-boarding Application Form
                            </div>
                        </div>
                    </div>
                </header>
                <div class="widget-body">
                    <div class="row mb-lg">
                        <section class="col-sm-6 col-print-6">
                            <h4 class="text-muted no-margin">Personal Information</h4>
                            <address>
                                <br>
                                <br>
                                <div class="col-md-6 col-sm-6 col-print-6">Name</div>
                                <div class="col-md-6 col-sm-6 col-print-6">Sourabh Rohilla</div>
                                <br>
                                <div class="col-md-6 col-sm-6 col-print-6">Date of Birth</div>
                                <div class="col-md-6 col-sm-6 col-print-6">23rd January 1983</div>
                                <br>
                                <div class="col-md-6 col-sm-6 col-print-6">Sex</div>
                                <div class="col-md-6 col-sm-6 col-print-6">Male</div>
                                <br>
                                <div class="col-md-6 col-sm-6 col-print-6">Current Address</div>
                                <div class="col-md-6 col-sm-6 col-print-6">Flat 71, India Colony, Doha</div>
                                <br>
                                <div class="col-md-6 col-sm-6 col-print-6">Native Address</div>
                                <div class="col-md-6 col-sm-6 col-print-6">Flat 25, Customs Colony, Chennai, Tamil Nadu</div>
                                <br>
                                <div class="col-md-6 col-sm-6 col-print-6">Phone</div>
                                <div class="col-md-6 col-sm-6 col-print-6">+974 6550285</div>
                                <br>
                                <div class="col-md-6 col-sm-6 col-print-6">E-mail</div>
                                <div class="col-md-6 col-sm-6 col-print-6">sourabh.rohilla@letspareto.com</div>
                                <br>
                            </address>
                        </section>
                        <div class="col-sm-6 col-print-6 text-align-right">
                            <img src="<%=request.getContextPath()%>/static/img/picture_sourabh.jpeg" width="200px" height="200px"/>
                        </div>
                    </div>


                    <div class="widget-body">
                        <div class="row mb-lg">
                    <section class="col-sm-6 col-print-6">
                        <h4 class="text-muted no-margin">Professional Information</h4>
                        <address>
                            <br>
                            <br>
                            <div class="col-md-6 col-sm-6 col-print-6">Company</div>
                            <div class="col-md-6 col-sm-6 col-print-6">Siemens Technology, Doha Towers, Qatar</div>
                            <br>
                            <div class="col-md-6 col-sm-6 col-print-6">Department</div>
                            <div class="col-md-6 col-sm-6 col-print-6">Mobile Division</div>
                            <br>
                            <div class="col-md-6 col-sm-6 col-print-6">Occupation</div>
                            <div class="col-md-6 col-sm-6 col-print-6">Site Engineer</div>
                            <br>
                            <div class="col-md-6 col-sm-6 col-print-6">Employee code</div>
                            <div class="col-md-6 col-sm-6 col-print-6">SM4352</div>
                            <br>
                            <div class="col-md-6 col-sm-6 col-print-6">Gross Income</div>
                            <div class="col-md-6 col-sm-6 col-print-6">Rs. 70000</div>
                            <br>
                            <br>
                        </address>
                    </section>
                    </div>
                    </div>

                    <div class="widget-body">
                        <div class="row gallery" id="grid">
                            <h4 class="text-muted no-margin">Document Proofs</h4>
                            <br>
                            <div class="col-sm-6 col-md-3 gallery-item" data-groups='["nature"]' data-title="Mountains">
                                <div class="thumbnail">
                                    <a href="<%=request.getContextPath()%>/static/img/generated-aadhar-card.jpg">
                                        <img src="<%=request.getContextPath()%>/static/img/generated-aadhar-card.jpg" alt="..."></a>
                                    <div class="caption">
                                        <h5 class="mt-0 mb-xs">Aadhar Card</h5>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-3 gallery-item" data-groups='["people"]' data-title="Empire State Pigeon">
                                <div class="thumbnail">
                                    <a href="<%=request.getContextPath()%>/static/img/License.jpg">
                                        <img src="<%=request.getContextPath()%>/static/img/License.jpg" alt="..."></a>
                                    <div class="caption">
                                        <h5 class="mt-0 mb-xs">Driving Licence</h5>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-3 gallery-item" data-groups='["nature"]' data-title="Big Lake">
                                <div class="thumbnail">
                                    <a href="<%=request.getContextPath()%>/static/img/property-papers.jpg">
                                        <img src="<%=request.getContextPath()%>/static/img/property-papers.jpg" alt="..."></a>
                                    <div class="caption">
                                        <h5 class="mt-0 mb-xs">Property Papers- Chennai</h5>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>



                    <div class="btn-toolbar mt-lg text-align-right hidden-print">


                        <button id="print" class="btn btn-inverse">
                            <i class="fa fa-print"></i>
                            &nbsp;&nbsp;
                            Print
                        </button>
                        <button class="btn btn-success">
                            Assign to Group
                            &nbsp;
                                <span class="circle bg-white">
                                    <i class="fa fa-arrow-right text-success"></i>
                                </span>
                        </button>
                        <button class="btn btn-danger">
                            Cancel Approval
                            &nbsp;
                                <span class="circle bg-white">
                                    <i class="fa fa-remove text-danger"></i>
                                </span>
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


</body>

</html>
