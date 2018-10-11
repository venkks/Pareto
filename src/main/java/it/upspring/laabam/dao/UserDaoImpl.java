package it.upspring.laabam.dao;

import it.upspring.laabam.domain.Group;
import it.upspring.laabam.domain.Member;
import it.upspring.laabam.domain.User;
import it.upspring.laabam.rowmapper.UserMapper;
import it.upspring.laabam.vo.TransactionUser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringArrayPropertyEditor;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by sri on 22/10/15.
 */
@Repository
public class UserDaoImpl implements UserDao {


    private static final Logger logger = LoggerFactory.getLogger(UserDaoImpl.class);
    @Autowired(required = false)
    private NamedParameterJdbcTemplate jdbcTemplate;


    public void setJdbcTemplate(NamedParameterJdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }


    @Override
    public boolean addUser(User user) {
        int result = 0;

        try {
            String insertUserSql = "INSERT INTO users (title, full_name,user_name, email_id,  password, contact, deleted, role_id, street, place, city, state, zip, dob, country, aadhar_no) " +
                    "VALUES (:title, :fullName,:userName, :emailId, :password, :contact, :deleted, :roleId, :street, :place, :city, :state, :zip, :dob, :country, :aadharNo)";



            BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
            String hashedPassword = passwordEncoder.encode(user.getPassword());


            Map<String, Object> userParameters = new HashMap<String, Object>();

            userParameters.put("title", user.getTitle());
            userParameters.put("fullName", user.getFullName());
            userParameters.put("emailId", user.getEmailId());
            userParameters.put("userName",user.getUserName());
            userParameters.put("password", hashedPassword);
            userParameters.put("contact", user.getContact());
            userParameters.put("deleted", user.isDeleted());
            userParameters.put("roleId", user.getRoleId());
            userParameters.put("street", user.getStreet());
            userParameters.put("place", user.getPlace());
            userParameters.put("city", user.getCity());
            userParameters.put("state", user.getState());
            userParameters.put("zip", user.getZipCode());
            userParameters.put("dob", user.getDob().equals("") ? null : user.getDob());
            userParameters.put("country", user.getCountry());
            userParameters.put("aadharNo", user.getAadharNo());

            result = jdbcTemplate.update(insertUserSql, userParameters);
            logger.info("User is added");

        } catch (Exception e) {
            logger.info("Exception in add new user");
            e.printStackTrace();
        }
        return (result > 0) ? true : false;
    }


    public int addUserReturnId(final User user) {
        final String insertUserSql = "INSERT INTO users (title, full_name, user_name,email_id,  password, contact, deleted, role_id, street, place, city, state, zip, dob, country, aadhar_no) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        KeyHolder keyHolder = new GeneratedKeyHolder();

        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        final String hashedPassword = passwordEncoder.encode(user.getPassword());

        jdbcTemplate.getJdbcOperations().update(
                new PreparedStatementCreator() {
                    public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {
                        PreparedStatement ps = connection.prepareStatement(insertUserSql, new String[] {"id"});
                        ps.setString(1,String.valueOf(user.getTitle()));
                        ps.setString(2,String.valueOf(user.getFullName()));
                        ps.setString(3, String.valueOf(user.getUserName()));
                        ps.setString(4, String.valueOf(user.getEmailId()));
                        ps.setString(5,String.valueOf(hashedPassword));
                        ps.setString(6,String.valueOf(user.getContact()));
                        ps.setBoolean(7,user.isDeleted());
                        ps.setString(8,String.valueOf(user.getRoleId()));
                        ps.setString(9,String.valueOf(user.getStreet()));
                        ps.setString(10,String.valueOf(user.getPlace()));
                        ps.setString(11,String.valueOf(user.getCity()));
                        ps.setString(12,String.valueOf(user.getState()));
                        ps.setString(13,String.valueOf(user.getZipCode()));
                        ps.setString(14,String.valueOf(user.getDob()));
                        ps.setString(15,String.valueOf(user.getCountry()));
                        ps.setString(16,String.valueOf(user.getAadharNo()));

                        return ps;
                    }
                }, keyHolder);

        return keyHolder.getKey().intValue();
    }

