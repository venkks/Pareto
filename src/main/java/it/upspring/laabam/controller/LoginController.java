package it.upspring.laabam.controller;

import it.upspring.laabam.domain.Company;
import it.upspring.laabam.domain.User;
import it.upspring.laabam.service.CompanyService;
import it.upspring.laabam.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Created by sourabhrohilla on 4/5/16.
 */
@Controller
@Component
public class LoginController {
    @Autowired
    private UserService userService;
    @Autowired
    private CompanyService companyService;



    @RequestMapping(value = "/")
    public String homePage(HttpServletRequest request) throws Exception {
        return "login";
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String loginForm(HttpServletRequest request, HttpServletResponse response) {

        return "login";
    }


    @RequestMapping(value = "/SignOut", method = RequestMethod.GET)
    public String signOut(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
        session.invalidate();

        return "redirect:login";
    }

    @RequestMapping(value="/signInSuccessful",method = RequestMethod.GET)
    public String signInSuccessful(HttpServletRequest request, HttpSession session, Authentication authentication){

        String userName = authentication.getName();
        User loginUser = userService.getUserByUsername(userName);
        Company company = companyService.getCompanyForloginUser(loginUser);


//        For YC demo.
//        User loginUser = userService.getUserByUsername("admin@kurinji.com");
//        Company company = companyService.getCompanyForloginUser(loginUser);

        session.setAttribute("company",company);
        session.setAttribute("loginUser",loginUser);

        if(loginUser.getRoleId()<=2){
            return "redirect:PartnerDashboard";
        }
        else if(loginUser.getRoleId()==3){
            return "redirect:CollectPayment";
        }
        else if(loginUser.getRoleId()==4){

            return "redirect:MemberDashboard";
        }
        else{
            return "redirect:login";
        }

    }

}
