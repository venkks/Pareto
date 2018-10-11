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
        <div class="row mb-lg">
            <div class="col-md-6">
                <div class="clearfix">
                    <ul id="tabs1" class="nav nav-tabs pull-left">
                        <li class="active"><a href="#tab1" data-toggle="tab">Individual Entry</a></li>
                        <li class=""><a href="#tab2" data-toggle="tab">Member Batch Upload</a></li>
                    </ul>
                </div>
                <div id="tabs1c" class="tab-content mb-lg">
                    <div class="tab-pane active clearfix" id="tab1">
                        <form class="form-horizontal" id="getUserForm"
                              action="<%=request.getContextPath()%>/GetUserDetails"
                              method="post">
                            <fieldset>
                                <legend>
                                    <strong>Add Member</strong>
                                </legend>

                                <div class="form-group">
                                    <label for="accountName" class="col-sm-5 control-label">
                                        Account Name
                                        <span class="error">*</span>
                                    </label>

                                    <div class="col-sm-5">
                                        <input id="accountName" name="fullName" class="form-control" type="text"
                                               placeholder="User Name" required="required" >
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="contact" class="col-sm-5 control-label">
                                        Mobile Number
                                        <span class="error">*</span>
                                    </label>

                                    <div class="col-sm-4">
                                        <input id="contact" name="contact" class="form-control" type="text"
                                               placeholder="Mobile No." data-parsley-minlength="10"
                                               data-parsley-maxlength="12" maxlength="12"
                                               data-parsley-type="number" required="required">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="aadharNo" class="col-sm-5 control-label">
                                        Aadhar Card No
                                        <span class="help-block">(eg.4323-9878-7862)</span>
                                    </label>

                                    <div class="col-sm-5">
                                        <input id="aadharNo" name="aadharNo" class="form-control" type="text"
                                               placeholder="XXXX-XXXX-XXXX" data-parsley-minlength="10"
                                               data-parsley-maxlength="12" maxlength="14">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="dob" class="col-sm-5 control-label">
                                        Date of Birth
                                    </label>

                                    <div class="col-sm-4">
                                        <div id="datePicker" class="input-group">
                                            <input type="text" id="dob" name="dob" class="form-control"
                                                   placeholder="YYYY-MM-DD">
                                            <span class="input-group-btn"> <a href="#" class="btn btn-success"> <span
                                                    class="glyphicon glyphicon-calendar"></span> </a> </span>
                                        </div>
                                    </div>
                                </div>
                                <input type="hidden" name="${_csrf.parameterName}"
                                       value="${_csrf.token}" />
                            </fieldset>
                            <div class="row">
                                <div class="col-sm-11">
                                    <button type="submit" class="btn btn-primary btn-sm mb-xs pull-right">
                                        Next &nbsp;
                                        <i class="fa fa-caret-right"></i>
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>

                    <div class="tab-pane" id="tab2">
                        <form class="form-horizontal" role="form" action="<%=request.getContextPath()%>/ImportData"
                              method="post" enctype="multipart/form-data" id="fileUploadForm">
                            <fieldset>
                                <legend>
                                    <strong>File Upload</strong>
                                </legend>
                                <div class="form-group">
                                    <label class="col-sm-4 control-label" for="branchId">
                                        Branches
                                        <span class="error">*</span>
                                    </label>

                                    <div class="col-sm-6">

                                        <select id="branchId" data-placeholder="Select Branch"
                                                class="select2 form-control" tabindex="-1" name="branchId"
                                                data-minimum-results-for-search="5" required="required">
                                            <option value=""></option>
                                            <c:forEach items="${branchList}" var="branchList">
                                                <option value="${branchList.branchId}">${branchList.branchName} </option>
                                            </c:forEach>

                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-4 control-label" for="groupId">
                                        Groups
                                        <span class="error">*</span>
                                    </label>

                                    <div class="col-sm-6">
                                        <select data-placeholder="Select Group" id="groupId" name="groupId"
                                                data-width="auto" data-minimum-results-for-search="5" tabindex="-1"
                                                class="select2 form-control" required="required">
                                            <option value=""></option>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="control-label col-sm-4" for="fileupload1">
                                        File To Upload
                                        <span class="error">*</span>
                                    </label>

                                    <div class="col-sm-6">
                                        <input id="fileupload1" name="fileUpload" type="file" class="form-control" required="required" data-parsley-filetype='xls' >
                                        <%--<div class="fileinput fileinput-new input-group" data-provides="fileinput">
                                            <div class="form-control" data-trigger="fileinput">
                                                <i class="glyphicon glyphicon-file fileinput-exists"></i>
                                                <span class="fileinput-filename"></span>
                                            </div>
                                            <span class="input-group-addon btn btn-default btn-file">
                                                <span class="fileinput-new">Select File</span>
                                                <span class="fileinput-exists">Change</span>

                                            </span>
                                            <a href="#" class="input-group-addon btn btn-default fileinput-exists"
                                               data-dismiss="fileinput">Remove</a>
                                        </div>--%>
                                        <span class="help-block">The upload file must be in '.xls' format.</span>
                                        <span ><a href="<%=request.getContextPath()%>/static/resources/batch_upload_new.xls">For
                                            Sample .xls file</a></span>

                                    </div>
                                </div>
                                <input type="hidden" name="${_csrf.parameterName}"
                                       value="${_csrf.token}" />
                            </fieldset>
                            <div class="row">
                                <div class="col-sm-offset-4 col-sm-6">
                                    <button type="submit" class="btn btn-primary">Upload</button>
                                </div>
                            </div>
                        </form>
                        <input type="hidden" id="msg" value= "<c:out value="${importSuccess}"/>">
                    </div>


                </div>
            </div>
            <%--<div class="col-sm-6">--%>
                <%--<c:forEach items="${existUserList}" var="existUser" varStatus="count">--%>
                    <%--&lt;%&ndash;<p>${existUser.fullName}  - ${existUser.mobileNo}</p>&ndash;%&gt;--%>

                    <%--<div class="col-md-6 col-sm-6 popupSection" id="popup${count.index}"  data-toggle="modal" data-target="#confirmMobileChange" >--%>

                        <%--<section class="widget bg-success text-white">--%>
                                <%--<div class="widget-body clearfix">--%>
                                    <%--<div class="row">--%>
                                        <%--&lt;%&ndash;<div class="col-xs-2">--%>
                            <%--<span class="widget-icon">--%>
                                <%--<c:choose>--%>
                                    <%--<c:when test="${sessionCompanyId == companyId}">--%>
                                        <%--<i class="fa fa-check-square-o"></i>--%>
                                    <%--</c:when>--%>
                                    <%--<c:otherwise>--%>
                                        <%--<i class="fa fa-square-o"></i>--%>
                                    <%--</c:otherwise>--%>
                                <%--</c:choose>--%>
                            <%--</span>--%>
                                        <%--</div>&ndash;%&gt;--%>
                                        <%--<div class="col-xs-9">--%>
                                            <%--<input type="hidden" style="color:black;" value="${count.index}">--%>
                                            <%--<input type="hidden" id="excelUser${count.index}" value="${existUser}"/>--%>
                                            <%--<p class="h4 no-margin fw-normal">${existUser.fullName}</p>--%>
                                            <%--<h5 class="no-margin">${existUser.mobileNo}</h5>--%>
                                        <%--</div>--%>
                                    <%--</div>--%>
                                <%--</div>--%>

                            <%--</section>--%>
                        <%--</section>--%>
                    <%--</div>--%>
                <%--</c:forEach>--%>
            <%--</div>--%>
            <%--<div class="modal fade" id="confirmMobileChange" tabindex="-1" role="dialog" aria-labelledby="myModalLabel18" aria-hidden="true">--%>
                <%--<div class="modal-dialog">--%>
                    <%--<div class="modal-content">--%>
                        <%--<div class="modal-header">--%>
                            <%--<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>--%>
                            <%--<h4 class="modal-title text-align-center" id="confirmChangeLabel">Change Company</h4>--%>
                        <%--</div>--%>
                        <%--<div class="modal-body">--%>
                            <%--<form  class="form-horizontal" action="<%=request.getContextPath()%>/AddExcelUser" method="post">--%>
                                <%--<h4 class="text-align-center">--%>
                                    <%--The mobile number already exist in the group.--%>
                                    <%--Do want to add it in the same group?--%>
                                <%--</h4>--%>
                                <%--<input type="hidden" name="confirmExcelUser" id="confirmExcelUser" >--%>
                                <%--<input type="hidden" id="popupId">--%>
                                <%--<div class="modal-footer">--%>
                                    <%--<button type="button" class="btn btn-gray" data-dismiss="modal">No</button>--%>
                                    <%--<button type="button" class="btn btn-success" id="addExcelUser" data-dismiss="modal">Yes</button>--%>
                                <%--</div>--%>
                            <%--</form>--%>
                        <%--</div>--%>
                        <%--&lt;%&ndash;<div class="modal-footer">--%>
                            <%--<button type="button" class="btn btn-gray" data-dismiss="modal">No</button>--%>
                            <%--<button type="submit" class="btn btn-success" data-dismiss="modal">Yes</button>--%>
                        <%--</div>&ndash;%&gt;--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>

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

<script src="<%=request.getContextPath()%>/static/vendor/underscore/underscore-min.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/backbone/backbone.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/messenger/build/js/messenger.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/messenger/build/js/messenger-theme-flat.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/messenger/docs/welcome/javascripts/location-sel.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/bootstrap-sass/assets/javascripts/bootstrap/tab.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/bootstrap-sass/assets/javascripts/bootstrap/modal.js"></script>
<script src="<%=request.getContextPath()%>/static/vendor/select2/select2.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.3/css/select2.min.css" rel="stylesheet" />



<!-- page specific js -->
<script src="<%=request.getContextPath()%>/static/js/addMember.js"></script>

<script>
    var failure= ${failure};
    var errors = failure.errorList;
    for(i=0;i<errors.length;i++){
        showErrorMessage(errors[i]);
    }

    <%--var success = <%=request.getParameter("success")%>--%>
    <%--if (success == 1) {--%>
        <%--addSuccess();--%>
    <%--} else if (success == 0) {--%>
        <%--addError();--%>
    <%--}--%>
    var uploadSuccess = $("#msg").val();
    console.log(uploadSuccess);
    if(uploadSuccess != ""){
        importSuccess(uploadSuccess);
    }

</script>
</body>
</html>

