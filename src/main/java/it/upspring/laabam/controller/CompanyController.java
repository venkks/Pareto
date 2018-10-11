package it.upspring.laabam.controller;

import it.upspring.laabam.domain.Branch;
import it.upspring.laabam.domain.Company;
import it.upspring.laabam.domain.Employee;
import it.upspring.laabam.domain.User;
import it.upspring.laabam.service.BranchService;
import it.upspring.laabam.service.CompanyService;
import it.upspring.laabam.service.EmployeeService;
import it.upspring.laabam.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by sourabhrohilla on 4/5/16.
 */
@Controller
public class CompanyController {
    @Autowired
    private CompanyService companyService;
    @Autowired
    private EmployeeService employeeService;
    @Autowired
    private UserService userService;
    @Autowired
    private BranchService branchService;


    @RequestMapping(value = "/CompanyDetails", method = RequestMethod.GET)
    public String getCompanyDetails() {
        return "companyTable";
    }

    @RequestMapping(value = "/AddCompany", method = RequestMethod.GET)
    public String getAddCompany() {
        return "addCompany";
    }

    @RequestMapping(value = "/AddCompany", method = RequestMethod.POST)
    public String addCompany(@ModelAttribute Company company, Model model) {
        boolean branchFlag = false;
        boolean checkUser;
        boolean userAddedFlag;
        Company addedCompany= null;
        boolean addCompanyFlag = false;

        User user = new User();


        if (company != null) {
            user.setFullName(company.getCompanyName());
            user.setTitle("");
            user.setDob("");
            user.setState("A");
            user.setStreet(company.getStreet());
            user.setPlace(company.getPlace());
            user.setCity(company.getCity());
            user.setState(company.getState());
            user.setZipCode(company.getZip());
            user.setDeleted(false);
            user.setCountry(company.getCountry());
            user.setPassword(company.getPassword());
            user.setEmailId(company.getEmailId());
            user.setContact(company.getContact());
            user.setRoleId(2);
        }

        checkUser = userService.checkUserForCompany(user.getContact());
        if (!checkUser){
            userAddedFlag = userService.addUser(user);
            if(userAddedFlag){
                addCompanyFlag = companyService.createCompany(company);
                if (addCompanyFlag) {
                    addedCompany = companyService.getCompanyByName(company.getCompanyName(), company.getContact());
                }
            }

        }


        if (addedCompany != null) {
            Branch branch = new Branch();

            branch.setCompanyId(addedCompany.getCompanyId());
            branch.setBranchName(company.getCity());
            branch.setContact(company.getContact());
            branch.setStreet(company.getStreet());
            branch.setAddress(company.getCity());
            branchFlag = branchService.addBranch(branch);
        }

        if (addCompanyFlag && branchFlag) {
            model.addAttribute("addSuccess", 1);
        } else {
            model.addAttribute("addSuccess", 0);
        }
        return "redirect:CompanyDetails";
    }

    @RequestMapping(value = "/AddStaffForCompany", method = RequestMethod.GET)
    public String getAddStaff(Model model, HttpSession session) {
        List<Company> companyList = new ArrayList<Company>();

        User loginUser = (User) session.getAttribute("loginUser");
        if(loginUser.getRoleId()==1){
            companyList = companyService.getAllCompany();
        }
        else{
            Company company = (Company) session.getAttribute("company");
            if(company != null){
                companyList.add(company);
            }

        }
        model.addAttribute("companyList", companyList);
        return "addStaff";
    }

    @RequestMapping(value = "/AddStaffForCompany", method = RequestMethod.POST)
    public String addStaffForCompany(@ModelAttribute User user, Model model, HttpSession session) {
        user.setPassword(user.getContact());
        boolean employeeAddedFlag=false;
        int addedUserId = userService.addUserReturnId(user);

        Company company = (Company) session.getAttribute("company");
        User loginUser = (User) session.getAttribute("loginUser");

        Employee employee = new Employee();
        employee.setCompanyId(company.getCompanyId());
        employee.setBranchId(user.getBranchId());
        employee.setUserId(addedUserId);
        employee.setCreatedBy(loginUser.getUserId());
        employee.setDesignation(user.getDesignation());
        employee.setDeleted(0);

        employeeAddedFlag = employeeService.addEmployee(employee);


        if (addedUserId>0 && employeeAddedFlag) {
            model.addAttribute("staffSuccess", 1);
        } else {
            model.addAttribute("staffSuccess", 0);
        }
        return "redirect:CompanyDetails";
    }


    @RequestMapping(value = "/ChangeCompany", method = RequestMethod.GET)
    public String changeCompany(HttpSession session, Model model) {
        int sessionCompanyId = 0;
        Company company = (Company) session.getAttribute("company");

        if (company != null) {
            sessionCompanyId = company.getCompanyId();
        }

        List<Company> companyList = null;
        companyList = companyService.getAllCompany();
        model.addAttribute("companyList", companyList);
        model.addAttribute("sessionCompanyId", sessionCompanyId);
        return "changeCompany";
    }

    @RequestMapping(value = "/ChangeCompany", method = RequestMethod.POST)
    public String changeSessionCompany(@RequestParam(value = "changeCompanyId") int changeCompanyId, HttpSession session) {

        Company newSessionCompany = null;
        newSessionCompany = companyService.getCompanyById(changeCompanyId);
        session.setAttribute("company", newSessionCompany);
        return "redirect:ChangeCompany";

    }

}
