package it.upspring.laabam.rowmapper;

import it.upspring.laabam.domain.Employee;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;

/**
 * Created by sourabhrohilla on 23/12/15.
 */
public class EmployeeMapper implements RowMapper<Employee>{

    @Override
    public Employee mapRow(ResultSet rs, int i) throws SQLException{
        Employee employee = new Employee();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

        employee.setEmployeeId(rs.getInt("id"));
        employee.setUserId(rs.getInt("user_id"));
        employee.setBranchId(rs.getInt("branch_id"));
        employee.setCompanyId(rs.getInt("company_id"));
        employee.setCreatedBy(rs.getInt("createdby"));
        employee.setCreatedAt(rs.getString("created_at"));
        employee.setUpdatedAt(rs.getString("updated_at"));
        employee.setDeleted(rs.getInt("deleted"));
        employee.setDesignation(rs.getString("designation"));

        return employee;

    }
}