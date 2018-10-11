package it.upspring.laabam.service;

import it.upspring.laabam.domain.Member;
import it.upspring.laabam.domain.User;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

/**
 * Created by sri on 24/10/15.
 */
public interface MemberService {
    boolean checkMember(int userId, int groupId);
    boolean createNewMember(User user, int groupId, int createdBy);
    int createNewMemberReturnId(final int userId, final int userBranchId, final int groupId, final int createdBy);
    Member getMemberByUserIDAndGroupId(int userId, int groupId);
    boolean deactivateMember(int memberId);
    Map<String,Object> checkExcelSheet(MultipartFile file, int companyId);
    List<Member> getMembersByGroupId(int groupId);

}
