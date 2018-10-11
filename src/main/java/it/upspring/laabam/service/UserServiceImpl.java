package it.upspring.laabam.service;

import it.upspring.laabam.dao.UserDaoImpl;
import it.upspring.laabam.domain.User;
import it.upspring.laabam.vo.TransactionUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by sri on 22/10/15.
 */
@Service
public class UserServiceImpl implements UserService{

    @Autowired(required=true)
    private UserDaoImpl userDao;

    public void setUserDao(UserDaoImpl userDao) {
        this.userDao = userDao;
    }

    @Override
    public boolean addUser(User user) {
        return userDao.addUser(user);
    }

    @Override
    public int addUserReturnId(final User user) {return userDao.addUserReturnId(user); }

    @Override
    public User getUserDetailsByPhoneandName(String mobileNo, String userName) {
        return userDao.getUserDetailsByPhoneandName(mobileNo, userName);
    }


    @Override
    public User getUserDetailsByUserName(String mobileNo, String userName) {
        return userDao.getUserDetailsByUserName(mobileNo, userName);
    }

    @Override
    public boolean createNewMember(User user, int groupId, String createdBy) {
        return userDao.createNewMember(user, groupId, createdBy);
    }

    @Override
    public boolean checkUserForCompany(String mobileNo) {
        return userDao.checkUserForCompany(mobileNo);
    }

    @Override
    public List<TransactionUser> getUsersByGroupId(int groupId) {
        return userDao.getUsersByGroupId(groupId);
    }


    @Override
    public User getUserByUsername(String username){
        return userDao.getUserByUsername(username);
    }


    @Override
    public User getUserByMemberId(int memberId) {
        return userDao.getUserByMemberId(memberId);
    }

    @Override
    public boolean updateUser(User user) {
        return userDao.updateUser(user);
    }
}
