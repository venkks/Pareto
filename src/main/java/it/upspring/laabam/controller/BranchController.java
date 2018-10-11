package it.upspring.laabam.controller;

import it.upspring.laabam.domain.Branch;
import it.upspring.laabam.domain.Company;
import it.upspring.laabam.service.BranchService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;

/**
 * Created by sourabhrohilla on 4/5/16.
 */
@Controller
public class BranchController {
    @Autowired
    private BranchService branchService;

    @RequestMapping(value = "/AddBranch", method = RequestMethod.GET)
    public String addBranchPage() {
        return "addBranch";
    }

    @RequestMapping(value = "/AddBranch", method = RequestMethod.POST)
    public String addBranch(@ModelAttribute Branch branch, HttpSession session, Model model) {
        int companyId = 0;
        boolean flag;

        Company company = (Company) session.getAttribute("company");

        if (company != null) {
            companyId = company.getCompanyId();
        }

        branch.setCompanyId(companyId);
        flag = branchService.addBranch(branch);

        if (flag) {
            model.addAttribute("Success", 1);
        } else {
            model.addAttribute("Success", 0);
        }
        return "redirect:AddBranch";
    }
}
