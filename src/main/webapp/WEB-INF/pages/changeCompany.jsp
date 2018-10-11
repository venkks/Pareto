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

            <c:forEach items="${companyList}" var="company">

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

            </c:forEach>
        </div>

        <div class="modal fade" id="confirmChange" tabindex="-1" role="dialog" aria-labelledby="myModalLabel18" aria-hidden="true">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title text-align-center" id="confirmChangeLabel">Change Company</h4>
                </div>
                <div class="modal-body">
                    <form  class="form-horizontal" action="<%=request.getContextPath()%>/ChangeCompany" method="post">
                        <h4 class="text-align-center">
                            Are you want to change the company?
                        </h4>
                        <input type="hidden" name="changeCompanyId" id="changeCompanyId" >
                        <div class="modal-footer">
                            <button type="button" class="btn btn-gray" data-dismiss="modal">No</button>
                            <button type="submit" class="btn btn-success" id="modalYes">Yes</button>
                        </div>
                        <input type="hidden" name="${_csrf.parameterName}"
                               value="${_csrf.token}" />
                    </form>
                </div>
                <%--<div class="modal-footer">
                    <button type="button" class="btn btn-gray" data-dismiss="modal">No</button>
                    <button type="submit" class="btn btn-success" data-dismiss="modal">Yes</button>
                </div>--%>
            </div>
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
<script src="<%=request.getContextPath()%>/static/vendor/bootstrap-sass/assets/javascripts/bootstrap/modal.js"></script>


<!-- page specific js -->
<script src="<%=request.getContextPath()%>/static/js/changeCompany.js"></script>


</body>
</html>
