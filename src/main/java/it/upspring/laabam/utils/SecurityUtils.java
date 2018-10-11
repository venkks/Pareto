package it.upspring.laabam.utils;

import it.upspring.laabam.service.UserServiceImpl;
import it.upspring.laabam.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by venkksastry on 14/11/15.
 */
public class SecurityUtils {


    private static WebApplicationContext springContext=null;

    public static boolean hasPermission(HttpServletRequest request, int role_id)
    {
//        boolean hasRole = false;
//
//        if (springContext == null )
//        springContext = WebApplicationContextUtils.getRequiredWebApplicationContext(request.getServletContext());
//
//
//        UserServiceImpl userService = (UserServiceImpl) springContext.getBean("userService");
//
//        User loginUser = (User) request.getSession().getAttribute("loginUser");
//
//
//        if (loginUser.getRoleId() <= role_id) hasRole=true;

//        return hasRole;

        return true;
    }

}
