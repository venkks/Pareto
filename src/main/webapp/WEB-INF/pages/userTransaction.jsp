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

<%--Including jsp file for sidebar--%>
<%@include file="sidebar.jsp"%>



<div class="content-wrap">
  <!-- main page content. the place to put widgets in. usually consists of .row > .col-md-* > .widget.  -->
  <main id="content" class="content" role="main">
    <div class="row">
      <div class="col-md-12">
        <section class="widget">
          <fieldset>
            <legend>
              <b>Group-level transactions</b>
            </legend>

            <div class="form-group">
              <label class="col-sm-3 control-label" for="branchId"> Branch</label>

              <div class="col-sm-4">
                <select id="branchId" data-placeholder="Select Branch"
                        class="select2 form-control" tabindex="-1" name="branchId"
                        data-minimum-results-for-search="5">
                  <option value=""></option>
                  <c:forEach items="${branchList}" var="branchList">
                    <option value="${branchList.branchId}">${branchList.branchName} </option>
                  </c:forEach>
                </select>
              </div>
            </div>
            <div class="form-group">&nbsp;</div>
            <div class="form-group">
              <label class="col-sm-3 control-label" for="groupId">Group</label>

              <div class="col-sm-4">
                <select data-placeholder="Select Group" id="groupId"
                        data-width="auto" data-minimum-results-for-search="5" tabindex="-1"
                        class="select2 form-control">
                  <option value=""></option>
                </select>
              </div>
            </div>
          </fieldset>
        </section>

        <section class="widget">
          <header>
            <h4><span class="fw-semi-bold"></span></h4>

          </header>
          <div class="widget-body" >

            <div class="mt" id="tableData">


            </div>
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
<%--<script src="<%=request.getContextPath()%>/static/vendor/moment/min/moment.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/eonasdan-bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js"></script>--%>
<script src="<%=request.getContextPath()%>/static/vendor/underscore/underscore-min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/backbone/backbone.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/backbone.paginator/lib/backbone.paginator.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/backgrid/lib/backgrid.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/backgrid-paginator/backgrid-paginator.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/datatables/media/js/jquery.dataTables.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/bootstrap-select/dist/js/bootstrap-select.min.js"></script>
<%--page specfic for datatables--%>
<script src="<%=request.getContextPath()%>/static/vendor/select2/select2.min.js"></script>
<script src="<%=request.getContextPath()%>/static/js/tables-dynamic.js"></script>
<script src="<%=request.getContextPath()%>/static/js/userTransaction.js"></script>

</body>
</html>
