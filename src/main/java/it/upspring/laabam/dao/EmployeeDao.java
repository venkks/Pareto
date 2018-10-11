package it.upspring.laabam.dao;

import it.upspring.laabam.domain.Company;
import it.upspring.laabam.domain.Employee;

/**
 * Created by sourabhrohilla on 23/12/15.
 */
public interface EmployeeDao {

    boolean addEmployee(Employee employee);
    Employee getEmployeeFromUserId(int userId);

}
