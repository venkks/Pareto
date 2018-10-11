package it.upspring.laabam.dao;

import it.upspring.laabam.domain.Member;
import it.upspring.laabam.rowmapper.MemberMapper;
import org.apache.poi.poifs.nio.DataSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.*;

/**
 * Created by sri on 24/10/15.
 */
@Repository
public class MemberDaoImpl implements MemberDao {

    private static final Logger logger = LoggerFactory.getLogger(GroupDaoImpl.class);

    @Autowired(required = false)
    private NamedParameterJdbcTemplate jdbcTemplate;


    public void setJdbcTemplate(NamedParameterJdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }


    @Override
    public boolean createNewMember(int userId, int groupId, int createdBy) {
        int result = 0;
        try {
            System.out.println("Entered");

            String insertMemberSql = "INSERT INTO members (group_id, user_id, createdby, deleted)" +
                    " VALUES (:groupId, :userId, :createdBy, :deleted)";

            Map<String, Object> memberParameters = new HashMap<String, Object>();
            memberParameters.put("groupId", groupId);
            memberParameters.put("userId", userId);
            memberParameters.put("createdBy", createdBy);
            memberParameters.put("deleted", false);

            result = jdbcTemplate.update(insertMemberSql, memberParameters);

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e);
        }
        return (result > 0) ? true : false;
    }

    public int createNewMemberReturnId(final int userId, final int memberBranchId, final int groupId, final int createdBy) {
        final String INSERT_SQL = "INSERT INTO members (group_id, user_id, branch_id, createdby, deleted)" +
                " VALUES (?,?,?,?,?)";
        KeyHolder keyHolder = new GeneratedKeyHolder();

        jdbcTemplate.getJdbcOperations().update(
                new PreparedStatementCreator() {
                    public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {
                        PreparedStatement ps = connection.prepareStatement(INSERT_SQL, new String[] {"id"});
                        ps.setString(1, String.valueOf(groupId));
                        ps.setString(2, String.valueOf(userId));
                        ps.setString(3, String.valueOf(memberBranchId));
                        ps.setString(4, String.valueOf(createdBy));
                        ps.setString(5,"0");
                        return ps;
                    }
                }, keyHolder);

        return keyHolder.getKey().intValue();
    }




    @Override
    public boolean checkMember(int userId, int groupId) {
        List<Member> memberList = null;
        try {
            String checkMemberUserSql = "SELECT * FROM members  WHERE user_id = :userId AND group_id = :groupId and deleted = 0";

            Map<String, Object> checkMemberParameters = new HashMap<String, Object>();

            checkMemberParameters.put("userId", userId);
            checkMemberParameters.put("groupId", groupId);
            memberList = jdbcTemplate.query(checkMemberUserSql, checkMemberParameters, new MemberMapper());

            if (memberList.isEmpty()) {
                return false;
            }

        } catch (Exception e) {
            logger.info("Exception in check member");
        }
        return true;
    }

    @Override
    public List<Member> getMemberListbyGroupId(int groupId) {

        List<Member> memberList = null;
        try {
            String memberListSql = "SELECT * FROM members  WHERE group_id = :groupId and deleted = 0";

            Map<String, Object> parameters = new HashMap<String, Object>();
            parameters.put("groupId", groupId);
            memberList = jdbcTemplate.query(memberListSql, parameters, new MemberMapper());
        } catch (Exception e) {
            e.printStackTrace();
        }

        return memberList;
    }

    @Override
    public Member getMemberByUserIDAndGroupId(int userId, int groupId) {
        Member member = null;
        try{
            String getMemberSql = "Select * from members where user_id = :userId and group_id = :groupId and deleted = 0";

            Map<String, Object> parameters = new HashMap<String, Object>();
            parameters.put("userId", userId);
            parameters.put("groupId", groupId);

            member = jdbcTemplate.queryForObject(getMemberSql, parameters, new MemberMapper());

        }catch(Exception e){
            e.printStackTrace();
        }
        return member;
    }



    @Override
    public boolean deactivateMember(int memberId) {
        int result = 0;
        try{
            String deactivateMemberSQL = "update members set deleted=1 where id=:memberId";

            Map<String, Object> parameters = new HashMap<String, Object>();
            parameters.put("memberId", memberId);

            result = jdbcTemplate.update(deactivateMemberSQL, parameters);

        }catch(Exception e){
            e.printStackTrace();
        }
        return (result>0)?true:false;
    }
}
