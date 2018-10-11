package it.upspring.laabam.service;

import it.upspring.laabam.domain.Group;
import it.upspring.laabam.vo.GroupDetail;

import java.util.List;

/**
 * Created by sri on 12/10/15.
 */
public interface GroupService {

    int addGroup(final Group group);

    List<Group> getGroupsbyBranch(int branchId, int companyId);

    Group getGroupbyNameNBranchId(int branchId, int companyId, String groupName);

    List<GroupDetail> getGroupDetails(int entityId, String entityType);

    List<GroupDetail> getGroupDetailsMemberDashboard(int userId);

    Group getGroupByGroupId(int groupId);

    int commenceGroup(int groupId);

    int concludeGroup(int groupId);

}