    @Override
    public User getUserDetailsByPhoneandName(String contact, String userName) {
        User userdetails = null;

        try {
            String getUserDetailsSql = "SELECT * FROM users WHERE contact = :contact AND full_name = :userName and deleted = 0";
            Map<String, Object> parameters = new HashMap<String, Object>();
            parameters.put("contact", contact);
            parameters.put("userName", userName);

            userdetails = jdbcTemplate.queryForObject(getUserDetailsSql, parameters, new UserMapper());

        } catch (Exception e) {
//            e.printStackTrace();
            logger.info("Exception in select user");
        }
        return userdetails;
    }


    public boolean createNewMember(User user, int groupId, String createdBy) {
        int result = 0;
        User userForId = null;
        Member checkMember = null;
        try {

            String userName = null;
            String contact= null;

            if (user.getContact() != null) {
                contact = user.getContact();
            }
            if (user.getFullName() != null) {
                userName = user.getFullName();
            }

            userForId = getUserDetailsByPhoneandName(contact, userName);

            if (userForId != null) {
                String insertMemberSql = "INSERT INTO members(group_id, user_id, createdby, deleted)" +
                        " VALUES (:groupId, :userId, :createdBy, :deleted)";

                Map<String, Object> memberParameters = new HashMap<String, Object>();
                memberParameters.put("groupId", groupId);
                memberParameters.put("userId", userForId.getUserId());
                memberParameters.put("createdBy", createdBy);
                memberParameters.put("deleted", false);

                result = jdbcTemplate.update(insertMemberSql, memberParameters);
            }

        } catch (Exception e) {
            e.printStackTrace();

        }
        return (result > 0) ? true : false;
    }

