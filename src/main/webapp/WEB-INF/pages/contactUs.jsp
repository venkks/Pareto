<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <main id="content" class="content" role="main">
        <div class="row">
            <div class="col-md-12">
                <section class="widget">
                    <header>
                        <h4>Contact Us</h4>
                    </header>
                    <div class="widget-body">
                        <p>
                            <strong>Pareto</strong> lets you run peer finance groups and connect with
                            your investment peers online. Please call us or write to us in case of any problem.
                        </p>
                        <br>
                        <br>
                        <div class="row">
                            <div class="col-sm-3 align-center col-sm-offset-3">
                                <img src="<%=request.getContextPath()%>/static/img/priya.jpg" width="200px" height="200px">
                                <strong>Priya Surya</strong> 9833898077 priya.surya@letspareto.com
                            </div>
                            <div class="col-sm-3">
                                <img src="<%=request.getContextPath()%>/static/img/sourabh.jpg" width="200px" height="200px">
                                <strong>Sourabh Rohilla</strong> 9004553241 sourabh.rohilla@letspareto.com
                            </div>
                        </div>

                            <%--<li><strong>Sourabh Rohilla</strong> 9004553241, sourabh.rohilla@letspareto.com </li>--%>
                    </div>
                </section>
            </div>
        </div>

        <p> Icon made by <a href="www.freepik.com">Freepik</a> from www.flaticon.com</p>
    </main>
</div>
<!-- The Loader. Is shown when pjax happens -->
<div class="loader-wrap hiding hide">
    <i class="fa fa-circle-o-notch fa-spin-fast"></i>
</div>


<!-- common libraries. required for every page-->

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
</body>
</html>
