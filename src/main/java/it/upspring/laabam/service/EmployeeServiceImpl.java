package it.upspring.laabam.service;

import it.upspring.laabam.dao.CompanyDaoImpl;
import it.upspring.laabam.dao.EmployeeDaoImpl;
import it.upspring.laabam.domain.Employee;
import org.apache.poi.sl.usermodel.TextRun;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by sourabhrohilla on 23/12/15.
 */
@Service
public class EmployeeServiceImpl implements EmployeeService {

    @Autowired(required = true)
    private EmployeeDaoImpl employeeDao;

    @Autowired(required = true)
    private CompanyDaoImpl companyDao;

    public void setEmployeeDao(EmployeeDaoImpl employeeDao){this.employeeDao = employeeDao;}

    @Override
    public boolean addEmployee(Employee employee){
        return employeeDao.addEmployee(employee);
    }


    @Override
    public Employee getEmployeeFromUserId(int userId){
        return employeeDao.getEmployeeFromUserId(userId);

    }




}
