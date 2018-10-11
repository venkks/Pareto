package it.upspring.laabam.dao;

import it.upspring.laabam.domain.Employee;
import it.upspring.laabam.rowmapper.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by sourabhrohilla on 23/12/15.
 */
@Repository
public class EmployeeDaoImpl implements EmployeeDao {

    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");


    @Autowired(required = false)
    private NamedParameterJdbcTemplate jdbcTemplate;

    public void setJdbcTemplate(NamedParameterJdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }


    public boolean addEmployee(Employee employee) {
        System.out.println("Entered EmployeeDAO");
        int createdFlag = 0;
        try {
            String createEmployeeSql = "INSERT INTO employee( user_id, company_id, branch_id, createdBy," +
                    " deleted, designation) VALUES(:userId, " +
                    ":companyId, :branchId, :createdBy, :deleted, :designation)";

            Map<String, Object> parameters = new HashMap<String, Object>();
            parameters.put("userId", employee.getUserId());
            parameters.put("companyId", employee.getCompanyId());
            parameters.put("branchId", employee.getBranchId());
            parameters.put("createdBy", employee.getCreatedBy());
            parameters.put("deleted", employee.getDeleted());
            parameters.put("designation", employee.getDesignation());
            System.out.println("EmployeeDaoImpl" + parameters);

            createdFlag = jdbcTemplate.update(createEmployeeSql, parameters);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return (createdFlag > 0);
    }


    public Employee getEmployeeFromUserId(int userId) {
        Employee employee;

        System.out.println("emp dao");
        String getCompanyIdQuery = "SELECT * from employee where user_id = :userId";
        Map<String, Object> parameters = new HashMap<String, Object>();
        parameters.put("userId", userId);
        employee = jdbcTemplate.queryForObject(getCompanyIdQuery, parameters, new EmployeeMapper());
        return employee;


    }

}
