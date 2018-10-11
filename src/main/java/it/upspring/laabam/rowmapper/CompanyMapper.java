package it.upspring.laabam.rowmapper;

import it.upspring.laabam.domain.Company;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;

/**
 * Created by sri on 19/11/15.
 */
public class CompanyMapper implements RowMapper<Company> {

    @Override
    public Company mapRow(ResultSet rs, int i) throws SQLException {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

        Company company = new Company();

        company.setCompanyId(rs.getInt("id"));
        company.setCompanyName(rs.getString("company_name"));
        company.setContact(rs.getString("contact"));
        company.setRemarks(rs.getString("remarks"));
        company.setDeleted(rs.getBoolean("deleted"));
        company.setStreet(rs.getString("street"));
        company.setPlace(rs.getString("place"));
        company.setCity(rs.getString("city"));
        company.setState(rs.getString("state"));
        company.setZip(rs.getString("zip"));
        company.setPanNo(rs.getString("pan_no"));
        company.setEmailId(rs.getString("email_id"));
        company.setCountry(rs.getString("country"));
        company.setCreatedAt(rs.getString("created_at"));
        company.setUpdatedAt(rs.getString("updated_at"));

        return company;
    }
}
