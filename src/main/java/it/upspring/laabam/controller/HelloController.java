package it.upspring.laabam.controller;

    import it.upspring.laabam.domain.*;
    import it.upspring.laabam.service.*;
    //import it.upspring.laabam.utils.SmsUtil;
    import it.upspring.laabam.utils.S3Util;
    import org.codehaus.jettison.json.JSONArray;
    import org.codehaus.jettison.json.JSONObject;
    import org.slf4j.Logger;
    import org.slf4j.LoggerFactory;
    import org.springframework.beans.factory.annotation.Autowired;
    import org.springframework.stereotype.Controller;
    import org.springframework.ui.Model;
    import org.springframework.web.bind.annotation.*;
    import org.springframework.web.multipart.MultipartFile;

    import javax.servlet.http.HttpServletRequest;
    import javax.servlet.http.HttpServletResponse;
    import javax.servlet.http.HttpSession;
    import java.text.DateFormat;
    import java.text.SimpleDateFormat;
    import java.util.*;

@Controller
public class HelloController {

    private static final Logger logger = LoggerFactory.getLogger(HelloController.class);
    DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
    //SmsUtil smsUtil = new SmsUtil();
    S3Util s3Util = new S3Util();
    @Autowired(required = false)
    private GroupService groupService;
    @Autowired(required = false)
    private UserService userService;
    @Autowired(required = false)
    private MemberService memberService;
    @Autowired(required = false)
    private CompanyService companyService;
    @Autowired(required = false)
    private TransactionService transactionService;
    @Autowired(required = false)
    private BranchService branchService;
    @Autowired(required = false)
    private AuctionService auctionService;
    @Autowired(required = false)
    private EmployeeService employeeService;
    @Autowired(required = false)
    private AuctionDetailsService auctionDetailsService;



    @RequestMapping(value = "/ContactUs",method= RequestMethod.GET)
    public String contactUs(){
        return "contactUs";
    }

    @RequestMapping(value = "/NewApplicantsList", method = RequestMethod.GET)
    public String getNewApplicantsList(HttpServletRequest request, HttpServletResponse response) {

        return "newApplicantsList";
    }

    @RequestMapping(value = "/NewApplicantDetails", method = RequestMethod.GET)
    public String getNewApplicantDetails(HttpServletRequest request, HttpServletResponse response) {

        return "newApplicantDetails";
    }

    @RequestMapping(value = "/newApplication", method = RequestMethod.GET)
    public String getNewApplication(HttpServletRequest request, HttpServletResponse response) {

        return "newApplication";
    }

    @RequestMapping(value = "/ApprovedApplicantsList", method = RequestMethod.GET)
    public String getApprovedApplicantsList(HttpServletRequest request, HttpServletResponse response) {

        return "approvedApplicantsList";

    }

    @RequestMapping(value = "/ApprovedApplicantDetails", method = RequestMethod.GET)
    public String getApprovedApplicantDetails(HttpServletRequest request, HttpServletResponse response) {

        return "approvedApplicantDetails";
    }

    @RequestMapping(value = "/UploadDocumentsPage", method = RequestMethod.GET)
    public String uploadDocumentsPage(HttpServletRequest request, HttpServletResponse response) {

        return "uploadDocuments";
    }

    @RequestMapping(value = "/UploadDocumentsRequest", method = RequestMethod.POST)
    public String uploadDocumentsRequest(HttpServletRequest request, HttpServletResponse response,
                                         @RequestParam(value="file", required = false) MultipartFile multipartFile) {
        System.out.println(multipartFile.getOriginalFilename());
        s3Util.UploadObjectSingleOperation(multipartFile);

//        Steps to save a file.
//        1. Use the context to give an appropriate name to the file.
//        2. Save filename in the database.
//        2. While accessing the resource, use S3 API to load the resource.

        return "redirect:PartnerDashboard";
    }

    @RequestMapping(value = "/RegistrationForm", method = RequestMethod.GET)
    public String registrationForm(HttpServletRequest request, HttpServletResponse response){
        return "registrationForm";
    }




    @RequestMapping(value = "/SwitchMembers",method= RequestMethod.GET)
    public String switchMembers(HttpSession session, Model model
    ){

        Company company = (Company) session.getAttribute("company");
        List<Branch> branchList = branchService.getBranches(company.getCompanyId());
        model.addAttribute("branchList",branchList);
        return "switchMembers";
    }

    @RequestMapping(value = "/SwitchMembers",method= RequestMethod.POST)
    public String switchMembersPost(HttpServletRequest request, HttpServletResponse response, HttpSession session,
                                Model model,
                                @RequestParam(value="groupId", required = true) Integer groupId,
                                @RequestParam(value="outgoingMemberId", required = true) Integer outgoingMemberId,
                                @RequestParam(value="incomingUserName", required = true) String incomingUserName,
                                @RequestParam(value="incomingUserPhone", required = true) String incomingUserPhone

    ){
//        1. Copy all non-payments transactions from member A to B. Deactivate all previous transactions.
//        2. Show final refund amount on member A's page. Show "switched" on member page.
//        3. Change deleted attribute of A to 1.

        User loginUser = (User) session.getAttribute("loginUser");
        User user = userService.getUserDetailsByPhoneandName(incomingUserPhone,incomingUserName);
        Group group = groupService.getGroupByGroupId(groupId);
        int incomingMemberId = memberService.createNewMemberReturnId(user.getUserId(), group.getBranchId(),groupId,loginUser.getUserId());

        transactionService.copyTransactionsForSwitch(outgoingMemberId,incomingMemberId);
        transactionService.deleteOldTransactions(outgoingMemberId);
        memberService.deactivateMember(outgoingMemberId);

        return "redirect:GroupDetail?GroupId="+groupId;
    }

    @RequestMapping(value="/getOutgoingMemberDetails", method=RequestMethod.GET)
    public @ResponseBody String getOutgoingMemberDetails(@RequestParam(value="memberId") int memberId){
        JSONArray jsonArray = new JSONArray();
        try{
            double amountInvested = transactionService.getMemberAmountInvested(memberId);
            double dividendEarned = transactionService.getMemberDividendEarned(memberId);
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("amountInvested",amountInvested);
            jsonObject.put("dividendEarned",dividendEarned);
            jsonArray.put(jsonObject);
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return jsonArray.toString();
    }

}
