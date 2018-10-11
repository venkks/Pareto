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
    <main id="content" class="content" role="main">
        <div class="row">
            <div class="col-md-6">
                <section class="widget">
                    <header>
                    </header>
                    <div class="widget-body">
                        <form class="form-horizontal" method="post" id="fullDetailsForm" action="<%=request.getContextPath()%>/UpdateUser">
                            <fieldset>
                                <legend>
                                    <strong>Full Details of ${user.fullName}</strong>
                                </legend>
                                <input type="hidden" id="userId" name="userId" value=${user.userId}>
                                <input type="hidden" id="memberId" name="memberId" value=${user.memberId}>
                                <div class="form-group">
                                    <label for="title" class="col-sm-4 control-label">Title</label>

                                    <div class="col-sm-3">
                                        <select class="form-control" tabindex="-1" id="title" name="title" disabled="disabled">
                                            <option value="Mr." ${user.title == 'Mr.' ? 'selected' : ''}>Mr.</option>
                                            <option value="Ms." ${user.title == 'Ms.' ? 'selected' : ''}>Ms.</option>
                                            <option value="Mrs." ${user.title == 'Mrs.' ? 'selected' : ''}>Mrs.</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="fullName" class="col-sm-4 control-label">Account Name
                                        <span class="error">*</span></label>

                                    <div class="col-sm-7">
                                        <input type="text" id="fullName" name="fullName" class="form-control"
                                               disabled="disabled" required="required"
                                               value="<c:out value="${user.fullName}"/>">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="userName" class="col-sm-4 control-label">User Name</label>

                                    <div class="col-sm-7">
                                        <input type="text" id="userName" name="userName" class="form-control"
                                               disabled="disabled"  required="required"
                                               value="<c:out value="${user.userName}"/>">
                                    </div>
                                </div>



                                <div class="form-group">
                                    <label for="emailId" class="col-sm-4 control-label">Email</label>

                                    <div class="col-sm-7">
                                        <input type="text" id="emailId" name="emailId" class="form-control"
                                               disabled="disabled" data-parsley-trigger="change" required="required"
                                               value="<c:out value="${user.emailId}"/>">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="mobileNo" class="col-sm-4 control-label">Mobile No
                                        <span class="error">*</span></label>

                                    <div class="col-sm-4">
                                        <input type="text" id="mobileNo" name="mobileNo" class="form-control"
                                               disabled="disabled" data-parsley-minlength="10"
                                               data-parsley-maxlength="12" maxlength="14"
                                               data-parsley-type="number" required="required"
                                               value="<c:out value="${user.mobileNo}"/>">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="dob" class="col-sm-4 control-label">D.O.B</label>

                                    <div class="col-sm-4">

                                        <%--<div id="datePicker" class="input-group">--%>
                                        <input type="text" id="dob" name="dob" class="form-control" disabled="disabled"
                                               placeholder="YYYY-MM-DD" value=${user.dob}>
                                        <%--<span class="input-group-btn"> <a href="#" class="btn btn-success"> <span
                                                class="glyphicon glyphicon-calendar"></span> </a> </span>--%>
                                        <%-- </div>--%>
                                        <%--<input type="text" id="dob" name="dob" class="form-control" value=${user.dob}>--%>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="aadharNo" class="col-sm-4 control-label">
                                        Aadhar Card No
                                    </label>

                                    <div class="col-sm-7">
                                        <input id="aadharNo" name="aadharNo" class="form-control" type="text"
                                               disabled="disabled"
                                               placeholder="Aadhar No"  value="<c:out value="${user.aadharNo}"/>">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="address1" class="col-sm-4 control-label">Address</label>

                                    <div class="col-sm-7">
                                        <input type="text" id="address1" name="street" class="form-control"
                                               disabled="disabled"
                                               value="<c:out value="${user.street}"/>">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="address2" class="col-sm-4 control-label">&nbsp;</label>

                                    <div class="col-sm-7">
                                        <input type="text" id="address2" name="place" class="form-control"
                                               disabled="disabled"
                                               value="<c:out value="${user.place}"/>">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="city" class="col-sm-4 control-label">City</label>

                                    <div class="col-sm-4">
                                        <input type="text" id="city" name="city" class="form-control"
                                               disabled="disabled"
                                               value="<c:out value="${user.city}"/>">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="zipCode" class="col-sm-4 control-label">Zipcode</label>

                                    <div class="col-sm-4">
                                        <input type="text" id="zipCode" name="zipCode" class="form-control"
                                               disabled="disabled"
                                               value="<c:out value="${user.zipCode}"/>">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="state" class="col-sm-4 control-label">State</label>

                                    <div class="col-sm-4">
                                        <input type="text" id="state" name="state" class="form-control"
                                               disabled="disabled"
                                               value="<c:out value="${user.state}"/>">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="country" class="col-sm-4 control-label">Country</label>

                                    <div class="col-sm-4">
                                        <input type="text" id="country" name="country" class="form-control"
                                               disabled="disabled"
                                               value="<c:out value="${user.country}"/>">
                                    </div>
                                </div>
                                <input type="hidden" name="${_csrf.parameterName}"
                                       value="${_csrf.token}" />
                            </fieldset>
                            <div class="row" id="editRow">
                                <div class="col-sm-offset-4 col-sm-7">
                                    <button type="button" id="editBtn" class="btn btn-primary">Edit</button>
                                </div>
                            </div>
                            <div class="row" id="updateRow">
                                <div class="col-sm-offset-4 col-sm-7">
                                    <button type="submit" class="btn btn-primary">Update</button>
                                    <button type="button" id="updateCancel" class="btn btn-inverse">Cancel</button>
                                </div>
                            </div>
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
<script src="<%=request.getContextPath()%>/static/vendor/underscore/underscore-min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/backbone/backbone.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/messenger/build/js/messenger.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/messenger/build/js/messenger-theme-flat.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/messenger/docs/welcome/javascripts/location-sel.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/jasny-bootstrap/js/inputmask.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/parsleyjs/dist/parsley.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/moment/min/moment.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/eonasdan-bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/select2/select2.min.js"></script>
<!-- page specific js -->
<script src="<%=request.getContextPath()%>/static/js/fullDetails.js"></script>
<script>
    var success =
    <%=request.getParameter("Success")%>
    if (success == 1) {
        addSuccess();
    } else if (success == 0) {
        addError();
    }
</script>

</body>
</html>

