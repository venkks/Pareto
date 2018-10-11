<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


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

<%--Including jsp file for sideBar--%>
<%@include file="sidebar.jsp"%>



<div class="content-wrap">
    <main id="content" class="content" role="main">
        <h3 class="page-title">Download your report.</h3>

        <div class="col-md-3 col-sm-6 companySection" id="changeCompanyDivId${company.companyId}" data-toggle="modal" data-target="#confirmChange" >
            <c:set var="companyId" value="${company.companyId}"/>
            <c:choose>
            <c:when test="${sessionCompanyId == companyId}">
            <section class="widget bg-success text-white">
                </c:when>
                <c:otherwise>
                <section class="widget bg-primary text-white">
                    </c:otherwise>
                    </c:choose>
                    <div class="widget-body clearfix">
                        <div class="row">
                            <div class="col-xs-2">
                            <span class="widget-icon">
                                <c:choose>
                                    <c:when test="${sessionCompanyId == companyId}">
                                        <i class="fa fa-check-square-o"></i>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fa fa-square-o"></i>
                                    </c:otherwise>
                                </c:choose>
                            </span>
                            </div>
                            <div class="col-xs-9">
                                <p class="h4 no-margin fw-normal">${company.companyName}</p>
                                <h5 class="no-margin">${company.city}</h5>
                                <h5 class="no-margin">${company.contact}</h5>
                            </div>
                        </div>
                    </div>

                </section>
            </section>
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
<script src="<%=request.getContextPath()%>/static/js/transition.js"></script>
<script src="<%=request.getContextPath()%>/static/js/collapse.js"></script>
<script src="<%=request.getContextPath()%>/static/js/dropdown.js"></script>
<script src="<%=request.getContextPath()%>/static/js/button.js"></script>
<script src="<%=request.getContextPath()%>/static/js/tooltip.js"></script>
<script src="<%=request.getContextPath()%>/static/js/alert.js"></script>
<script src="<%=request.getContextPath()%>/static/js/jquery.slimscroll.min.js"></script>
<script src="<%=request.getContextPath()%>/static/js/widgster.js"></script>
<script src="<%=request.getContextPath()%>/static/js/pace.min.js"></script>
<script src="<%=request.getContextPath()%>/static/js/jquery.touchSwipe.js"></script>


<!-- common app js -->
<script src="<%=request.getContextPath()%>/static/js/settings.js"></script>
<script src="<%=request.getContextPath()%>/static/js/app.js"></script>

<!-- page specific libs -->
<script src="<%=request.getContextPath()%>/static/vendor/moment/min/moment.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/eonasdan-bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/select2/select2.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/d3/d3.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/nvd3/build/nv.d3.min.js"></script>
<!-- page specific js -->
<script src="<%=request.getContextPath()%>/static/js/partnerDashboard.js"></script>





</body>
</html>
