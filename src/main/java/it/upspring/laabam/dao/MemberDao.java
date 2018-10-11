package it.upspring.laabam.dao;

import it.upspring.laabam.domain.Member;
import it.upspring.laabam.vo.GroupDetail;

import java.util.List;

/**
 * Created by sri on 24/10/15.
 */
public interface MemberDao {
    boolean createNewMember(int userId, int groupId, int createdBy);
    int createNewMemberReturnId(final int userId, final int memberBranchId, final int groupId, final int createdBy);
    boolean checkMember(int userId, int groupId);
    List<Member> getMemberListbyGroupId(int groupId);
    Member getMemberByUserIDAndGroupId(int userId, int groupId);
    boolean deactivateMember(int memberId);
}
