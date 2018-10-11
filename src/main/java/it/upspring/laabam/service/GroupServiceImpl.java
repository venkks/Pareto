package it.upspring.laabam.service;

import it.upspring.laabam.dao.GroupDaoImpl;
import it.upspring.laabam.dao.UserDaoImpl;
import it.upspring.laabam.domain.Group;
import it.upspring.laabam.vo.GroupDetail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by sri on 12/10/15.
 */
@Service
public class GroupServiceImpl implements GroupService {

    @Autowired(required = true)
    private GroupDaoImpl groupDao;
    @Autowired(required = true)
    private UserDaoImpl userDao;
    @Autowired(required = true)
    private MemberServiceImpl memberService;


    public void setGroupDao(GroupDaoImpl groupDao) {
        this.groupDao = groupDao;
    }

    public void setUserDao(UserDaoImpl userDao) {
        this.userDao = userDao;
    }


    @Override
    public int addGroup(final Group group) {
        return groupDao.addGroup(group);
    }

    @Override
    public List<Group> getGroupsbyBranch(int branchId, int companyId) {
        return groupDao.getGroupsbyBranch(branchId, companyId);
    }

    @Override
    public Group getGroupbyNameNBranchId(int branchId, int companyId, String groupName) {
        return groupDao.getGroupbyNameNBranchId(branchId, companyId, groupName);
    }

    @Override
    public List<GroupDetail> getGroupDetails(int entityId, String entityType){
        return groupDao.getGroupDetails(entityId,entityType);
    }

    @Override
    public List<GroupDetail> getGroupDetailsMemberDashboard(int userId){
        return groupDao.getGroupDetailsMemberDashboard(userId);
    }

    @Override
    public Group getGroupByGroupId(int groupId) {
        return groupDao.getGroupByGroupId(groupId);
    }

    @Override
    public int commenceGroup(int groupId) { return groupDao.commenceGroup(groupId); }

    @Override
    public int concludeGroup(int groupId) { return groupDao.concludeGroup(groupId); }
}
