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
        <h2 class="page-title">Applicant Registration Form</h2>

        <!-- Change the width and height values to suit you best -->
        <div class="typeform-widget" data-url="https://letspareto.typeform.com/to/dA64hz" data-text="Registration Form" style="width:100%;height:500px;"></div>
        <script>(function(){var qs,js,q,s,d=document,gi=d.getElementById,ce=d.createElement,gt=d.getElementsByTagName,id='typef_orm',b='https://s3-eu-west-1.amazonaws.com/share.typeform.com/';if(!gi.call(d,id)){js=ce.call(d,'script');js.id=id;js.src=b+'widget.js';q=gt.call(d,'script')[0];q.parentNode.insertBefore(js,q)}})()</script>
        <div style="font-family: Sans-Serif;font-size: 12px;color: #999;opacity: 0.5; padding-top: 5px;">Powered by <a href="http://www.typeform.com/?utm_campaign=dA64hz&amp;utm_source=typeform.com-1862092-Basic&amp;utm_medium=typeform&amp;utm_content=typeform-embedded&amp;utm_term=EN" style="color: #999" target="_blank">Typeform</a></div>

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
