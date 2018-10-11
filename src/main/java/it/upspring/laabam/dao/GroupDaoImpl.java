package it.upspring.laabam.dao;

import it.upspring.laabam.domain.Group;
import it.upspring.laabam.rowmapper.GroupMapper;
import it.upspring.laabam.vo.GroupDetail;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.ObjectFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by sri on 12/10/15.
 */
@Repository
public class GroupDaoImpl implements GroupDao {


    private static final Logger logger = LoggerFactory.getLogger(GroupDaoImpl.class);
    @Autowired(required = false)
    private NamedParameterJdbcTemplate jdbcTemplate;

    public void setJdbcTemplate(NamedParameterJdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

//    public int addGroup(Group group) {
//
//        Date date = new Date();
//        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
//        try {
//            String insertGroupSql = "INSERT INTO groups (group_name, auction_date, sms_option, group_status_id, " +
//                    " group_value, auction_frequency, company_id, branch_id, member_count)" +
//                    "VALUES (:groupName, :auctionDate, :smsOption, :groupStatusId, :groupValue," +
//                    ":auctionFrequency, :companyId, :branchId, :memberCount )";
//
//
//            Map<String, Object> parameters = new HashMap<String, Object>();
//            parameters.put("groupName", group.getGroupName());
//            parameters.put("auctionDate", group.getAuctionDate());
//            parameters.put("smsOption", group.isSmsOption());
//            parameters.put("groupStatusId", group.getGroupStatusId());
//            parameters.put("groupValue", group.getGroupValue());
//            parameters.put("auctionFrequency", group.getAuctionFrequency());
//            parameters.put("companyId", group.getCompanyId());
//            parameters.put("branchId", group.getBranchId());
//            parameters.put("memberCount",group.getMemberCount());
//            jdbcTemplate.update(insertGroupSql, parameters);
//            logger.info("Group is added");
//
//            Group addedGroup = null;
//            addedGroup = getGroupbyNameNBranchId(group.getBranchId(),group.getCompanyId(),group.getGroupName());
//            return addedGroup.getGroupId();
//
//        } catch (Exception e) {
//            logger.info("Exception in add Group");
//            e.printStackTrace();
//        }
//        return 0;
//    }



    public int addGroup(final Group group) {
        final String insertGroupSql = "INSERT INTO groups (group_name, auction_date, sms_option, group_status_id, " +
                " group_value, auction_frequency, company_id, branch_id, member_count)" +
                "VALUES (?, ?, ?, ?, ?," +
                "?, ?, ?, ?)";
        KeyHolder keyHolder = new GeneratedKeyHolder();

        jdbcTemplate.getJdbcOperations().update(
                new PreparedStatementCreator() {
                    public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {
                        PreparedStatement ps = connection.prepareStatement(insertGroupSql, new String[] {"id"});
                        ps.setString(1,String.valueOf(group.getGroupName()));
                        ps.setString(2,String.valueOf(group.getAuctionDate()));
                        ps.setBoolean(3,group.isSmsOption());
                        ps.setString(4,String.valueOf(group.getGroupStatusId()));
                        ps.setString(5,String.valueOf(group.getGroupValue()));
                        ps.setString(6,String.valueOf(group.getAuctionFrequency()));
                        ps.setString(7,String.valueOf(group.getCompanyId()));
                        ps.setString(8,String.valueOf(group.getBranchId()));
                        ps.setString(9,String.valueOf(group.getMemberCount()));
                        return ps;
                    }
                }, keyHolder);

        return keyHolder.getKey().intValue();
    }

    @Override
    public List<Group> getGroupsbyBranch(int branchId, int companyId) {
        List<Group> brachGroupList = null;
        try {
            //String getBranchGroupListSql = "SELECT * FROM laabam.group WHERE branch_id = :branchId AND company_id = :companyId";
            String getBranchGroupListSql = "select id, group_name, group_status_id,  (select count(*) from members m where m.group_id=g.id) as members from groups g where g.branch_id=  :branchId and g.company_id= :companyId and g.group_status_id in (1,2) ORDER BY g.group_value DESC";

            Map<String, Object> parameters = new HashMap<String, Object>();
            parameters.put("branchId", branchId);
            parameters.put("companyId", companyId);
//            parameters.put("groupStatusId", 2);
            brachGroupList = jdbcTemplate.query(getBranchGroupListSql, parameters, new RowMapper<Group>() {
                @Override
                public Group mapRow(ResultSet rs, int rowNum) throws SQLException {
                    Group group = new Group();

                    group.setGroupId(rs.getInt("id"));
                    group.setGroupName(rs.getString("group_name"));
                    group.setMemberCount(rs.getInt("members"));
                    group.setGroupStatusId(rs.getInt("group_status_id"));
                    return group;
                }
            });

        } catch (Exception e) {
            e.printStackTrace();
        }
        return brachGroupList;
    }

    @Override
    public Group getGroupbyNameNBranchId(int branchId, int companyId, String groupName) {
        Group group = null;
        try {
            String getGroupbyNameSql = "SELECT * FROM groups WHERE group_name = :groupName AND branch_id = :branchId AND company_id = :companyId";

            Map<String, Object> parameters = new HashMap<String, Object>();
            parameters.put("groupName", groupName);
            parameters.put("branchId", branchId);
            parameters.put("companyId", companyId);

            group = jdbcTemplate.queryForObject(getGroupbyNameSql, parameters, new GroupMapper());

        } catch (Exception e) {
            e.printStackTrace();
        }

        return group;
    }

    @Override
    public List<GroupDetail> getGroupDetails(int entityId, String entityType) {

        List<GroupDetail> groupInfo = null;
        try {
            //String getGroupDetail = "select group_id,group_name, group_value, auction_frequency, (select branch_name from branch b where b.branch_id=a.branch_id) as branch_name, (select count(*) from members c where c.group_id=a.group_id) as members from groups a";
            String getGroupDetail = null;
            Map<String, Object> parameters = new HashMap<String, Object>();

//            TODO : Write these two queries again.
            if(entityType == "company"){
                getGroupDetail = "select g.id as group_id,g.group_name," +
                        " (select gs.name from group_status gs where gs.id=g.group_status_id) as group_status," +
                        " g.group_value,g.auction_frequency,count(a.id)+1 as current_month," +
                        " date_format(ifnull(max(a.upcoming_auction_date),g.auction_date),'%D %M %Y') as next_auction_date," +
                        " (select branch_name from branch b where b.id=branch_id) as branch_name," +
                        " member_count as members," +
                        " (select sum(t.amount) from transactions t, members m where t.member_id=m.id and" +
                        " m.group_id=g.id" +
                        " and t.transaction_type_id in (1,2,3,4,8,9,10)) as outstanding_amount," +
                        " (select count(m.id) from members m where m.group_id=g.id) as current_members" +
                        " from groups g left join auction a on g.id=a.group_id" +
                        " where company_id = :companyId group by g.id  order by group_value desc;";
                parameters.put("companyId", entityId);
            }
            if(entityType == "branch"){
                getGroupDetail = "select g.id as group_id,g.group_name," +
                " (select gs.name from group_status gs where gs.id=g.group_status_id ) as group_status," +
                " g.group_value,g.auction_frequency,count(a.id)+1 as current_month," +
                        " date_format(ifnull(max(a.upcoming_auction_date),g.auction_date),'%D %M %Y') as next_auction_date," +
                " (select branch_name from branch b where b.id=branch_id) as branch_name," +
                " member_count as members," +
                " (select sum(t.amount) from transactions t, members m where t.member_id=m.id and m.group_id=g.id" +
                " and t.transaction_type_id in (1,2,3,4,8,9,10)) as outstanding_amount," +
                " (select count(m.id) from members m where m.group_id=g.id) as current_members" +
                " from groups g left join auction a on g.id=a.group_id" +
                " where branch_id = :branchId group by g.id order by group_value desc";
                parameters.put("branchId", entityId);
            }
            if(entityType == "group"){
                getGroupDetail = "select g.id as group_id,g.group_name," +
                        " (select gs.name from group_status gs where gs.id=g.group_status_id) as group_status," +
                        " g.group_value,g.auction_frequency,count(a.id)+1 as current_month," +
                        " date_format(ifnull(max(a.upcoming_auction_date),g.auction_date),'%D %M %Y') as next_auction_date," +
                        " (select branch_name from branch b where b.id=branch_id) as branch_name," +
                        " member_count as members," +
                        " (select sum(t.amount) from transactions t, members m where t.member_id=m.id and m.group_id=g.id" +
                        " and t.transaction_type_id in (1,2,3,4,8,9,10)) as outstanding_amount," +
                        " (select count(m.id) from members m where m.group_id=g.id) as current_members" +
                        " from groups g left join auction a on g.id=a.group_id" +
                        " where g.id = :groupId group by g.id order by group_value desc";
                parameters.put("groupId", entityId);
            }
            if(entityType == "member"){
                getGroupDetail = "select g.id as group_id,g.group_name," +
                        " (select gs.name from group_status gs where gs.id=g.group_status_id ) as group_status," +
                        " g.group_value,g.auction_frequency,count(a.id)+1 as current_month," +
                        " date_format(ifnull(max(a.upcoming_auction_date),g.auction_date),'%Y-%m-%d %T') as next_auction_date," +
                        " (select branch_name from branch b where b.id=branch_id) as branch_name," +
                        " member_count as members," +
                        " (select sum(t.amount) from transactions t, members m where t.member_id=m.id and m.group_id=g.id" +
                        " and t.transaction_type_id in (1,2,3,4,8,9,10)) as outstanding_amount," +
                        " (select count(m.id) from members m where m.group_id=g.id) as current_members" +
                        " from groups g left join auction a on g.id=a.group_id" +
                        " where g.id = (select group_id from members where id=:memberId) " +
                        " group by g.id order by group_value desc";
                parameters.put("memberId", entityId);
            }
            if(entityType == "user"){
                getGroupDetail = "select g.id as group_id,g.group_name," +
                        " (select gs.name from group_status gs where gs.id=g.group_status_id ) as group_status," +
                        " g.group_value,g.auction_frequency,count(a.id)+1 as current_month," +
                        " date_format(ifnull(max(a.upcoming_auction_date),g.auction_date),'%D %M %Y') as next_auction_date," +
                        " (select branch_name from branch b where b.id=branch_id) as branch_name," +
                        " member_count as members," +
                        " (select sum(t.amount) from transactions t, members m where t.member_id=m.id and m.group_id=g.id" +
                        " and t.transaction_type_id in (1,2,3,4,8,9,10)) as outstanding_amount," +
                        " (select count(m.id) from members m where m.group_id=g.id) as current_members" +
                        " from groups g left join auction a on g.id=a.group_id" +
                        " where g.id = (select group_id from members where user_id=:userId) " +
                        " group by g.id order by group_value desc";
                parameters.put("userId", entityId);
            }


            groupInfo = jdbcTemplate.query(getGroupDetail, parameters, new RowMapper<GroupDetail>() {
                @Override
                public GroupDetail mapRow(ResultSet rs, int i) throws SQLException {
                    GroupDetail groupDetail = new GroupDetail();
                    groupDetail.setGroupId(rs.getInt("group_id"));
                    groupDetail.setGroupName(rs.getString("group_name"));
                    groupDetail.setGroupStatus(rs.getString("group_status"));
                    groupDetail.setGroupValue(rs.getInt("group_value"));
                    groupDetail.setAuctionFrequency(rs.getInt("auction_frequency"));
                    groupDetail.setBranchName(rs.getString("branch_name"));
                    groupDetail.setNoOfMembers(rs.getInt("members"));
                    groupDetail.setOutstandingAmount(NumberFormat.getInstance(Locale.US).format(rs.getInt("outstanding_amount")));
                    groupDetail.setCurrentMembers(rs.getInt("current_members"));
                    groupDetail.setCurrentMonth(rs.getInt("current_month"));
                    groupDetail.setNextAuctionDate(rs.getString("next_auction_date"));
                    return groupDetail;
                }
            });
        } catch (Exception e) {
            e.printStackTrace();
        }
        return groupInfo;
    }



    @Override
    public List<GroupDetail> getGroupDetailsMemberDashboard(int userId) {

        List<GroupDetail> groupInfo = null;
        try {
            String getGroupDetail = null;
            Map<String, Object> parameters = new HashMap<String, Object>();

//            TODO : Write these two queries again.
            getGroupDetail = " select g.id as group_id,m.id as member_id,g.group_name,g.group_value,g.auction_frequency," +
                    " count(a.id) as current_month, max(a.upcoming_auction_date) as next_auction_date," +
                    " (select branch_name from branch b where b.id=g.branch_id) as branch_name," +
                    " member_count as members," +
                    " (select sum(t.amount) from transactions t, members m where t.member_id=m.id" +
                    " and m.user_id=:userId and m.group_id=g.id" +
                    " and t.transaction_type_id in (1,2,3,4,8,9,10)) as outstanding_amount" +
                    " from groups g left join auction a on g.id=a.group_id" +
                    " join members m on g.id=m.group_id and m.user_id=:userId" +
                    " and group_status_id=2 group by g.id,m.id order by group_value desc;";
            parameters.put("userId", userId);


            groupInfo = jdbcTemplate.query(getGroupDetail, parameters, new RowMapper<GroupDetail>() {
                @Override
                public GroupDetail mapRow(ResultSet rs, int i) throws SQLException {
                    GroupDetail groupDetail = new GroupDetail();
                    groupDetail.setGroupName(rs.getString("group_name"));
                    groupDetail.setGroupValue(rs.getInt("group_value"));
                    groupDetail.setBranchName(rs.getString("branch_name"));
                    groupDetail.setNoOfMembers(rs.getInt("members"));
                    groupDetail.setOutstandingAmount(NumberFormat.getInstance(Locale.US).format(rs.getInt("outstanding_amount")));
                    groupDetail.setCurrentMonth(rs.getInt("current_month"));
                    groupDetail.setNextAuctionDate(rs.getString("next_auction_date"));
                    groupDetail.setMemberId(rs.getInt("member_id"));
                    return groupDetail;
                }
            });
        } catch (Exception e) {
            e.printStackTrace();
        }
        return groupInfo;
    }




    @Override
    public Group getGroupByGroupId(int groupId) {
        Group group = null;
        try {
            String getGroupByIdSql = "select *,  (select count(*) from members m where m.group_id=g.id) as members from groups g where id = :groupId";
            Map<String, Object> parameters = new HashMap<String, Object>();
            parameters.put("groupId", groupId);
            group = jdbcTemplate.queryForObject(getGroupByIdSql, parameters,new GroupMapper());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return group;
    }

    @Override
    public int commenceGroup(int groupId){
        try{
            String commenceGroupSQL = "update groups set group_status_id=2 where id=:groupId";
            Map<String,Object> parameters = new HashMap<String,Object>();
            parameters.put("groupId",groupId);
            jdbcTemplate.update(commenceGroupSQL,parameters);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return groupId;
    }

    @Override
    public int concludeGroup(int groupId){
        try{
            String commenceGroupSQL = "update groups set group_status_id=3 where id=:groupId";
            Map<String,Object> parameters = new HashMap<String,Object>();
            parameters.put("groupId",groupId);
            jdbcTemplate.update(commenceGroupSQL,parameters);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return groupId;
    }
}
