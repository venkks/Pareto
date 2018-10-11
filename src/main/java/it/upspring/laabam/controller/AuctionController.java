package it.upspring.laabam.controller;


import it.upspring.laabam.domain.*;
import it.upspring.laabam.service.*;
import it.upspring.laabam.vo.TransactionUser;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by sourabhrohilla on 4/5/16.
 */
@Controller
public class AuctionController {

//    TODO : Move all the logic to auction service layer.
    @Autowired
    private BranchService branchService;
    @Autowired
    private GroupService groupService;
    @Autowired
    private AuctionService auctionService;
    @Autowired
    private AuctionDetailsService auctionDetailsService;
    @Autowired
    private TransactionService transactionService;
    @Autowired
    private UserService userService;
    @Autowired
    private MemberService memberService;
    @Autowired
    private BidDetailsService bidDetailsService;


    @RequestMapping(value = "/AuctionReport", method = RequestMethod.GET)
    public String getAuctionReport(HttpSession session, Model model) {
        int companyId = 0;
        Company company = (Company) session.getAttribute("company");
        if (company != null) {
            companyId = company.getCompanyId();
        }
        List<Branch> branchList;
        branchList = branchService.getBranches(companyId);
        model.addAttribute("branchList", branchList);
        return "auctionReport";
    }


    @RequestMapping(value = "/updateBid", method = RequestMethod.POST)
    public String updateBid(HttpSession session,
                            BidDetails bidDetails) {
        boolean bidAdded = bidDetailsService.addNewBid(bidDetails);
        return "userSummary";
    }



    @RequestMapping(value = "/calculateAuctionReport", method = RequestMethod.GET)
    public
    @ResponseBody
    String calculateAuctionDetails(int kasarBalance,int groupId, float serviceTax, float commissionPercentage) {

        String result = auctionService.calculateAuctionDetails(kasarBalance,groupId,serviceTax,commissionPercentage);
        return result;

    }

    @RequestMapping(value = "/AuctionReport", method = RequestMethod.POST)
    public String addAuction(@ModelAttribute Auction auction,
                             HttpSession session, Model model,
                             @RequestParam(value= "memberId") int winningMemberId,
                             @RequestParam(value = "paymentAmount") double payment,
                             @RequestParam(value = "amount") double winnerAmount,
                             @RequestParam(value = "commissionAmount") double commission,
                             @RequestParam(value = "groupId") int groupId,
                             @RequestParam(value = "dividend") double dividend,
                             @RequestParam(value = "serviceTaxAmount") double serviceTaxAmount,
                             @RequestParam(value= "bidDetails") String bidDetails) {
        boolean flag,auctionBidFlag=false;

        User loginUser = (User) session.getAttribute("loginUser");
        flag = auctionService.addNewAuction(auction);
        int auctionId = auctionService.getNewAuction(auction);
        try {
            JSONObject jObject = new JSONObject(bidDetails);
            Iterator<?> keys = jObject.keys();
            List<AuctionDetails> auctionDetailsList = new ArrayList<AuctionDetails>();

            while( keys.hasNext() ){
                AuctionDetails auctionBidDetails = new AuctionDetails();
                String key = (String)keys.next();
                Integer value = jObject.getInt(key);
                auctionBidDetails.setMemberId(Integer.parseInt(key));
                auctionBidDetails.setAuctionId(auctionId);
                auctionBidDetails.setBiddingAmount(value);
                auctionBidDetails.setNaaration("");
                auctionDetailsList.add(auctionBidDetails);
            }

            auctionBidFlag = auctionDetailsService.addBidReport(auctionDetailsList);

        }
        catch(JSONException e){
            e.printStackTrace();
        }

        if (flag && auctionBidFlag) {
//          Auction Prize Money
            Transactions transactionAuctionPrize = new Transactions();
            transactionAuctionPrize.setTransactionTypeId(5);
            transactionAuctionPrize.setMemberId(winningMemberId);
            transactionAuctionPrize.setNarration("Auction - Prize money entry");
            transactionAuctionPrize.setAmount(winnerAmount);
            transactionAuctionPrize.setTransactionModeId(2);
            transactionAuctionPrize.setCreatedByUser(loginUser.getUserId());
            transactionService.collectPayment(transactionAuctionPrize);

//          Auction Service tax entry
            Transactions transactionServiceTax = new Transactions();
            transactionServiceTax.setTransactionTypeId(6);
            transactionServiceTax.setMemberId(winningMemberId);
            transactionServiceTax.setNarration("Auction - Service tax entry");
            transactionServiceTax.setAmount(serviceTaxAmount);
            transactionServiceTax.setTransactionModeId(2);
            transactionServiceTax.setCreatedByUser(loginUser.getUserId());
            transactionService.collectPayment(transactionServiceTax);

//           Send SMS to prize winner.

            Company company = (Company) session.getAttribute("company");
            User companyUser = userService.getUserDetailsByPhoneandName(company.getContact(),company.getCompanyName());
            Member companyMember = memberService.getMemberByUserIDAndGroupId(companyUser.getUserId(),groupId);

//          Auction commission entry
            Transactions transactionForemanCommission = new Transactions();
            transactionForemanCommission.setTransactionTypeId(7);
            transactionForemanCommission.setMemberId(companyMember.getMemberId());
            transactionForemanCommission.setNarration("Commission entry for Auction.");
            transactionForemanCommission.setAmount(commission);
            transactionForemanCommission.setTransactionModeId(2);
            transactionForemanCommission.setCreatedByUser(loginUser.getUserId());
            System.out.println("commission"+transactionForemanCommission.getAmount());
            transactionService.collectPayment(transactionForemanCommission);


            List<TransactionUser> userList = userService.getUsersByGroupId(auction.getGroupId());

            Iterator<TransactionUser> it = userList.iterator();
            while (it.hasNext()) {

                TransactionUser user = it.next();

                Transactions transactionAutoDebit = new Transactions();
                transactionAutoDebit.setTransactionTypeId(8);
                transactionAutoDebit.setMemberId(user.getMemberId());
                transactionAutoDebit.setNarration("Dividend Entry");
                transactionAutoDebit.setAmount(dividend);
                transactionAutoDebit.setTransactionModeId(2);
                transactionAutoDebit.setCreatedByUser(loginUser.getUserId());
                transactionService.collectPayment(transactionAutoDebit);

                Transactions transactionDividend = new Transactions();
                transactionDividend.setTransactionTypeId(3);
                transactionDividend.setMemberId(user.getMemberId());
                transactionDividend.setNarration("Auto Entry - Auction Reporting");
                transactionDividend.setAmount((payment + dividend) * -1);
                transactionDividend.setTransactionModeId(2);
                transactionDividend.setCreatedByUser(loginUser.getUserId());
                transactionService.collectPayment(transactionDividend);

//              Send SMS to all the members intimating about next month's installment, and this month's dividend.

            }
            model.addAttribute("success", 1);
        } else {
            model.addAttribute("success", 0);
        }

        return "redirect:AuctionReport";
    }



