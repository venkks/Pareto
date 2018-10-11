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
    <!-- main page content. the place to put widgets in. usually consists of .row > .col-md-* > .widget.  -->
    <main id="content" class="content" role="main">
        <div class="row">
            <div class="col-md-6">
                <section class="widget">
                    <div class="widget-body">
                        <form class="form-horizontal" method="post"
                              action="<%=request.getContextPath()%>/AddBranch" id="addBranchForm">
                            <section class="widget">
                                <fieldset>
                                    <legend>
                                        <b>Create Branch</b>
                                    </legend>
                                    <div class="form-group">&nbsp;</div>

                                    <div class="form-group">
                                        <label class="col-sm-4 control-label" for="branchName">Branch Name
                                            <span class="error">*</span></label>

                                        <div class="col-sm-6">
                                            <input type="text" id="branchName" name="branchName" class="form-control" required="required"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="street" class="col-sm-4 control-label">Address</label>

                                        <div class="col-sm-6">
                                            <input type="text" id="street" name="street" class="form-control"/>
                                        </div>

                                    </div>
                                    <div class="form-group">
                                        <label for="address" class="col-sm-4 control-label">&nbsp;</label>

                                        <div class="col-sm-6">
                                            <input type="text" id="address" name="address" class="form-control"/>
                                        </div>

                                    </div>
                                    <div class="form-group">
                                        <label for="contact" class="col-sm-4 control-label">Mobile No
                                            <span class="error">*</span></label>

                                        <div class="col-sm-6">
                                            <input type="text" id="contact" name="contact" class="form-control"
                                                   data-parsley-type="number" required="required"/>
                                        </div>

                                    </div>
                                    <input type="hidden" name="${_csrf.parameterName}"
                                           value="${_csrf.token}" />
                                </fieldset>
                                <div>
                                    <div class="row">
                                        <div class="col-sm-offset-4 col-sm-7">
                                            <button type="submit" class="btn btn-primary">Save</button>
                                            <button type="button" class="btn btn-inverse">Cancel</button>
                                        </div>
                                    </div>
                                </div>
                            </section>
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
<script src="<%=request.getContextPath()%>/static/vendor/underscore/underscore-min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/backbone/backbone.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/messenger/build/js/messenger.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/messenger/build/js/messenger-theme-flat.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/messenger/docs/welcome/javascripts/location-sel.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/select2/select2.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/parsleyjs/dist/parsley.min.js"></script>
<script src="<%=request.getContextPath()%>/static/js/addBranch.js"></script>
<script>
    var success =  <%=request.getParameter("Success")%>
    if(success == 1){
        addSuccess();
    }else if(success == 0){
        addError();
    }
</script>
</body>
</html>
