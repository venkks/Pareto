<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="it.upspring.laabam.domain.User" %>
<%@ page import="it.upspring.laabam.domain.Company" %>


<nav id="sidebar" class="sidebar" role="navigation">
    <!-- need this .js class to initiate slimscroll -->
    <div class="js-sidebar-content">
        <header class="logo hidden-xs" style="display: block;">Pareto</header>
        <!-- seems like lots of recent admin template have this feature of user info in the sidebar.
             looks good, so adding it and enhancing with notifications -->
        <% User loginUser = (User) session.getAttribute("loginUser"); %>
        <div class="sidebar-status visible-xs">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                <span class="thumb-sm avatar pull-right">
                </span>
                <!-- .circle is a pretty cool way to add a bit of beauty to raw data.
             should be used with bg-* and text-* classes for colors -->
                        <%--<span class="circle bg-warning fw-bold text-gray-dark">--%>
                    <%--13</span>--%>
                &nbsp;
                <strong>
                    <%=(loginUser != null?loginUser.getFullName():"")%></strong>

                <b class="caret"></b>
            </a>
            <!-- #notifications-dropdown-menu goes here when screen collapsed to xs or sm -->
                <ul class="dropdown-menu">
                    <li class="divider"></li>
                    <li>
                        <a href="<%=request.getContextPath()+"/SignOut"%>"><i class="fa fa-sign-out"></i> &nbsp; Log Out</a>
                    </li>
                </ul>

        </div>
        <!-- main notification links are placed inside of .sidebar-nav -->
        <!-- every .sidebar-nav may have a title -->

        <ul class="sidebar-nav" style="display: block;">
            <sec:authorize access="hasAnyRole('Admin','Head')">
            <li class="active">
                <a href="<%=request.getContextPath()%>/PartnerDashboard"> <span class="icon"> <i
                        class="fa fa-users"></i> </span>
                    Dashboard</a>
            </li>
            </sec:authorize>

            <sec:authorize access="hasAnyRole('Member')">
                <li>
                    <a href="<%=request.getContextPath()%>/MemberDashboard"> <span class="icon"> <i
                            class="fa fa-users"></i> </span>
                        Member Dashboard</a>
                </li>
                <%--<li>--%>
                    <%--<a href="<%=request.getContextPath()%>/myProfile">--%>
                        <%--<span class="icon"> <i class="glyphicon glyphicon-user"></i></span>--%>
                            <%--My Account</a>--%>
                <%--</li>--%>
                <li>
                    <a href="<%=request.getContextPath()%>/ContactUs">
                        <span class="icon"><i class="fa fa-phone"></i></span>
                            Contact Us</a>
                </li>
            </sec:authorize>

            <sec:authorize access="hasAnyRole('Admin','Staff')">
                <li>
                    <a href="<%=request.getContextPath()%>/CollectionHistory"> <span class="icon"> <i
                            class="fa fa-child"></i> </span>
                        My Collection</a>
                </li>
            </sec:authorize>

            <sec:authorize access="hasAnyRole('Admin','Head','Staff')">
            <li>
                <a href="<%=request.getContextPath()%>/GroupList"> <span class="icon"> <i
                        class="fa fa-users"></i> </span>
                    Peer Finance Groups</a>
            </li>
            <li>
                <a href="<%=request.getContextPath()%>/AddUserMember"> <span class="icon"> <i
                        class="fa fa-users"></i> </span>
                    Add Users/Members</a>
            </li>
            <sec:authorize access="hasAnyRole('Admin','Head','Staff')">
                <li>
                    <a href="<%=request.getContextPath()%>/CollectPayment"> <span class="icon"> <i
                            class="fa fa-credit-card"></i> </span>
                        Collect Payment</a>
                </li>
            </sec:authorize>
            <li>
                <a href="<%=request.getContextPath()%>/AuctionReport">
                    <span class="icon">
                        <i class="fa fa-gavel"></i>
                    </span>
                    Auction</a>
            </li>


            <li>
                <a href="<%=request.getContextPath()%>/TransactionDetail"> <span class="icon"> <i class="fa fa-exchange"></i> </span>
                    Transactions</a>
            </li>

            <li>
                <a href="<%=request.getContextPath()%>/ReportsList"> <span class="icon"> <i class="fa fa-book"></i> </span>
                    Transactions</a>
            </li>


            </sec:authorize>


            <sec:authorize access="hasAnyRole('Admin','Head')">
                <li>
                    <a class="collapsed" href="#manage-company" data-toggle="collapse" data-parent="#sidebar"> <span
                            class="icon"> <i class="fa fa-university"></i> </span>
                        Manage Company<i class="toggle fa fa-angle-down"></i> </a>

                    <ul id="manage-company" class="collapse">
                        <li>
                            <a href="<%=request.getContextPath()%>/AddBranch">
                    <span class="icon">
                        <i class="glyphicon glyphicon-globe"></i>
                    </span>
                                Add Branch</a>
                        </li>
                        <li>
                            <a href="<%=request.getContextPath()%>/AddStaffForCompany">
                                <span class="icon"> <i class="fa fa-briefcase"></i> </span>
                                Add Staff</a>
                        </li>
                    </ul>
                </li>
            </sec:authorize>
            <sec:authorize access="hasAnyRole('Admin','Head','Staff')">
                <li>
                    <a class="collapsed" href="#applicants" data-toggle="collapse" data-parent="#sidebar"> <span
                            class="icon"> <i class="fa fa-circle-o-notch"></i> </span>
                        Applicants<i class="toggle fa fa-angle-down"></i> </a>

                    <ul id="applicants" class="collapse">
                        <li>
                            <a href="<%=request.getContextPath()%>/RegistrationForm" data-no-pjax>
                            <span class="icon">
                                <i class="glyphicon glyphicon-list-alt"></i>
                            </span>
                                Registration Form</a>
                        </li>
                        <li>
                            <a href="<%=request.getContextPath()%>/NewApplicantsList">
                        <span class="icon">
                            <i class="glyphicon glyphicon-list-alt"></i>
                        </span>
                                New Applications
                            </a>
                        </li>
                        <li>
                            <a href="<%=request.getContextPath()%>/ApprovedApplicantsList">
                                <span class="icon"> <i class="glyphicon glyphicon-user"></i> </span>
                                Approved Applicants</a>
                         </li>
                        <li>
                            <a class="collapsed" href="#documents" data-toggle="collapse" data-parent="#applicants"> <span
                                    class="icon"> <i class="fa fa-database"></i> </span>
                                Documents<i class="toggle fa fa-angle-down"></i> </a>

                            <ul id="documents" class="collapse">
                                <li>
                                    <a href="<%=request.getContextPath()%>/UploadDocumentsPage">
                                        <span class="icon"><i class="glyphicon glyphicon-collapse-up"></i></span>
                                        Upload Documents
                                    </a>
                                </li>
                                <li>
                                    <a href="<%=request.getContextPath()%>/UploadDocumentsPage">
                                        <span class="icon"> <i class="glyphicon glyphicon-collapse-down"></i> </span>
                                        View/Download Documents</a>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </li>

                </sec:authorize>
                <sec:authorize access="hasAnyRole('Admin')">
                <li>
                <a class="collapsed" href="#sidebar-dashboard" data-toggle="collapse" data-parent="#sidebar"> <span
                        class="icon"> <i class="fa fa-university"></i> </span>
                    Admin Console<i class="toggle fa fa-angle-down"></i> </a>

                <ul id="sidebar-dashboard" class="collapse">
                    <li>
                        <a href="<%=request.getContextPath()%>/AddCompany">
                    <span class="icon">
                        <i class="fa fa-building"></i>
                    </span>
                            Add Company</a>
                    </li>
                    <li>
                        <a href="<%=request.getContextPath()%>/ChangeCompany"> <span class="icon"> <i class="fa fa-cogs"></i> </span>
                            Change Company</a>
                    </li>
                </ul>
            </li>
            </sec:authorize>


        </ul>
        <!-- some styled links in sidebar. ready to use as links to email folders, projects, groups, etc -->
        <!-- A place for sidebar notifications & alerts -->
        <div class="sidebar-alerts" style="display: block;">
        </div>
    </div>
