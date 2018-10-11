package it.upspring.laabam.dao;

import it.upspring.laabam.domain.Company;
import it.upspring.laabam.rowmapper.CompanyMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by sri on 26/10/15.
 */
@Repository
public class CompanyDaoImpl implements CompanyDao {

    private static final Logger logger = LoggerFactory.getLogger(GroupDaoImpl.class);
    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
    @Autowired(required = false)
    private NamedParameterJdbcTemplate jdbcTemplate;

    public void setJdbcTemplate(NamedParameterJdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public boolean createCompany(Company company) {
        int result = 0;
        try {
            String createCompanySql = "INSERT INTO company( company_name, contact, remarks, deleted," +
                    " street, place, city, state, zip, country, pan_no, email_id) VALUES(:companyName, :contact, " +
                    ":remarks, :deleted, :street, :place, :city, :state, :zip, :country, :panNo, :emailId)";

            Map<String, Object> parameters = new HashMap<String, Object>();
            parameters.put("companyName", company.getCompanyName());
            parameters.put("contact", company.getContact());
            parameters.put("remarks", company.getRemarks());
            parameters.put("deleted", false);
            parameters.put("updateDate", format.format(new Date()));
            parameters.put("street", company.getStreet());
            parameters.put("place", company.getPlace());
            parameters.put("city", company.getCity());
            parameters.put("state", company.getState());
            parameters.put("zip", company.getZip());
            parameters.put("country", company.getCountry());
            parameters.put("panNo", company.getPanNo());
            parameters.put("emailId", company.getEmailId());

            result = jdbcTemplate.update(createCompanySql, parameters);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return (result > 0) ? true : false;
    }

    @Override
    public List<Company> getAllCompany() {

        List<Company> companyList = null;
        try {
            String getAllCompanySql = "Select * from company";
            companyList = jdbcTemplate.query(getAllCompanySql, new CompanyMapper());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return companyList;
    }

    @Override
    public Company getCompanyByName(String companyName, String mobileNo) {

        Company companyForId = null;

        try {
            String companyForIdSql = "select * from company where company_name = :companyName and contact = :mobileNo";
            Map<String, Object> parameters = new HashMap<String, Object>();
            parameters.put("companyName", companyName);
            parameters.put("mobileNo", mobileNo);
            companyForId = jdbcTemplate.queryForObject(companyForIdSql, parameters, new CompanyMapper());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return companyForId;
    }

    @Override
    public Company getCompanyById(int companyId) {
        Company company = null;
        try{
            String getCompanyByIdSql = "select * from company where id = :companyId";

            Map<String, Object> parameter = new HashMap<String, Object>();
            parameter.put("companyId", companyId);
            company = jdbcTemplate.queryForObject(getCompanyByIdSql, parameter, new CompanyMapper());

        }catch(Exception e){
            e.printStackTrace();
        }
        return company;
    }

    @Override
    public Company getCompanyByUserId(int UserId){
        Company company = null;
        return company;
    }

    @Override
    public Company getCompanyByEmailId(String emailId){
        Company company = null;
        try{
            String getCompanyByUsernameSql = "select * from company where email_id = :emailId";
System.out.println("inside");
            Map<String, Object> parameter = new HashMap<String, Object>();
            parameter.put("emailId", emailId);
            company = jdbcTemplate.queryForObject(getCompanyByUsernameSql, parameter, new CompanyMapper());

        }catch(Exception e){
            e.printStackTrace();
        }
        return company;
    }


    public Company getCompanyByUserName(String userName){
        Company company = null;
        try{
            String getCompanyByUsernameSql = "select * from company where user_name = :userName";
            Map<String, Object> parameter = new HashMap<String, Object>();
            parameter.put("userName", userName);
            company = jdbcTemplate.queryForObject(getCompanyByUsernameSql, parameter, new CompanyMapper());

        }catch(Exception e){
            e.printStackTrace();
        }
        return company;
    }
}
