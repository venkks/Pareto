<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


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
        <h1 class="page-title"><%=(company != null?company.getCompanyName():"")%></h1>
        <div class="row">
            <section class="widget">
                <div class="widget-body">

                    <%--<div class="row col-lg-12 pdgRgtM15">
                        <textarea rows="8" class="form-control" id="default-textarea"
                                  placeholder="Alert...,">

                        </textarea>
                    </div>--%>
                    <c:out value="${Success}" />
                    <div class="row" style="display: block;">
                        <label class="col-sm-3">
                            <h4>Branches</h4>
                        </label>

                        <div class="col-sm-9">&nbsp; </div>
                    </div>


                    <div class="row col-lg-12" id="branches">
                        <c:forEach items="${branchList}" var="branch">

                            <a id="branch${branch.branchId}" class="getBranchGroups">
                                <button type="button" class="btn btn-success btn-sm mb-xs">${branch.branchName}</button>
                            </a>&nbsp;&nbsp;&nbsp;&nbsp;
                        </c:forEach>
                    </div>
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">&nbsp;</div>
                    </div>
                </div>
            </section>
            </div>

        <div class="row" id="collection-trend">
            <div class = "col-sm-6 col-md-6">
            <section class="widget" >
                <header>
                    <h4>
                        <span class="fw-semi-bold">Collection</span> Trends
                    </h4>
                    <div class="widget-controls">
                        <a href="#" data-widgster="close"><i class="glyphicon glyphicon-remove"></i></a>
                    </div>
                </header>
                <div class="widget-body">
                        <div class="widget-body">
                            <p class="fs-mini text-muted">
                                In past 2 months
                            </p>
                            <div id="nvd31">
                                <svg></svg>
                            </div>
                        </div>
                </div>
            </section>
            </div>

            <div class = "col-sm-6 col-md-6">
            <section class="widget" >
                <header>
                    <h4>
                        <span class="fw-semi-bold">Portfolio</span> Health
                    </h4>
                    <div class="widget-controls">
                        <a href="#" data-widgster="close"><i class="glyphicon glyphicon-remove"></i></a>
                    </div>
                </header>
                <div class="widget-body">
                    <div class="widget-body">
                        <p class="fs-mini text-muted">
                            In past 3 months
                        </p>
                        <div id="nvd32">
                            <svg></svg>
                        </div>
                    </div>
                </div>
            </section>
            </div>


        </div>

        <div class="row">
            <section class="widget" id="groupRow">
                <header>
                    <h4> GROUPS</h4>
                </header>
                <div class="widget-body">
                    <div class="row" >

                        <div class="col-sm-9">
                            <div class="btn-toolbar" style="display: block;">
                                <a href="<%=request.getContextPath()%>/AddGroup"
                                   class="btn btn-warning width-100 mb-xs btn btn-sm btn-default pull-right "
                                   role="button">
                                    ADD GROUP
                                </a>
                            </div>
                        </div>

                    </div>
                </div>

                <div id="groups">
                </div>
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
