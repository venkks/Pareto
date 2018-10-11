<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <title>Pareto - Login</title>
    <link href="<%=request.getContextPath()%>/static/css/application.css" rel="stylesheet">
    <!-- as of IE9 cannot parse css files with more that 4K classes separating in two files -->
    <!--[if IE 9]>
        <link href="css/application-ie9-part2.css" rel="stylesheet">
    <![endif]-->
    <link rel="shortcut icon" href="img/favicon.png">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <script>
        /* yeah we need this empty stylesheet here. It's cool chrome & chromium fix
         chrome fix https://code.google.com/p/chromium/issues/detail?id=167083
         https://code.google.com/p/chromium/issues/detail?id=332189
         */
    </script>
</head>
<body class="login-page" style="

background: #1D2B64; /* fallback for old browsers */
background: -webkit-linear-gradient(to left, #1D2B64 , #F8CDDA); /* Chrome 10-25, Safari 5.1-6 */
background: linear-gradient(to left, #1D2B64 , #F8CDDA); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
        ">
<div class="container">
    <main id="content" class="widget-login-container" role="main">
        <div class="row">
            <div class="col-lg-4 col-sm-6 col-xs-10 col-lg-offset-4 col-sm-offset-3 col-xs-offset-1">
                <h4 class="widget-login-logo animated fadeInUp">
                    <%--<i class="fa fa-circle text-gray"></i>--%>
                    PARETO
                    <%--<i class="fa fa-circle text-warning"></i>--%>
                </h4>
                <h5 class="animated fadeInUp text-align-center" style="color:whitesmoke">Put your money to work. With those you trust.</h5>
                <section class="widget widget-login animated fadeInUp">
                    <header>
                        <%--<h3>Welcome to Pareto</h3>--%>
                    </header>
                    <div class="widget-body">
                        <form class="login-form mt-lg" name="loginForm"
                              action="<c:url value='/login' />" method="POST">
                            <div class="form-group">
                                <input type="text" name="username" class="form-control" id="exampleInputEmail1" placeholder="Username">
                            </div>
                            <div class="form-group">
                                <input class="form-control" id="password" name="password" type="password" placeholder="Password">
                            </div>
                            <div class="clearfix">
                                <div class="btn-toolbar pull-right">
                                    <button type="submit" class="btn btn-default btn-sm">Login</button> <%--
                                    <a class="btn btn-inverse btn-sm" href="index.html">Login</a> --%>
                                </div>
                            </div>
                            <%--&lt;%&ndash;<div class="row">
                                <div class="col-sm-6 col-sm-push-6">
                                    <div class="clearfix">
                                        <div class="checkbox widget-login-info pull-right ml-n-lg">
                                            <input type="checkbox" id="checkbox1" value="1">
                                            <label for="checkbox1">Keep me signed in </label>
                                        </div>
                                    </div>
                                </div>&ndash;%&gt;

                                &lt;%&ndash;<div class="col-sm-6 col-sm-pull-6">
                                    <a class="mr-n-lg" href="#">Trouble with account?</a>
                                </div>&ndash;%&gt;
                            </div>--%>
                            <input type="hidden" name="${_csrf.parameterName}"
                                   value="${_csrf.token}" />


                        </form>
                    </div>
                </section>
            </div>
        </div>
    </main>
    <footer class="page-footer">
        2016 &copy; Pareto Technologies
    </footer>
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

<!-- common app js -->
<script src="<%=request.getContextPath()%>/static/js/settings.js"></script>
<script src="<%=request.getContextPath()%>/static/js/app.js"></script>

<!-- page specific libs -->
<!-- page specific js -->
</body>
</html>