</nav>


<!-- This is the white navigation bar seen on the top. A bit enhanced BS navbar. See .page-controls in _base.scss. -->
<nav class="page-controls navbar navbar-default">
    <div class="container-fluid">
        <!-- .navbar-header contains links seen on xs & sm screens -->
        <div class="navbar-header">
            <ul class="nav navbar-nav">
                <li>
                    <!-- whether to automatically collapse sidebar on mouseleave. If activated acts more like usual admin templates -->
                    <%--<a class="hidden-sm hidden-xs" id="nav-state-toggle" href="#" &lt;%&ndash;title="Turn on/off sidebar collapsing"--%>
                       <%--data-placement="bottom"> <i class="fa fa-bars fa-lg"></i> </a>--%>
                    <!-- shown on xs & sm screen. collapses and expands navigation -->
                    <a class="visible-sm visible-xs" id="nav-collapse-toggle" href="#" title="Show/hide sidebar"
                       data-placement="bottom"> <span class="rounded rounded-lg visible-xs" ><i
                            class="fa fa-bars fa-lg" style="padding-top: 10px;"></i></span> <i class="fa fa-bars fa-lg hidden-xs" ></i> </a>
                </li>
                <%--<li class="ml-sm mr-n-xs hidden-xs">
                    <a href="#"><i class="fa fa-refresh fa-lg"></i></a>
                </li>
                <li class="ml-n-xs hidden-xs">
                    <a href="#"><i class="fa fa-times fa-lg"></i></a>
                </li>--%>
            </ul>
            <ul class="nav navbar-nav navbar-right visible-xs">
                <li>
                    <!-- toggles chat -->
                    <%--<a href="#" data-toggle="chat-sidebar"> <span class="rounded rounded-lg bg-gray text-white"><i
                            class="fa fa-globe fa-lg"></i></span> </a>--%>
                </li>
            </ul>
            <!-- xs & sm screen logo -->
            <a class="navbar-brand visible-xs" href="#"> <i class="fa fa-circle text-gray mr-n-sm"></i> <i
                    class="fa fa-circle text-warning"></i>
                &nbsp;
                Pareto
                &nbsp;
                <i class="fa fa-circle text-warning mr-n-sm"></i> <i class="fa fa-circle text-gray"></i> </a>
        </div>
        <!-- this part is hidden for xs screens -->
        <div class="collapse navbar-collapse">
            <!-- search form! link it to your search server -->
            <%--<form class="navbar-form navbar-left" role="search">
                <div class="form-group">
                    <div class="input-group input-group-no-border">
                        <span class="input-group-addon"> <i class="fa fa-search"></i> </span>
                        <input class="form-control" type="text" placeholder="Search Dashboard">
                    </div>
                </div>
            </form>--%>
            <%--Instead using it for showing company's name--%>
            <% Company company = (Company) session.getAttribute("company"); %>
            <%--<strong>--%>
                <%--<%=(company != null?company.getCompanyName():"")%></strong>--%>
            <ul class="nav navbar-nav navbar-right">
                <li>
                    <a href="#" class="dropdown-toggle" id="notifications-dropdown-toggle" data-toggle="dropdown"> <span
                            class="thumb-sm avatar pull-left"> <img src class="profile img-circle"
                                                                    data-name="<%=loginUser.getFullName()%>"
                                                                    alt="..."/> </span>
                        &nbsp;
                        <%=(loginUser != null?loginUser.getFullName():"")%></a>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"> <i class="fa fa-caret-down"></i> </a>
                    <ul class="dropdown-menu">
                        <%--<li>--%>
                            <%--<a href="<%=request.getContextPath()+"/myProfile"%>"><i class="glyphicon glyphicon-user"></i> &nbsp; My Account</a>--%>
                        <%--</li>--%>
                        <li>
                            <a href="<%=request.getContextPath()+"/ContactUs"%>"><i class="fa fa-phone"></i> &nbsp; Contact Us</a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="<%=request.getContextPath()+"/SignOut"%>"><i class="fa fa-sign-out"></i> &nbsp; Log Out</a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

