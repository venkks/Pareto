package it.upspring.laabam.controller;


import it.upspring.laabam.domain.*;
import it.upspring.laabam.service.*;
import it.upspring.laabam.vo.GroupCollectionStats;
import it.upspring.laabam.vo.GroupDetail;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * Created by sourabhrohilla on 4/5/16.
 */
@Controller
public class GroupController {

    @Autowired
    private TransactionService transactionService;
    @Autowired
    private GroupService groupService;
    @Autowired
    private UserService userService;
    @Autowired
    private MemberService memberService;
    @Autowired
    private BranchService branchService;
    @Autowired
    private AuctionService auctionService;


    @RequestMapping(value = "/AddGroup", method = RequestMethod.GET)
    public String addGroupForm(HttpSession session, Model model) {
        int companyId = 0;

        Company company = (Company) session.getAttribute("company");

        if (company != null) {
            companyId = company.getCompanyId();
        }

        List<Branch> branchList;
        branchList = branchService.getBranches(companyId);
        model.addAttribute("branchList", branchList);

        return "addGroup";
    }

    @RequestMapping(value = "/AddGroup", method = RequestMethod.POST)
    public String createNewGroup(@ModelAttribute Group group, HttpSession session, ModelMap model) throws Exception {

        Company company = (Company) session.getAttribute("company");
        User loginUser = (User) session.getAttribute("loginUser");

        boolean openBalanceFlag = false;
        int addedMemberId = 0;

        group.setGroupStatusId(1);
        group.setCompanyId(company.getCompanyId());
        int addedgroupId = groupService.addGroup(group);

        if (addedgroupId>0){
//            TODO: Add user_id column in company's table. Get company userId from company.
            User companyUser = userService.getUserDetailsByPhoneandName(company.getContact(), company.getCompanyName());
            addedMemberId = memberService.createNewMemberReturnId(companyUser.getUserId(), group.getBranchId(),addedgroupId,loginUser.getUserId());
            if (addedMemberId>0) {
                int openBalance=group.getGroupValue()/group.getMemberCount();
                openBalanceFlag = insertOpeningBalanceTransaction(addedMemberId, openBalance,loginUser.getUserId());
            }

        }

        if (addedgroupId>0 && addedMemberId>0 && openBalanceFlag) {
            model.addAttribute("success", 1);
        } else {
            model.addAttribute("success", 0);
        }


        return "redirect:GroupDetail?GroupId="+addedgroupId;
    }


    @RequestMapping(value="/CommenceGroup", method=RequestMethod.POST)
    public String commenceGroup(@RequestParam(value="groupStatus") String groupStatus,
                      @RequestParam(value="numAuctionsHappened", required=false) String numAuctionsHappened,
                      @RequestParam(value="auctionDetails", required = false) String auctionDetails,
                      @RequestParam(value="groupId") Integer groupId
                      ){
        if(groupStatus.equals("existingGroup")){
            try{
                JSONObject jsonObject = new JSONObject(auctionDetails);
                Iterator<?> keys = jsonObject.keys();

                while(keys.hasNext()){
                    Auction auction = new Auction();
                    String key = (String)keys.next();
                    JSONObject auctionParameters = jsonObject.getJSONObject(key);
                    auction.setAuctionDate(auctionParameters.getString("auctionDate"));
                    auction.setGroupId(groupId);
                    auction.setMemberId(auctionParameters.getInt("winningMemberId"));
                    auction.setAmount(auctionParameters.getInt("winningValue"));
                    auction.setDividend(auctionParameters.getInt("dividendPaid"));
                    auction.setServiceTax(0);
                    auction.setUpcomingAuctionDate(auctionParameters.getString("upcomingAuctionDate"));

                    auctionService.addNewAuction(auction);
                    System.out.println(auction);
                }
            }
            catch(Exception e){
                e.printStackTrace();
            }
        }
        groupService.commenceGroup(groupId);
//        Send SMS to all the members.

        return "redirect:GroupDetail?GroupId="+groupId ;
    }


    @RequestMapping(value="/getGroupNameFromGroupId", method = RequestMethod.GET)
    public
    @ResponseBody
    String getGroupNameFromGroupId(int groupId) throws Exception{
        Group group = groupService.getGroupByGroupId(groupId);
        return group.getGroupName();
    }


    @RequestMapping(value = "/GroupList",method = RequestMethod.GET)
    public String getTable(HttpSession session, Model model) {
        int companyId = 0;
        int branchId=0;
        boolean flag;

        Company company = (Company) session.getAttribute("company");
        companyId = company.getCompanyId();
        List<GroupDetail> groupList = groupService.getGroupDetails(companyId,"company");
        model.addAttribute("groupList", groupList);
        return "groupTable";
    }

    @RequestMapping(value = "/GroupDetail", method = RequestMethod.GET)
    public String getMemTable(HttpSession session, Model model,
                              @RequestParam(value="GroupId") int groupId) {
        try{
            int companyId = 0;
            boolean flag;

            Company company = (Company) session.getAttribute("company");

            if (company != null) {
                companyId = company.getCompanyId();
            }
            GroupCollectionStats collectionStats = transactionService.getGroupCollectionStatus(groupId);
            JSONArray collectionTrend = transactionService.getCollectionTrend(groupId,0);
            GroupDetail groupDetail = groupService.getGroupDetails(groupId, "group").get(0);

            model.addAttribute("groupDetail", groupDetail);
            model.addAttribute("collectionTrend",collectionTrend);
            model.addAttribute("collectionStats",collectionStats);
            System.out.println(groupDetail);
        }
        catch (Exception e){
            e.printStackTrace();
        }

        return "groupDetail";
    }


    public boolean insertOpeningBalanceTransaction(int memberId, int openBalance, int loginUserId) {
        boolean flag = false;


        Transactions transactions = new Transactions();
        transactions.setMemberId(memberId);
        transactions.setAmount((openBalance > 0 )? (openBalance*-1) : openBalance );
        transactions.setTransactionTypeId(1);
        transactions.setTransactionModeId(2);
        transactions.setNarration("Opening Balance");
        transactions.setCreatedByUser(loginUserId);

        flag = transactionService.collectPayment(transactions);


        return flag;
    }

}
