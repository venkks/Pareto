package it.upspring.laabam.dao;

import it.upspring.laabam.domain.Branch;

import java.util.List;

/**
 * Created by sri on 6/11/15.
 */
public interface BranchDao {

    boolean addBranch(Branch branch);
    List<Branch> getBranches(int companyId);
    Branch getBranchFromNameAndCompany(String branchName, int companyId);
}
