package it.upspring.laabam.controller;

import it.upspring.laabam.domain.Branch;
import it.upspring.laabam.domain.Company;
import it.upspring.laabam.domain.Employee;
import it.upspring.laabam.domain.User;
import it.upspring.laabam.service.*;
import it.upspring.laabam.vo.AuctionHistory;
import it.upspring.laabam.vo.GroupDetail;
import it.upspring.laabam.vo.TransactionUser;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.method.P;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.math.MathContext;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;

import static com.amazonaws.util.AWSRequestMetrics.Field.Exception;

/**
 * Created by sourabhrohilla on 4/5/16.
 */
@Controller
public class TransactionController {
    @Autowired
    private TransactionService transactionService;
    @Autowired
    private BranchService branchService;
    @Autowired
    private GroupService groupService;
    @Autowired
    private UserService userService;
    @Autowired
    private EmployeeService employeeService;
    @Autowired
    private AuctionService auctionService;
    @Autowired
    private BidDetailsService bidDetailsService;

    @RequestMapping("/GetUserTransactionWithDetail")
    public String getUserTransactionsDetail(@RequestParam(value="memberId") int memberId, Model model,
                                            HttpSession session){
        try {
            User user = null;

            user = userService.getUserByMemberId(memberId);
            User loggedInUser = (User) session.getAttribute("loginUser");


            if (user != null) {
                if(user.getFullName().equals(loggedInUser.getFullName())){
                    model.addAttribute("user", user);
                }
                else{
                    return "redirect:signInSuccessful";
                }

            } else {
                model.addAttribute("user", "No details found");
            }

            List<TransactionUser> memberTransactionForMemberId;

            memberTransactionForMemberId = transactionService.getMemberTransactions(memberId);
            double balance = transactionService.getMemberCurrentBalance(memberId);
            double amountInvested = transactionService.getMemberAmountInvested(memberId);
            double dividendEarned = transactionService.getMemberDividendEarned(memberId);
            GroupDetail groupDetail =  groupService.getGroupDetails(memberId,"member").get(0);
            List<TransactionUser> userList = userService.getUsersByGroupId(groupDetail.getGroupId());
            List<AuctionHistory> auctionHistoryList = auctionService.getAuctionHistory(memberId);
            boolean memberWonAuction = memberWonAuction(auctionHistoryList,memberId);

            TransactionUser currentBidUser = bidDetailsService.getCurrentBid(groupDetail.getGroupId(),groupDetail.getCurrentMonth());
            if(currentBidUser==null){
                currentBidUser = new TransactionUser();
                currentBidUser.setCurrentBid(groupDetail.getGroupValue());
            }


            model.addAttribute("transactionList", memberTransactionForMemberId);
            model.addAttribute("currentBalance", getCurrencyString((int) Math.ceil(-1*balance)));
            model.addAttribute("amountInvested", getCurrencyString((int) Math.ceil(amountInvested)));
            model.addAttribute("dividendEarned", getCurrencyString(((int) Math.ceil(dividendEarned))));
            model.addAttribute("subscription",getCurrencyString((int) groupDetail.getGroupValue()/groupDetail.getNoOfMembers()));
            model.addAttribute("currentMonth",groupDetail.getCurrentMonth());
            model.addAttribute("noOfMembers",groupDetail.getNoOfMembers());
            model.addAttribute("auctionProgress",groupDetail.getCurrentMonth()*100/groupDetail.getNoOfMembers());
            model.addAttribute("nextAuction",groupDetail.getNextAuctionDate());
            model.addAttribute("memberId", memberId);
            model.addAttribute("userList",userList);
            model.addAttribute("auctionHistoryList",auctionHistoryList);
            model.addAttribute("groupName",groupDetail.getGroupName());
            model.addAttribute("groupValue",(int) groupDetail.getGroupValue());
            model.addAttribute("groupValueCurrency",getCurrencyString((int) groupDetail.getGroupValue()));
            model.addAttribute("groupId",groupDetail.getGroupId());
            model.addAttribute("currentBidUser",currentBidUser);
            model.addAttribute("memberWonAuction",memberWonAuction);
            System.out.println(getCurrencyString((int) groupDetail.getGroupValue()/groupDetail.getNoOfMembers()));

            String status;
            double parsedGroupValue = groupDetail.getGroupValue();
            if(balance > 0){
                status = "Paid advance";
            }
            else if(balance == 0){
                status = "Paid";
            }
            else if(Math.abs(balance) <= parsedGroupValue){
                status = "Payment Pending";
            }
            else{
                status = "Payment Default";
            }

            model.addAttribute("status",status);

        }
        catch (Exception e){
            e.printStackTrace();
        }
        return "userSummary";
    }

