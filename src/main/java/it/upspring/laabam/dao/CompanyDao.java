package it.upspring.laabam.dao;

import it.upspring.laabam.domain.Company;

import java.util.List;

/**
 * Created by sri on 26/10/15.
 */
public interface CompanyDao {


    boolean createCompany(Company company);
    List<Company> getAllCompany();
    Company getCompanyByName(String companyName, String mobileNo);
    Company getCompanyById(int companyId);
    Company getCompanyByUserId(int UserId);
    Company getCompanyByEmailId(String emailId);
    Company getCompanyByUserName(String userName);


}
