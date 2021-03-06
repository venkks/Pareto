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
            <section class="widget">
                <header>
                    <h4>Today, you have collected</h4>
                </header>
                <div class="widget-body">
                    <div class="stats-row">
                        <div class="stat-item">
                            <h6 class="name">Cash</h6>
                            <p class="value">₹ ${todayCashCollection}</p>
                        </div>
                        <div class="stat-item">
                            <h6 class="name">Cheque</h6>
                            <p class="value">₹ ${todayChequeCollection}</p>
                        </div>
                    </div>
                </div>
            </section>
        </div>
        <div class="row">
            <section class="widget">
                <header>
                    <h4><span class="fw-semi-bold">Daily Collection</span></h4>
                </header>
                <div class="widget-body">
                    <div class="mt">
                        <table id="datatable-table" class="table table-striped table-hover">
                            <thead>
                            <tr>
                                <th style="width: 18%;">
                                    Date
                                </th>
                                <th>
                                    Collection Mode
                                </th>
                                <th>
                                    Amount
                                </th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${transactionList}" var="transaction">
                                <tr>
                                    <td>${transaction.transactionDate}</td>
                                    <td>${transaction.paymentMode}</td>
                                    <td>${transaction.amount}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>

                    </div>
                </div>

            </section>
        </div>

        <div class="row">
            <section class="widget">
                <header>
                    <h4><span class="fw-semi-bold">Pending Collections</span></h4>
                </header>
                <div class="widget-body">
                    <div class="mt">
                        <table id="datatable-table-2" class="table table-striped table-hover">
                            <thead>
                            <tr>
                                <th style="width: 18%;">
                                    Member
                                </th>
                                <th>
                                    Amount
                                </th>
                                <th>
                                    Next Auction in (days)
                                </th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${pendingPayments}" var="pendingPayment">
                                <tr>
                                    <td>${pendingPayment.fullName}</td>
                                    <td>${pendingPayment.amount}</td>
                                    <td>${pendingPayment.numDaysToNextAuction}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>

                    </div>
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
<script src="<%=request.getContextPath()%>/static/vendor/eonasdan-bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/select2/select2.min.js"></script>--%>
<script src="<%=request.getContextPath()%>/static/vendor/underscore/underscore-min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/backbone/backbone.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/backbone.paginator/lib/backbone.paginator.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/backgrid/lib/backgrid.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/backgrid-paginator/backgrid-paginator.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/datatables/media/js/jquery.dataTables.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/bootstrap-select/dist/js/bootstrap-select.min.js"></script>
<%--page specfic for datatables--%>

<script src="<%=request.getContextPath()%>/static/vendor/messenger/build/js/messenger.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/messenger/build/js/messenger-theme-flat.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/messenger/docs/welcome/javascripts/location-sel.js"></script>
<%--<script src="<%=request.getContextPath()%>/static/js/group-table.js"></script>--%>


<script src="<%=request.getContextPath()%>/static/js/collectionHistory.js"></script>
</body>
</html>