    @RequestMapping(value = "/getMemberCurrentBalance", method= RequestMethod.GET)
    public @ResponseBody
    String getMemberCurrentBalance(@RequestParam(value="memberId") int memberId){
        double memberCurrentBalance = transactionService.getMemberCurrentBalance(memberId);


        JSONObject jsonObject = new JSONObject();
        try{
            jsonObject.put("memberCurrentBalance", memberCurrentBalance);
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return jsonObject.toString();
    }

    @RequestMapping(value = "/getCollectionTrend", method = RequestMethod.GET)
    public @ResponseBody String getCollectionTrend(@RequestParam(value="groupId",defaultValue = "0") int groupId,
                                                   @RequestParam(value="branchId",defaultValue = "0") int branchId){
        JSONArray collectionTrend;
        collectionTrend = transactionService.getCollectionTrend(groupId,branchId);
        return collectionTrend.toString();
    }

    @RequestMapping(value = "/GetGroupTransactionByUser", method = RequestMethod.GET)
    public
    @ResponseBody
    String GetGroupTransactionByUser(int groupId) throws Exception {
        List<TransactionUser> userTransactionForGroupId;

        JSONArray jsonArray = new JSONArray();
        userTransactionForGroupId = transactionService.getUserTransactions(groupId);

        Iterator<TransactionUser> it = userTransactionForGroupId.iterator();
        while (it.hasNext()) {
            JSONObject jsonObject = new JSONObject();
            TransactionUser transaction = it.next();
            jsonObject.put("fullName", transaction.getFullName());
            jsonObject.put("transaction_date", transaction.getTransactionDate());
            jsonObject.put("amount", NumberFormat.getNumberInstance(Locale.US).format(transaction.getAmount()));
            jsonObject.put("payment_type", transaction.getPaymentType());
            jsonObject.put("narration", transaction.getNarration());
            jsonObject.put("paymentMode", transaction.getPaymentMode());
            jsonObject.put("createdByUser", transaction.getCreatedByUserName());

            jsonArray.put(jsonObject);

        }
        return jsonArray.toString();
    }

    @RequestMapping(value = "/TransactionDetail", method = RequestMethod.GET)
    public String getUserTransaction(HttpSession session, Model model) {
        int companyId = 0;
        boolean flag;

        Company company = (Company) session.getAttribute("company");

        if (company != null) {
            companyId = company.getCompanyId();
        }
        List<Branch> branchList;
        branchList = branchService.getBranches(companyId);
        model.addAttribute("branchList", branchList);
        return "userTransaction";
    }



    @RequestMapping(value = "/CollectionHistory", method = RequestMethod.GET)
    public String getUserCollectionHistory(HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("loginUser");
        Company company = (Company) session.getAttribute("company");
        List<TransactionUser> transactionList = null;
//        When logged-in user is staff.
        if(loginUser.getRoleId()==3){
            transactionList = transactionService.getTransactionsCreatedByUser(loginUser.getUserId(),"staff");
        }
//        When logged-in user is admin or partner.
        else if (loginUser.getRoleId()==1 || loginUser.getRoleId()==2){
            System.out.println("inside controller");
            System.out.println("id."+loginUser.getUserId());
            transactionList = transactionService.getTransactionsCreatedByUser(loginUser.getUserId(),"company");
            System.out.println("trans............"+transactionList.get(0).getTitle());
        }
        else {
            transactionList = null;
        }

        Employee employee = employeeService.getEmployeeFromUserId(loginUser.getUserId());
        List<TransactionUser> pendingPayments = transactionService.getPendingPayments(employee.getBranchId());


        model.addAttribute("transactionList", transactionList);
        model.addAttribute("pendingPayments", pendingPayments);

//        TransactionUser firstTransaction = transactionList.get(0);
//        TransactionUser secondTransaction = transactionList.get(1);
//
//        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
//        double todayCashCollection = 0;
//        double todayChequeCollection = 0;
//
//        if(firstTransaction.getTransactionDate() == format.format(new Date())){
//            if(firstTransaction.getPaymentMode()=="Cash"){
//                todayCashCollection = firstTransaction.getAmount();
//            }
//            if(firstTransaction.getPaymentMode()=="Cheque"){
//                todayChequeCollection = firstTransaction.getAmount();
//            }
//        }
//        if(secondTransaction.getTransactionDate() == format.format(new Date())){
//            if(secondTransaction.getPaymentMode()=="Cash"){
//                todayCashCollection = secondTransaction.getAmount();
//            }
//            if(secondTransaction.getPaymentMode()=="Cheque"){
//                todayChequeCollection = secondTransaction.getAmount();
//            }
//        }
//
//        model.addAttribute("todayCashCollection", todayCashCollection);
//        model.addAttribute("todayChequeCollection", todayChequeCollection);

        return "collectionHistory";
    }

    private boolean checkLoggedInUser(User user,User loggedInUser){

        if(user.getFullName().equals(loggedInUser.getFullName())){
            return true;
        }
        return false;
    }

    private boolean memberWonAuction(List<AuctionHistory> auctionHistoryList, int memberId) {
        AuctionHistory auctionHistory;
        boolean memberWonAuction = false;
        for (int i = 0; i < auctionHistoryList.size(); i++) {
            auctionHistory = auctionHistoryList.get(i);
            if (memberId == auctionHistory.getAuctionWinnerMemberId()) {
                memberWonAuction = true;
            }
        }
        return memberWonAuction;
    }

    private String getCurrencyString(int currencyValue){
        return new DecimalFormat("##,##,##0").format(currencyValue).toString();
    }

}