    @RequestMapping(value = "/concludingAuctionReport", method = RequestMethod.POST)
    public String addConcludingAuction(
            HttpSession session, Model model,
            @RequestParam(value= "memberId") int winningMemberId,
            @RequestParam(value = "concludingWinnerAmount") float winnerAmount,
            @RequestParam(value = "commissionAmount") float commission,
            @RequestParam(value = "groupId") int groupId,
            @RequestParam(value = "serviceTaxAmount") float serviceTaxAmount) {
        boolean flag;

        User loginUser = (User) session.getAttribute("loginUser");
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:MM:ss");

        Auction auction = new Auction();
        auction.setMemberId(winningMemberId);
        auction.setAmount(winnerAmount);
        auction.setAuctionDate(format.format(new Date()));
        auction.setDeleted(false);
        auction.setDividend(0);
        auction.setGroupId(groupId);
        auction.setServiceTax(serviceTaxAmount);
        flag = auctionService.addNewAuction(auction);
        if (flag) {

            Transactions transactionAuctionPrize = new Transactions();
            transactionAuctionPrize.setTransactionTypeId(5);
            transactionAuctionPrize.setMemberId(winningMemberId);
            transactionAuctionPrize.setNarration("Auction - Prize money entry");
            transactionAuctionPrize.setAmount(winnerAmount);
            transactionAuctionPrize.setTransactionModeId(2);
            transactionAuctionPrize.setCreatedByUser(loginUser.getUserId());
            transactionService.collectPayment(transactionAuctionPrize);

            Transactions transactionServiceTax = new Transactions();
            transactionServiceTax.setTransactionTypeId(6);
            transactionServiceTax.setMemberId(winningMemberId);
            transactionServiceTax.setNarration("Auction - Service tax entry");
            transactionServiceTax.setAmount(serviceTaxAmount);
            transactionServiceTax.setTransactionModeId(2);
            transactionServiceTax.setCreatedByUser(loginUser.getUserId());
            transactionService.collectPayment(transactionServiceTax);

//           Send SMS to prize winner.

            Company company = (Company) session.getAttribute("company");
            User companyUser = userService.getUserDetailsByPhoneandName(company.getContact(),company.getCompanyName());
            Member companyMember = memberService.getMemberByUserIDAndGroupId(companyUser.getUserId(),groupId);


            Transactions transactionForemanCommission = new Transactions();
            transactionForemanCommission.setTransactionTypeId(7);
            transactionForemanCommission.setMemberId(companyMember.getMemberId());
            transactionForemanCommission.setNarration("Commission entry for Auction.");
            transactionForemanCommission.setAmount(commission);
            transactionForemanCommission.setTransactionModeId(2);
            transactionForemanCommission.setCreatedByUser(loginUser.getUserId());
            transactionService.collectPayment(transactionForemanCommission);

            model.addAttribute("success", 1);
        } else {
            model.addAttribute("success", 0);
        }

        int concludedGroupId = groupService.concludeGroup(groupId);

        return "redirect:GroupList";
    }


}
