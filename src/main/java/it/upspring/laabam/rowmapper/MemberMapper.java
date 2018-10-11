package it.upspring.laabam.rowmapper;

import it.upspring.laabam.domain.Member;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by sri on 24/10/15.
 */
public class MemberMapper implements RowMapper<Member> {

    @Override
    public Member mapRow(ResultSet rs, int rowNum) throws SQLException {

        Member member = new Member();
        member.setMemberId(rs.getInt("id"));
        member.setGroupId(rs.getInt("group_id"));
        member.setUserId(rs.getInt("user_id"));
        member.setCreatedBy(rs.getInt("createdby"));

        return member;
    }
}
