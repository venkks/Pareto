package it.upspring.laabam.controller;
//
import it.upspring.laabam.domain.*;
import it.upspring.laabam.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import it.upspring.laabam.utils.GupShupSMS;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

/**
 * Created by sourabhrohilla on 4/5/16.
 */
@Controller
public class CollectPaymentController {
    @Autowired
    private TransactionService transactionService;
    @Autowired
    private UserService userService;
    @Autowired
    private BranchService branchService;
    @Autowired
    private MemberService memberService;
    @Autowired
    private GroupService groupService;

    GupShupSMS gupShupSMS = new GupShupSMS();

    @RequestMapping(value = "/CollectPayment", method = RequestMethod.GET)
    public String paymentPage(HttpSession session, Model model) {

        int companyId = 0;

        Company company = (Company) session.getAttribute("company");

        if (company != null) {
            companyId = company.getCompanyId();
        }

        List<Branch> branchList;
        branchList = branchService.getBranches(companyId);
        model.addAttribute("branchList", branchList);

        return "collectPayment";
    }

    @RequestMapping(value = "/CollectPayment", method = RequestMethod.POST)
    public String collectPayment(@ModelAttribute Transactions transactions, HttpSession session, Model model) {

        boolean flag;
        String loginUserName = "";
        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser != null) {
            loginUserName = loginUser.getFullName();
        }

        User user = null;
        transactions.setTransactionTypeId(4);
        transactions.setTransactionStatusId(2);
        transactions.setCreatedByUser(loginUser.getUserId());
        if ( transactions.getMemberId() == -1 ) {
            // ALL members are paying.
            flag= false;
            int groupId = transactions.getGroupId();
            List<Member> members = memberService.getMembersByGroupId(groupId);
            for (Member member : members)
            {
                transactions.setMemberId(member.getMemberId());
                flag = transactionService.collectPayment(transactions);
                System.out.println(member.getMemberId() + "-> paid ->"+flag);
            }

        }
        else {
            flag = transactionService.collectPayment(transactions);
        }

        if (flag) {

            user = userService.getUserByMemberId(transactions.getMemberId());
            if (user != null) {
                String mobileNo = user.getContact();
                String newMobileNo = "";
                String content = "Dear " + user.getFullName() + ", you have paid Rs."
                        + transactions.getAmount() + "/- in Cash  to " + loginUserName + " at " + new Date();

                if(mobileNo.contains("-")){
                    newMobileNo =  mobileNo.substring(0, mobileNo.indexOf("-"));
                }else{
                    newMobileNo = mobileNo;
                }

//                gupShupSMS.sendSMS("9004553241","Dear Ram, you have paid Rs. 1000/- in cash to Shyam at Mon Nov 23 2015, 11:19:00");



            }

            model.addAttribute("success", 1);
        } else {
            model.addAttribute("success", 0);
        }

        return "redirect:CollectPayment";
    }



}
