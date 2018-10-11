package it.upspring.laabam.controller;

import it.upspring.laabam.domain.Branch;
import it.upspring.laabam.domain.Company;
import it.upspring.laabam.service.BranchService;
import it.upspring.laabam.service.GroupService;
import it.upspring.laabam.vo.GroupDetail;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by sourabhrohilla on 4/5/16.
 */
@Controller
public class PartnerDashboardController {
    @Autowired
    private GroupService groupService;
    @Autowired
    private BranchService branchService;

    @RequestMapping(value = "/PartnerDashboard", method = RequestMethod.GET)
    public String partnerDashBoard(HttpSession session, Model model, Authentication authentication) {
        try {
            int companyId = 0;

            List<Branch> branchList = null;

            Company company = (Company) session.getAttribute("company");
            companyId = company.getCompanyId();

            branchList = branchService.getBranches(companyId);

            model.addAttribute("branchList", branchList);

        } catch (Exception e){
            e.printStackTrace();
        }
        return "partnerDashboard";
    }


    @RequestMapping(value="/getGroupRowDetails", method=RequestMethod.GET)
    public @ResponseBody
    String getGroupRowDetails(@RequestParam(value="branchId") int branchId){
        int companyId=0;
        JSONArray jsonArray = new JSONArray();

        List<GroupDetail> groupDetailList = groupService.getGroupDetails(branchId,"branch");
        for(int i=0; i<groupDetailList.size(); i++){
            JSONObject jsonObject = new JSONObject();
            GroupDetail groupRow = groupDetailList.get(i);
            try{
                jsonObject.put("groupId",groupRow.getGroupId());
                jsonObject.put("groupName",groupRow.getGroupName());
                jsonObject.put("outstandingAmount",groupRow.getOutstandingAmount());
                jsonObject.put("noOfMembers",groupRow.getNoOfMembers());
                jsonObject.put("nextAuctionDate",groupRow.getNextAuctionDate());
                jsonObject.put("currentMonth",groupRow.getCurrentMonth());
                jsonObject.put("auctionProgress",groupRow.getCurrentMonth()*100/groupRow.getNoOfMembers());

                jsonArray.put(jsonObject);
            } catch (JSONException e){
                e.printStackTrace();
            }

        }
        return jsonArray.toString();

    }
}
