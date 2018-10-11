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

<%
    java.util.HashMap<String,String> applicant1 = new java.util.HashMap<>();
    applicant1.put("name","Sourabh Rohilla");
    applicant1.put("location","Doha, Qatar");
    applicant1.put("income","Rs. 65,000");

    java.util.HashMap<String,String> applicant2 = new java.util.HashMap<>();
    applicant2.put("name","Prabhakaran");
    applicant2.put("location","Dubai, UAE");
    applicant2.put("income","Rs. 70,000");

    java.util.HashMap<String,String> applicant3 = new java.util.HashMap<>();
    applicant3.put("name","Radhika Shinde");
    applicant3.put("location","Panvel, Maharashtra");
    applicant3.put("income","Rs. 80,000");

    java.util.HashMap<String,String> applicant4 = new java.util.HashMap<>();
    applicant4.put("name","Hemant Bajaj");
    applicant4.put("location","Singapore");
    applicant4.put("income","Rs. 90,000");

    java.util.List<HashMap<String,String>> applicantList = new ArrayList<HashMap<String, String>>();
    applicantList.add(applicant1);
    applicantList.add(applicant2);
    applicantList.add(applicant3);
    applicantList.add(applicant4);

    pageContext.setAttribute("applicantList",applicantList);

%>


<div class="content-wrap">
    <main id="content" class="content" role="main">
        <h2 class="page-title">Approved Applicants</h2>
        <h4>The following applications have been approved and waiting to be assigned to a group.</h4>

        <div class="row">
        <c:forEach items="${applicantList}" var="applicant">
                <div class="col-md-4 col-sm-6 applicantSection" id="applicantListDiv" data-toggle="#">
                        <section class="widget bg-primary text-white">
                            <div class="widget-body clearfix">
                                <div class="row">
                                    <div class="col-xs-2">
                            <a href="<%=request.getContextPath()%>/ApprovedApplicantDetails">
                                        <span class="widget-icon">
                                        <i class="fa fa-square-o"></i>
                            </span>
                            </a>
                                    </div>
                                    <div class="col-xs-9">
                                        <p class="h4 no-margin fw-normal">${applicant.name}</p>
                                        <h5 class="no-margin">${applicant.location}</h5>
                                        <h5 class="no-margin">${applicant.income}</h5>
                                    </div>
                                </div>
                            </div>

                        </section>
                    </section>
                </div>
        </c:forEach>

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
<script src="<%=request.getContextPath()%>/static/vendor/bootstrap-sass/assets/javascripts/bootstrap/modal.js"></script>


<!-- page specific js -->


</body>
</html>
