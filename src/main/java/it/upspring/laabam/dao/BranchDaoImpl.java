package it.upspring.laabam.dao;

import it.upspring.laabam.domain.Branch;
import it.upspring.laabam.rowmapper.BranchMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by sri on 6/11/15.
 */
@Repository
public class BranchDaoImpl implements BranchDao {

    private static final Logger logger = LoggerFactory.getLogger(GroupDaoImpl.class);
    @Autowired(required = false)
    private NamedParameterJdbcTemplate jdbcTemplate;

    public void setJdbcTemplate(NamedParameterJdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public List<Branch> getBranches(int companyId) {
        List<Branch> branchList = null;

        try {
            String getBranchListSql = "SELECT * FROM branch WHERE company_id = :companyId";

            Map<String, Object> parameters = new HashMap<String, Object>();
            parameters.put("companyId", companyId);
            branchList = jdbcTemplate.query(getBranchListSql, parameters, new BranchMapper());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return branchList;
    }

    @Override
    public Branch getBranchFromNameAndCompany(String branchName, int companyId) {
        Branch branch = null;

        try {
            String getBranchListSql = "SELECT * FROM branch WHERE company_id = :companyId and branch_name = :branchName";

            Map<String, Object> parameters = new HashMap<String, Object>();
            parameters.put("companyId", companyId);
            parameters.put("branchName", branchName);
            branch = jdbcTemplate.query(getBranchListSql, parameters, new BranchMapper()).get(0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return branch;
    }

    @Override
    public boolean addBranch(Branch branch) {
        int result = 0;

        try {
            String insertBranchSql = "INSERT INTO branch (branch_name, street, address, contact, company_id) VALUES (:branchName, :street, :address, :contact, :companyId)";

            Map<String, Object> parameters = new HashMap<String, Object>();
            parameters.put("branchName", branch.getBranchName());
            parameters.put("street", branch.getStreet());
            parameters.put("address", branch.getAddress());
            parameters.put("contact", branch.getContact());
            parameters.put("companyId", branch.getCompanyId());

            result = jdbcTemplate.update(insertBranchSql, parameters);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return (result > 0) ? true : false;
    }

}