    @Override
    public boolean checkUserForCompany(String contact) {

        List<User> userList;

        try {
            String getUserDetailsSql = "SELECT * FROM  users  WHERE contact = :contact AND role_id=2  and deleted = 0";
            Map<String, Object> parameters = new HashMap<String, Object>();
            parameters.put("contact", contact);

            userList = jdbcTemplate.query(getUserDetailsSql, parameters, new UserMapper());

            if (userList.isEmpty()) {
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return true;
    }

    @Override
    public List<TransactionUser> getUsersByGroupId(int groupId) {
        List<TransactionUser> userListForGroupId = null;

        try {
            String userListForGroupIdSql = "select u.id as user_id, u.full_name, u.contact,u.place,u.street,u.state,u.country," +
                    " m.id as member_id,(select sum(amount) FROM  transactions where member_id = m.id" +
                    " and transaction_type_id in (1,2,3,4,8,9,10)) as total_amount, not(isNull(a.id)) won_auction, m.deleted" +
                    " from users u, members m left join auction a on a.group_id=m.group_id and" +
                    " a.member_id = m.id where m.group_id= :groupId  and u.id=m.user_id;";

            Map<String, Object> parameters = new HashMap<String, Object>();
            parameters.put("groupId", groupId);

            userListForGroupId = jdbcTemplate.query(userListForGroupIdSql, parameters, new RowMapper<TransactionUser>() {
                @Override
                public TransactionUser mapRow(ResultSet rs, int rowNum) throws SQLException {
                    TransactionUser user = new TransactionUser();
                    user.setUserId(rs.getInt("user_id"));
                    user.setFullName(rs.getString("full_name"));
                    user.setMobileNo(rs.getString("contact"));
                    user.setPlace(rs.getString("place"));
                    user.setStreet(rs.getString("street"));
                    user.setState(rs.getString("state"));
                    user.setCountry(rs.getString("country"));
                    user.setMemberId(rs.getInt("member_id"));
                    user.setAmount(rs.getInt("total_amount"));
                    user.setWonAuction(rs.getBoolean("won_auction"));
                    user.setDeleted(rs.getBoolean("deleted"));
                    return user;
                }
            });

        } catch (Exception e) {
            e.printStackTrace();
        }
        return userListForGroupId;
    }



    @Override
    public User getUserByMemberId(int memberId) {
        User user = null;
        try {
            String getUserByMemberIdSql = "select * from users where id = (select user_id from members where id = :memberId) and deleted = 0";
            Map<String, Object> parameters = new HashMap<String, Object>();
            parameters.put("memberId", memberId);
            user = jdbcTemplate.queryForObject(getUserByMemberIdSql, parameters, new UserMapper());
//            user.setMemberId(memberId);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

    @Override
    public boolean updateUser(User user) {
        int result = 0;
        try {
            String updateUserSql = "UPDATE users  SET title = :title, full_name = :fullName, user_name=:userName, email_id = :emailId, password = :password, contact = :contact, " +
                    "deleted = :deleted, role_id = :roleId, street = :street, place = :place, city = :city, " +
                    "state = :state, zip = :zip, dob = :dob, country = :country," +
                    "aadhar_no = :aadharNo, updated_at = :updatedAt WHERE user_id = :userId";

            Map<String, Object> userParameters = new HashMap<String, Object>();

            userParameters.put("title", user.getTitle());
            userParameters.put("fullName", user.getFullName());
            userParameters.put("userName", user.getUserName());
            userParameters.put("emailId", user.getEmailId());
            userParameters.put("password", user.getPassword());
            userParameters.put("contact", user.getContact());
            userParameters.put("deleted", user.isDeleted());
            userParameters.put("roleId", user.getRoleId());
            userParameters.put("street", user.getStreet());
            userParameters.put("place", user.getPlace());
            userParameters.put("city", user.getCity());
            userParameters.put("state", user.getState());
            userParameters.put("zip", user.getZipCode());
            userParameters.put("dob", user.getDob());
            userParameters.put("country", user.getCountry());
            userParameters.put("aadharNo", user.getAadharNo());
            userParameters.put("updatedAt", new Date());

            result = jdbcTemplate.update(updateUserSql, userParameters);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return (result > 0) ? true : false;
    }

    @Override
    public User getUserDetailsByPhone(String contact) {
        User userdetails = null;

        try {
            String getUserDetailsSql = "SELECT * FROM users  WHERE contact = :contact AND full_name = :userName and deleted = 0";
            Map<String, Object> parameters = new HashMap<String, Object>();
            parameters.put("contact", contact);

            userdetails = jdbcTemplate.queryForObject(getUserDetailsSql, parameters, new UserMapper());

        } catch (Exception e) {
            e.printStackTrace();
            logger.info("Exception in select user");
        }
        return userdetails;
    }

    @Override
    public User getUserByUsername(String username){
        User user = null;
        try{
         //   String getUserByUsernameSQL = "SELECT * from users where email_id=:username and deleted=0;";
            String getUserByUsernameSQL = "SELECT * from users where user_name=:username and deleted=0;";
            Map<String,Object> parameters = new HashMap<String, Object>();
            parameters.put("username",username);
            user = jdbcTemplate.queryForObject(getUserByUsernameSQL,parameters,new UserMapper());
        } catch(Exception e) {
            e.printStackTrace();
        }
        return user;
    }



    public User getUserDetailsByUserName(String contact, String userName) {
        User userdetails = null;

        try {
            String getUserDetailsSql = "SELECT * FROM users WHERE contact = :contact AND user_name = :userName and deleted = 0";
            Map<String, Object> parameters = new HashMap<String, Object>();
            parameters.put("contact", contact);
            parameters.put("userName", userName);
System.out.println("inside dao");
            userdetails = jdbcTemplate.queryForObject(getUserDetailsSql, parameters, new UserMapper());

        } catch (Exception e) {
//            e.printStackTrace();
            logger.info("Exception in select user");
        }
        return userdetails;
    }

}
