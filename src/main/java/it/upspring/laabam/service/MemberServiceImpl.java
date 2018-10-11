package it.upspring.laabam.service;

import com.sun.xml.internal.ws.api.pipe.FiberContextSwitchInterceptor;
import it.upspring.laabam.dao.MemberDaoImpl;
import it.upspring.laabam.dao.UserDaoImpl;
import it.upspring.laabam.domain.Branch;
import it.upspring.laabam.domain.Member;
import it.upspring.laabam.domain.User;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayInputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by sri on 24/10/15.
 */
@Service
public class MemberServiceImpl implements MemberService {
    @Autowired(required = true)
    private MemberDaoImpl memberDao;

    @Autowired(required = true)
    private UserDaoImpl userDao;

    @Autowired
    private BranchService branchService;

    DateFormat format = new SimpleDateFormat("yyyy-MM-dd");

    @Override
    public boolean checkMember(int userId, int groupId) {
        return checkMember(userId, groupId);
    }

    @Override
    public boolean createNewMember(User user, int groupId, int createdBy) {
        boolean memberFlag = false;
        boolean checkMemberFlag = false;
        User userForId;

        String userName = null;
        String mobileNo = null;

        if (user.getContact() != null) {
            mobileNo = user.getContact();
        }

        if (user.getFullName() != null) {
            userName = user.getFullName();
        }
        System.out.println(mobileNo);
        userForId = userDao.getUserDetailsByPhoneandName(mobileNo, userName);
        // userForId = userDao.getUserDetailsByPhone(mobileNo);

        if (userForId != null) {
//            checkMemberFlag = memberDao.checkMember(userForId.getUserId(), groupId);
//            Added conditon to allow multiple users being entered into same group.
            checkMemberFlag = false;
        }
        if (userForId != null) {
            System.out.println(userForId.toString());
        }
        if (!checkMemberFlag) {
            memberFlag = memberDao.createNewMember(userForId.getUserId(), groupId, createdBy);
        }
        System.out.println("Sent to memberDao" + userForId.getUserId() + groupId + createdBy + memberFlag);
        return memberFlag;
    }

    @Override
    public Member getMemberByUserIDAndGroupId(int userId, int groupId) {
        return memberDao.getMemberByUserIDAndGroupId(userId, groupId);
    }

    @Override
    public int createNewMemberReturnId(final int userId, final int memberBranchId, final int groupId, final int createdBy) {
        return memberDao.createNewMemberReturnId(userId, memberBranchId, groupId, createdBy);
    }

    @Override
    public boolean deactivateMember(int memberId) {
        return memberDao.deactivateMember(memberId);
    }


    /*
    function checkExcelSheet : checks the excel sheet for sanity.
    Returns a HashMap with following keys:
     - errorList - A list of errors found.
     - userFromSheet - A list of users, only if no errors are found.
     - openBalanceList - A list containing openBalanceList, only if no errors are found.
     */
    @Override
    public Map<String, Object> checkExcelSheet(MultipartFile file, int companyId) {

        Map<String, Object> resultMap = new HashMap<String, Object>();
        List<User> userList = new ArrayList<User>();
        List<Integer> openBalanceList = new ArrayList<Integer>();
        List<String> errorList = new ArrayList<String>();
        byte[] bytes = new byte[0];


        Workbook workbook;

        try {
            bytes = file.getBytes();
            ByteArrayInputStream bis = new ByteArrayInputStream(bytes);
            workbook = new HSSFWorkbook(bis);

            Sheet sheet = workbook.getSheetAt(0);

            System.out.println("sheet"+sheet.getSheetName());


            Row row;
            for (int rowNum = 1; rowNum <= sheet.getLastRowNum(); rowNum++) {
                row = sheet.getRow(rowNum);
                System.out.println("data"+row.getCell(0));
                System.out.println("size"+row.getLastCellNum());
                if (row.getCell(0) != null && !String.valueOf(row.getCell(0)).equals("")) {
                    User userFromSheet = new User();

//                Null value check
                    for (int colNum = 0; colNum < 17; colNum++) {
                        if (String.valueOf(row.getCell(colNum)).isEmpty()) {
                            System.out.println("error list"+row.getCell(colNum).getStringCellValue());
                            errorList.add("Null value found in row " + (rowNum+1) + " and column " + colNum + ".");
                        }
                    }
                    System.out.println("error size"+errorList.size());

                    if (errorList.size() == 0) {
                        System.out.println(row.getCell(1).getStringCellValue());
                        userFromSheet.setTitle(row.getCell(0).getStringCellValue());
                        userFromSheet.setFullName(row.getCell(1).getStringCellValue());
                        userFromSheet.setEmailId(row.getCell(2).getStringCellValue());
                      //  System.out.println(row.getCell(15).getStringCellValue());
                        userFromSheet.setUserName(row.getCell(16).getStringCellValue());

                        if (row.getCell(3).getCellType() == 0) {
                            userFromSheet.setContact(String.valueOf((long) row.getCell(3).getNumericCellValue()));
                        } else if (row.getCell(3).getCellType() == 1) {
                            userFromSheet.setContact(row.getCell(3).getStringCellValue());
                        }
                        userFromSheet.setDob(format.format(row.getCell(4).getDateCellValue()));
                        userFromSheet.setAadharNo(row.getCell(5).getStringCellValue());
                        System.out.println("cell type" +row.getCell(6).getCellType());
                        if (row.getCell(6).getCellType() == 0) {
                            userFromSheet.setPassword(String.valueOf((long) row.getCell(6).getNumericCellValue()));
                        } else if (row.getCell(6).getCellType() == 1) {
                            userFromSheet.setPassword(row.getCell(6).getStringCellValue());
                        }

                        String branchName = row.getCell(7).getStringCellValue();
                        System.out.println(branchName + " companyId " + companyId);
                        Branch branch = branchService.getBranchFromNameAndCompany(branchName, companyId);
                        System.out.println(branchName + " " + companyId);
                        if (branch != null) {
                            int branchId = branch.getBranchId();
                            userFromSheet.setBranchId(branchId);
                        } else {
                            errorList.add("Branch Name not valid for row " + (rowNum+1) + ".");
                        }

                        userFromSheet.setStreet(row.getCell(8).getStringCellValue());
                        userFromSheet.setPlace(row.getCell(9).getStringCellValue());
                        userFromSheet.setCity(row.getCell(10).getStringCellValue());
                        userFromSheet.setState(row.getCell(11).getStringCellValue());
                        userFromSheet.setCountry(row.getCell(12).getStringCellValue());
                        userFromSheet.setZipCode(String.valueOf(row.getCell(13).getNumericCellValue()));
                        userFromSheet.setRoleId((int) row.getCell(14).getNumericCellValue());
                        openBalanceList.add((int) row.getCell(15).getNumericCellValue());
                        userFromSheet.setUserName( row.getCell(16).getStringCellValue());

                        System.out.println("1...."+userFromSheet.getEmailId());
                        System.out.println("1...."+userFromSheet.getUserName());
                        userList.add(userFromSheet);
                    }
                    resultMap.put("errorList", errorList);
                    resultMap.put("userList", userList);
                    resultMap.put("openBalanceList", openBalanceList);
                }


            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return resultMap;

    }

    @Override
    public List<Member> getMembersByGroupId(int groupId) {
        return memberDao.getMemberListbyGroupId(groupId);
    }
}