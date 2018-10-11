package it.upspring.laabam.service;

import it.upspring.laabam.domain.User;
import it.upspring.laabam.vo.TransactionUser;

import java.util.List;

/**
 * Created by sri on 22/10/15.
 */
public interface UserService {

    boolean addUser(User user);
    User getUserDetailsByPhoneandName(String mobileNo, String userName);
    User getUserDetailsByUserName(String mobileNo,String userName);

    boolean createNewMember(User user, int groupId, String createdBy);
    boolean checkUserForCompany(String mobileNo);
    List<TransactionUser> getUsersByGroupId(int groupId);
    User getUserByMemberId(int memberId);
    boolean updateUser(User user);
    User getUserByUsername(String username);
    int addUserReturnId(final User user);


}
