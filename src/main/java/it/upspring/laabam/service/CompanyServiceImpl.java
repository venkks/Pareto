package it.upspring.laabam.service;

import it.upspring.laabam.dao.CompanyDaoImpl;
import it.upspring.laabam.domain.Company;
import it.upspring.laabam.domain.Employee;
import it.upspring.laabam.domain.User;
import it.upspring.laabam.dao.EmployeeDaoImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by sri on 26/10/15.
 */
@Service
public class CompanyServiceImpl implements CompanyService {

    @Autowired(required = true)
    private CompanyDaoImpl companyDao;

    @Autowired(required = true)
    private EmployeeDaoImpl employeeDao;


    public void setCompanyDao(CompanyDaoImpl companyDao) {
        this.companyDao = companyDao;
    }

    @Override
    public boolean createCompany(Company company) {
        return companyDao.createCompany(company);
    }

    @Override
    public List<Company> getAllCompany() {
        return companyDao.getAllCompany();
    }

    @Override
    public Company getCompanyByName(String companyName, String mobileNo) {
        return companyDao.getCompanyByName(companyName, mobileNo);
    }

    @Override
    public Company getCompanyById(int companyId) {
        return companyDao.getCompanyById(companyId);
    }

    @Override
    public Company getCompanyByUserId(int userId) {return companyDao.getCompanyByUserId(userId); }

    @Override
    public Company getCompanyForloginUser(User loginUser) {
        int roleId = 0;
        Company company = new Company();
        int companyId;
        if (loginUser!= null){
            roleId = loginUser.getRoleId();
        }
        if (roleId == 2) {
            //company = companyDao.getCompanyByEmailId(loginUser.getEmailId());

             System.out.println("email........"+loginUser.getEmailId());
           // company = companyDao.getCompanyByUserName(loginUser.getUserName());
            company = companyDao.getCompanyByEmailId(loginUser.getEmailId());
            System.out.println(company);
        } else if (roleId == 3) {
            System.out.println(loginUser.getUserId());
            Employee employee = employeeDao.getEmployeeFromUserId(loginUser.getUserId());
            company = companyDao.getCompanyById(employee.getCompanyId());
        }
        else if (roleId == 1){
            company = companyDao.getCompanyById(1);
        }
        else if (roleId == 0){
            company = null;
        }
        return company;

    }

}
