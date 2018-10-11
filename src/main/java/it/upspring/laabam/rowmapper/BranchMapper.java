package it.upspring.laabam.rowmapper;

import it.upspring.laabam.domain.Branch;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by sri on 26/10/15.
 */
public class BranchMapper implements RowMapper<Branch> {
    @Override
    public Branch mapRow(ResultSet rs, int rowNum) throws SQLException {
        Branch branch = new Branch();

        branch.setBranchId(rs.getInt("id"));
        branch.setCompanyId(rs.getInt("company_id"));
        branch.setBranchName(rs.getString("branch_name"));
        branch.setAddress(rs.getString("address"));
        branch.setContact(rs.getString("contact"));
        return branch;
    }
}
