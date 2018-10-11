package it.upspring.laabam.service;

import it.upspring.laabam.domain.Company;
import it.upspring.laabam.domain.User;

import java.util.List;

/**
 * Created by sri on 26/10/15.
 */
public interface CompanyService {

    boolean createCompany(Company company);
    List<Company> getAllCompany();
    Company getCompanyByName(String companyName, String mobileNo);
    Company getCompanyById(int companyId);
    Company getCompanyByUserId(int userId);
    Company getCompanyForloginUser(User userName);
}
