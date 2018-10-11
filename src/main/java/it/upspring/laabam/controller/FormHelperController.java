package it.upspring.laabam.controller;

import it.upspring.laabam.domain.Branch;
import it.upspring.laabam.domain.Company;
import it.upspring.laabam.domain.Group;
import it.upspring.laabam.service.BranchService;
import it.upspring.laabam.service.GroupService;
import it.upspring.laabam.service.UserService;
import it.upspring.laabam.vo.TransactionUser;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.text.NumberFormat;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;

/**
 * Created by sourabhrohilla on 4/5/16.
 */
@Controller
public class FormHelperController {
    @Autowired
    private GroupService groupService;
    @Autowired
    private UserService userService;
    @Autowired
    private BranchService branchService;


    @RequestMapping(value = "/GetBranchGroups", method = RequestMethod.GET)
    public
    @ResponseBody
    String getBranchGroupList(int branchId, HttpSession session) throws Exception {
        int companyId = 0;

        Company company = (Company) session.getAttribute("company");

        if (company != null) {
            companyId = company.getCompanyId();
        }
        List<Group> branchGroupList;

        JSONArray jsonArray = new JSONArray();
        branchGroupList = groupService.getGroupsbyBranch(branchId, companyId);
        Iterator<Group> it = branchGroupList.iterator();
        while (it.hasNext()) {
            JSONObject jsonObject = new JSONObject();
            Group group = it.next();
            jsonObject.put("groupName", group.getGroupName());
            jsonObject.put("groupId", group.getGroupId());
            jsonObject.put("groupMembers", group.getMemberCount());
            jsonObject.put("groupStatus",group.getGroupStatusId());
            jsonArray.put(jsonObject);
        }
        return jsonArray.toString();
    }


    @RequestMapping(value = "/GetBranchGroupsForAddingMembers", method = RequestMethod.GET)
    public
    @ResponseBody
    String GetBranchGroupsForAddingMembers(int branchId, HttpSession session) throws Exception {
        int companyId = 0;

        Company company = (Company) session.getAttribute("company");

        if (company != null) {
            companyId = company.getCompanyId();
        }
        List<Group> branchGroupList;

        JSONArray jsonArray = new JSONArray();
        branchGroupList = groupService.getGroupsbyBranch(branchId, companyId);
        Iterator<Group> it = branchGroupList.iterator();
        while (it.hasNext()) {
            JSONObject jsonObject = new JSONObject();
            Group group = it.next();
            if(group.getGroupStatusId()!=2){
                jsonObject.put("groupName", group.getGroupName());
                jsonObject.put("groupId", group.getGroupId());
                jsonObject.put("groupMembers", group.getMemberCount());
                jsonObject.put("groupStatus",group.getGroupStatusId());
                System.out.println("contr"+jsonObject);
                jsonArray.put(jsonObject);
            }

        }
        return jsonArray.toString();
    }

    @RequestMapping(value = "/GetMembersByGroupId", method = RequestMethod.GET)
    public
    @ResponseBody
//    Can make separate function for dropdown requirements (just memberId,fullName,phoneNo)
    String getMembersByGroupId(int groupId) throws Exception {
        List<TransactionUser> userListForGroupId;

        JSONArray jsonArray = new JSONArray();
        userListForGroupId = userService.getUsersByGroupId(groupId);

        Iterator<TransactionUser> it = userListForGroupId.iterator();
        while (it.hasNext()) {
            JSONObject jsonObject = new JSONObject();
            TransactionUser user = it.next();
            jsonObject.put("memberId", user.getMemberId());
            jsonObject.put("fullName", user.getFullName());
            jsonObject.put("mobileNo", user.getMobileNo());
            jsonObject.put("place", user.getPlace());
            jsonObject.put("street", user.getStreet());
            jsonObject.put("state", user.getState());
            jsonObject.put("country", user.getCountry());
            jsonObject.put("totalAmount", NumberFormat.getInstance(Locale.US).format(user.getAmount()));
            jsonObject.put("wonAuction", user.getWonAuction());
            jsonObject.put("deleted",user.getDeleted());
            jsonArray.put(jsonObject);

        }
        return jsonArray.toString();
    }


    @RequestMapping(value = "/GetAuctionMembersByGroupId", method = RequestMethod.GET)
    public
    @ResponseBody
    String getAuctionMembersByGroupId(int groupId) throws Exception {
        List<TransactionUser> userListForGroupId;

        JSONArray jsonArray = new JSONArray();
        userListForGroupId = userService.getUsersByGroupId(groupId);

        Iterator<TransactionUser> it = userListForGroupId.iterator();
        while (it.hasNext()) {
            JSONObject jsonObject = new JSONObject();
            TransactionUser user = it.next();
            if(!user.getWonAuction()){
                jsonObject.put("memberId", user.getMemberId());
                jsonObject.put("fullName", user.getFullName());
                jsonObject.put("mobileNo", user.getMobileNo());
                jsonArray.put(jsonObject);
            }
        }
        return jsonArray.toString();
    }



    @RequestMapping(value = "/GetBranchListForCompany", method = RequestMethod.GET)
    public
    @ResponseBody
    String getBranchListForCompany(int companyId) {

        List<Branch> branchList;
        branchList = branchService.getBranches(companyId);

        JSONArray jsonArray = new JSONArray();
        Iterator<Branch> it = branchList.iterator();
        while (it.hasNext()) {
            JSONObject jsonObject = new JSONObject();
            Branch branch = it.next();
            try {
                jsonObject.put("branchId", branch.getBranchId());
                jsonObject.put("branchName", branch.getBranchName());
            } catch (JSONException e) {
                e.printStackTrace();
            }
            jsonArray.put(jsonObject);
        }
        return jsonArray.toString();
    }
}
