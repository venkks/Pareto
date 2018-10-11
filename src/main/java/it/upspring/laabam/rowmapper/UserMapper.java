package it.upspring.laabam.rowmapper;

import it.upspring.laabam.domain.User;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;


/**
 * Created by sri on 23/10/15.
 */
public class UserMapper implements RowMapper<User> {

    public User mapRow(ResultSet rs, int rowNum) throws SQLException {

        User user = new User();
        user.setUserId(rs.getInt("id"));
        user.setTitle(rs.getString("title"));
        user.setFullName(rs.getString("full_name"));
        user.setUserName(rs.getString("user_name"));
        user.setEmailId(rs.getString("email_id"));
        user.setPassword(rs.getString("password"));
        user.setContact(rs.getString("contact"));;
        user.setDeleted(rs.getBoolean("deleted"));
        user.setRoleId(rs.getInt("role_id"));
        user.setStreet(rs.getString("street"));
        user.setPlace(rs.getString("place"));
        user.setCity(rs.getString("city"));
        user.setState(rs.getString("state"));
        user.setZipCode(rs.getString("zip"));
        user.setDob(rs.getString("dob"));
        user.setCountry(rs.getString("country"));
        user.setAadharNo(rs.getString("aadhar_no"));
        user.setCreatedAt(rs.getString("created_at"));
        user.setUpdatedAt(rs.getString("updated_at"));

        return user;
    }
}
