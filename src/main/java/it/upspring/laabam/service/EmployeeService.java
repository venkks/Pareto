package it.upspring.laabam.service;

import it.upspring.laabam.domain.Employee;

/**
 * Created by sourabhrohilla on 23/12/15.
 */
public interface EmployeeService {

    boolean addEmployee(Employee employee);
    Employee getEmployeeFromUserId(int userId);


}
