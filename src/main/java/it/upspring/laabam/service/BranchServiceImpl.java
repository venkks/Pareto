package it.upspring.laabam.service;

import it.upspring.laabam.dao.BranchDaoImpl;
import it.upspring.laabam.domain.Branch;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by sri on 6/11/15.
 */
@Service
public class BranchServiceImpl implements BranchService {

    @Autowired(required = true)
    private BranchDaoImpl branchDao;

    @Override
    public boolean addBranch(Branch branch) {
        return branchDao.addBranch(branch);
    }

    @Override
    public List<Branch> getBranches(int companyId) {
        return branchDao.getBranches(companyId);
    }

    @Override
    public Branch getBranchFromNameAndCompany(String branchName, int companyId) {
        return branchDao.getBranchFromNameAndCompany(branchName,companyId);
    }
}
