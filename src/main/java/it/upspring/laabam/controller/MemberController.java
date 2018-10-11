package it.upspring.laabam.controller;

import it.upspring.laabam.domain.*;
import it.upspring.laabam.service.*;
import it.upspring.laabam.utils.GupShupSMS;
import it.upspring.laabam.vo.GroupDetail;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by sourabhrohilla on 4/5/16.
 */
@Controller
public class MemberController {

    @Autowired
    private GroupService groupService;
    @Autowired
    private UserService userService;
    @Autowired
    private MemberService memberService;
    @Autowired
    private BranchService branchService;
    @Autowired
    private TransactionService transactionService;

    DateFormat format = new SimpleDateFormat("yyyy-MM-dd");


    @RequestMapping(value = "/GetUserFullDetail", method = RequestMethod.GET)
    public String getUserFullDetails(@RequestParam(value="memberId") int memberId, Model model) {
        User user = null;

        user = userService.getUserByMemberId(memberId);

        if (user != null) {
            model.addAttribute("user", user);
        } else {
            model.addAttribute("user", "No details found");
        }

        return "fullDetails";
    }

    @RequestMapping(value = "/UpdateUser", method = RequestMethod.POST)
    public String updateUser(@ModelAttribute User user, Model model) {
        user.setRoleId(4);
        boolean flag = false;

        flag = userService.updateUser(user);

        if (flag) {
            model.addAttribute("Success", 1);
        } else {
            model.addAttribute("Success", 0);
        }
        return "redirect:GetUserFullDetail?memberId=" + user.getMemberId();
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

//    @RequestMapping(value = "/AddExcelUser",   method = RequestMethod.POST)
//    public @ResponseBody
//    String excelUserToUser(@RequestParam(value = "confirmExcelUser") String confirmExcelUser, HttpSession session, Model model){
//        System.out.println("*****************");
//        System.out.println(confirmExcelUser);
//
//        String userArray[] = confirmExcelUser.split(",");
//
//
//        String userId = userArray[0].substring(userArray[0].indexOf("=")+1);
//        String title = userArray[1].substring(userArray[1].indexOf("=")+1);
//        String fullName = userArray[2].substring(userArray[2].indexOf("=")+1);
//        String emailId = userArray[3].substring(userArray[3].indexOf("=")+1);
//        String street = userArray[4].substring(userArray[4].indexOf("=")+1);
//        String place = userArray[5].substring(userArray[5].indexOf("=") + 1);
//        String city = userArray[6].substring(userArray[6].indexOf("=")+1);
//        String dob = userArray[7].substring(userArray[7].indexOf("=")+1);
//        String mobileNo = userArray[8].substring(userArray[8].indexOf("=") + 1);
//        String zipCode = userArray[9].substring(userArray[9].indexOf("=")+1);
//        String state = userArray[10].substring(userArray[10].indexOf("=")+1);
//        String country = userArray[11].substring(userArray[11].indexOf("=")+1);
//        String password = userArray[12].substring(userArray[12].indexOf("=")+1);
//        String aadharNo = userArray[16].substring(userArray[16].indexOf("=")+1);
//        String strGroupId = userArray[17].substring(userArray[17].indexOf("=")+1);
//        String strOpenBalance = userArray[18].substring(userArray[18].indexOf("=")+1);
//        String result = "";
////
//        User user = new User();
//
//        user.setFullName(fullName);
//        user.setTitle(title);
//        user.setDob((dob != null || dob != "" ) ?dob : null);
//        user.setStreet(street);
//        user.setPlace(place);
//        user.setCity(city);
//        user.setState(state);
//        user.setZipCode(zipCode);
//        user.setDeleted(false);
//        user.setUpdatedAt(format.format(new Date()));
//        user.setCountry(country);
//        user.setPassword("12345");
//        user.setEmailId(emailId);
//        user.setContact(mobileNo);
//        user.setAadharNo(aadharNo);
//
//        int groupId = Integer.parseInt(strGroupId);
//        int openBalance = Integer.parseInt(strGroupId);
//
//        User loginUser = (User) session.getAttribute("loginUser");
//        int loginUserId=0;
//        boolean openBalanceFlag=false;
//
//        if(loginUser!=null){
//            loginUserId = loginUser.getUserId();
//        }
//        int memberId = memberService.createNewMemberReturnId(user.getUserId(), groupId, loginUserId);
//        if (memberId>0) {
//            openBalanceFlag = insertOpeningBalanceTransaction(memberId, openBalance, loginUserId);
//        }
//
//        if(openBalanceFlag){
//            result = "true";
//        }else{
//            result = "false";
//        }
//        return result;
//
//
//    }


    @RequestMapping(value = "/ImportData", method = RequestMethod.POST)
    public synchronized String importData(@RequestParam(value = "fileUpload") MultipartFile file, @RequestParam(value = "groupId") int groupId, HttpSession session, Model model) {

        StringBuffer success = new StringBuffer();
        Company company = (Company) session.getAttribute("company");
        int companyId = company.getCompanyId();
        boolean openBalanceFlag;
        int addedMemberCount = 0;
        int loginUserId = 0;
        Map<String, Object> checkSheetResult = new HashMap<String, Object>();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        User loginUser = (User) session.getAttribute("loginUser");
        List<User> userList = new ArrayList<User>();
        List<Integer> openBalanceList = new ArrayList<Integer>();
        List<String> errorList = new ArrayList<String>();



        if (loginUser != null) {
            loginUserId = loginUser.getUserId();
        }

            try {

                checkSheetResult = memberService.checkExcelSheet(file,companyId);


                errorList = (List<String>) checkSheetResult.get("errorList");
                userList = (List<User>) checkSheetResult.get("userList");
                openBalanceList = (List<Integer>) checkSheetResult.get("openBalanceList");

                if (errorList.size() == 0) {
                    for (int index = 0; index < userList.size(); index++) {
                        User user = userList.get(index);

                        //User checkUser = userService.getUserDetailsByPhoneandName(user.getContact(), user.getFullName());

                        System.out.println("mem cion"+index+"..."+user.getUserName());
                        User checkUser = userService.getUserDetailsByUserName(user.getContact(),user.getUserName());
                        if (checkUser != null) {
                            System.out.println("An existing user was found. Adding new member.");
                            int addedMemberId = memberService.createNewMemberReturnId(checkUser.getUserId(), user.getBranchId(), groupId, loginUserId);
                            if (addedMemberId > 0) {
                                openBalanceFlag = insertOpeningBalanceTransaction(addedMemberId, openBalanceList.get(index), loginUserId);
                            }
                        } else {
                            int addedUserId = userService.addUserReturnId(user);
                            if (addedUserId > 0) {
                                int addedMemberId = memberService.createNewMemberReturnId(addedUserId, user.getBranchId(), groupId, loginUserId);
                                if (addedMemberId > 0) {
                                    openBalanceFlag = insertOpeningBalanceTransaction(addedMemberId, openBalanceList.get(index), loginUserId);
                                }
                            }
                        }

                        addedMemberCount++;
                    }
                }
                else{
                    errorList.add("Operation failed. Please try uploading Excel sheet again.");
                    JSONObject jsonObject = new JSONObject();
                    jsonObject.put("errorList",errorList);
                    model.addAttribute("failure",jsonObject);
                    System.out.println("member controller"+jsonObject);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

        if (addedMemberCount > 0) {
            success.append(addedMemberCount + " data has been imported successfully<br>");
        }

        model.addAttribute("importSuccess", success);

        if (company != null) {
            companyId = company.getCompanyId();
        }
        List<Branch> branchList;
        branchList = branchService.getBranches(companyId);
        model.addAttribute("branchList", branchList);
        System.out.println("error"+errorList);
        System.out.println("user"+userList);
        System.out.println("balance"+openBalanceList);
        return "getUser";
    }

    @RequestMapping(value = "/AddUserMember", method = RequestMethod.GET)
    public String addMemberForm(HttpSession session, Model model) {
        int companyId = 0;
        Company company = (Company) session.getAttribute("company");

        if (company != null) {
            companyId = company.getCompanyId();
        }

        List<Branch> branchList;
        branchList = branchService.getBranches(companyId);
        System.out.println("branch....."+branchList);
        model.addAttribute("branchList", branchList);
        return "getUser";
    }

    @RequestMapping(value = "/GetUserDetails", method = RequestMethod.POST)
    public String getUserDetails(@ModelAttribute User user, HttpServletRequest request, HttpSession session, Model model) {
        int companyId = 0;

        Company company = (Company) session.getAttribute("company");

        if (company != null) {
            companyId = company.getCompanyId();
        }

        List<Branch> branchList;
        branchList = branchService.getBranches(companyId);
        model.addAttribute("branchList", branchList);

        String userName = null;
        String mobileNo = null;
        if (user.getContact() != null) {
            mobileNo = user.getContact();
        }

        if (user.getFullName() != null) {
            userName = user.getFullName();
        }

        user = userService.getUserDetailsByPhoneandName(mobileNo, userName);

        if (user != null) {
            model.addAttribute("user", user);
        } else {
            model.addAttribute("userNotFound", "No User Found!");
        }

        return "addMember";
    }


    @RequestMapping(value = "/GetUserDetails", method = RequestMethod.GET)
    public @ResponseBody String getUserDetailsFromPhone(HttpServletRequest request, HttpSession session, Model model,
                                                        @RequestParam (value="userName") String userName,
                                                        @RequestParam (value="userPhone") String userPhone
    ) {
        JSONArray jsonArray = new JSONArray();
        User user = null;
        try {
            user = userService.getUserDetailsByPhoneandName(userPhone, userName);
            JSONObject jsonObject = new JSONObject();
            if (user != null) {

                jsonObject.put("userExists",true);
            }
            else{
                jsonObject.put("userExists",false);
            }
            jsonArray.put(jsonObject);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return jsonArray.toString();
    }


    @RequestMapping(value = "/AddUserMember", method = RequestMethod.POST)
    public String addNewMember(@ModelAttribute User user,
                               @RequestParam(value = "groupId", required = false) String strGroupId,
                               @RequestParam(value = "memberLocationBranchId", required = true) int memberBranchId,
                               @RequestParam(value = "addEntityType") String addEntityType,
                               @RequestParam(value = "openBalance") int openBalance,
                               HttpSession session, Model model) {
        int loginUserId = 0;
        int groupId = 0;
        if ( strGroupId != null && strGroupId.trim().length() > 0 )
        groupId=Integer.parseInt(strGroupId);
        boolean userFlag = false, memberFlag = false, addedFlag = false, openBalanceFlag = false;
//        TODO: Replace by fixed constants (memberRole instead of 4)
        user.setRoleId(4);


        User loginUser = (User) session.getAttribute("loginUser");
        if (loginUser != null) {
            loginUserId = loginUser.getUserId();
        }

        if(addEntityType.equals("user")){
            addedFlag = userService.addUser(user);
            GupShupSMS.sendSMS("8903411674","Dear "+user.getFullName()+", welcome to Pareto. Log in to Pareto (letspareto) to start.");

        }
        else if(addEntityType.equals("member")){
            int memberId = memberService.createNewMemberReturnId(user.getUserId(),memberBranchId, groupId, loginUserId);
            if (memberId>0) {
                addedFlag = insertOpeningBalanceTransaction(memberId, openBalance,loginUserId);
                GupShupSMS.sendSMS("8903411674","user :"+user.getUserId() +" added");
            }
        }
        else if(addEntityType.equals("memberAndUser")){
            int addedUserId = userService.addUserReturnId(user);
            if (addedUserId>0) {
                int memberId = memberService.createNewMemberReturnId(addedUserId,memberBranchId, groupId, loginUserId);
                if (memberId>0) {
                    addedFlag = insertOpeningBalanceTransaction(memberId, openBalance,loginUserId);
                }
            }
        }

        if (addedFlag) {
            model.addAttribute("success", 1);
        } else {
            model.addAttribute("success", 0);
        }

        return "redirect:AddUserMember";
    }



    @RequestMapping(value = "/MemberDashboard", method = RequestMethod.GET)
    public String memberDashBoard(HttpSession session, Model model, Authentication authentication) {
        try {
            User loginUser = (User) session.getAttribute("loginUser");
            List<GroupDetail> groupList = groupService.getGroupDetailsMemberDashboard(loginUser.getUserId());
            if(groupList.size()==1){
                return "redirect:GetUserTransactionWithDetail?memberId="+groupList.get(0).getMemberId();
            }
            model.addAttribute("groupList", groupList);

        } catch (Exception e){
            e.printStackTrace();
        }
        return "memberDashboard";
    }

    @RequestMapping(value = "/myProfile", method = RequestMethod.GET)
    public String myProfile() {
        return "myProfile";
    }

}
