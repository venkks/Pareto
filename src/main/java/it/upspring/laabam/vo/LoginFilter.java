//package it.upspring.laabam.utils;
//
//import it.upspring.laabam.domain.Company;
//import it.upspring.laabam.domain.User;
//import it.upspring.laabam.service.EmployeeService;
//import it.upspring.laabam.service.UserService;
//import it.upspring.laabam.service.CompanyService;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.web.context.WebApplicationContext;
//import org.springframework.web.context.support.WebApplicationContextUtils;
//
//import javax.servlet.*;
//import javax.servlet.annotation.WebFilter;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//import java.io.IOException;
//import java.text.DateFormat;
//import java.text.SimpleDateFormat;
//import java.util.Date;
//
///**
// * Created by venkksastry on 12/11/15.
// */
//@WebFilter(description= "Login and encoding filter", urlPatterns = "/*")
//public class LoginFilter implements Filter {
//
//    @Autowired(required = false)
//    UserService userService;
//    @Autowired(required = false)
//    CompanyService companyService;
//    @Autowired(required = false)
//    EmployeeService employeeService;
//
//
//
//    @Override
//    public void init(FilterConfig filterConfig) throws ServletException {
//
//
//    }
//
//    @Override
//    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
//
//        servletRequest.setCharacterEncoding("utf-8");
//        servletResponse.setCharacterEncoding("utf-8");
//
//        WebApplicationContext springContext = null;
//
//        HttpServletRequest httpRequest = (HttpServletRequest) servletRequest;
//        HttpServletResponse httpResponse = (HttpServletResponse) servletResponse;
//
//        springContext = WebApplicationContextUtils.getRequiredWebApplicationContext(httpRequest.getServletContext());
//
////        System.out.println("spring context============"+springContext);
//
////        TODO : Remove the comments.
//        userService = (UserService) springContext.getBean("userService");
//        companyService = (CompanyService) springContext.getBean("companyService");
//
//        HttpSession session = httpRequest.getSession();
//
//        User loginUser = (User) session.getAttribute("loginUser");
//
//        if (loginUser == null && httpRequest.getParameter("username") != null) {
//
//                loginUser = userService.authenticateUser(httpRequest.getParameter("username"), httpRequest.getParameter("password"));
//
//                System.out.println("Username -- " + httpRequest.getParameter("username") + ", Password:" + httpRequest.getParameter("password"));
//                System.out.println("Login User null? :" + (loginUser == null));
//
//                session.setAttribute("loginUser", loginUser);
//
////TODO : Set the appropriate company according to user ID. Remove the hard-coding.
//                Company company = new Company();
//
//                if (loginUser != null){
//                    int roleId = loginUser.getRoleId();
//
//                    if (roleId == 2) {
//                        company = companyService.getCompanyByEmailId(httpRequest.getParameter("username"));
//                    } else if (roleId == 3) {
//                        company = employeeService.getEmployeeCompany(loginUser.getUserId());
//                    }
//                    else {
//                        company.setCompanyId(1);
//                        company.setCompanyName("Karumbairam Chits");
//                        company.setMobileNo("9443131674");
//
//                        DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
//                        company.setCreateDate(format.format(new Date()));
//                    }
//                }
//
//
//                if (session.getAttribute("company") == null) {
//                    session.setAttribute("company", company);
//                }
//
//
//            }
//
////       TODO : Why this 'if' condition?
//            if (loginUser == null && (httpRequest.getRequestURI().contains("/login") || httpRequest.getRequestURI().contains("static")))
//                filterChain.doFilter(servletRequest, servletResponse);
//
//            if (loginUser == null && !httpRequest.getRequestURI().contains("/login"))
//                httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
//
//            if (loginUser != null)
//                filterChain.doFilter(servletRequest, servletResponse);
//
//
//        }
//
//    @Override
//    public void destroy() {
//
//    }
//}
