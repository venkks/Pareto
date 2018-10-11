package it.upspring.laabam.domain;

/**
 * Created by sourabhrohilla on 23/12/15.
 */
public class Employee {
    private int employeeId;
    private int userId;
    private int companyId;
    private int branchId;
    private int createdBy;
    private int deleted;
    private String designation;
    private String createdAt;
    private String updatedAt;

    public int getEmployeeId()  { return employeeId; }

    public void setEmployeeId(int employeeId) {this.employeeId = employeeId; }

    public int getUserId()  { return userId; }

    public void setUserId(int userId) {this.userId = userId; }

    public int getCompanyId()  { return companyId; }

    public void setCompanyId(int companyId) {this.companyId= companyId; }

    public int getBranchId()  { return branchId; }

    public void setBranchId(int branchId) {this.branchId= branchId; }

    public int getCreatedBy()  { return createdBy; }

    public void setCreatedBy(int createdBy) {this.createdBy= createdBy; }

    public int getDeleted()  { return deleted; }

    public void setDeleted(int deleted) {this.deleted= deleted; }

    public String getDesignation()  { return designation; }

    public void setDesignation(String designation) {this.designation= designation; }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt= createdAt;
    }

    public String getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(String updatedAt) {
        this.updatedAt= updatedAt;
    }

    @Override
    public String toString() {
        return "Employee{" +
                ", userId='" + userId+ '\'' +
                ", companyId='" + companyId+ '\'' +
                ", branchId='" + branchId+ '\'' +
                ", deleted=" + deleted +
                ", createdAt='" + createdAt+ '\'' +
                ", updatedAt='" + updatedAt+ '\'' +
                ", designation=" + designation+
                ", createdBy=" + createdBy+
                '}';
    }

}



//Query to create new table.

//    CREATE TABLE `employee` (
//        `employee_id` int(11) NOT NULL AUTO_INCREMENT,
//        `user_id` int(11) NOT NULL,
//        `company_id` int(11) NOT NULL,
//        `branch_id` int(11) NOT NULL,
//        `createdby` varchar(45) DEFAULT NULL,
//        `update_date` datetime DEFAULT NULL,
//        `deleted` tinyint(1) NOT NULL,
//        `designation` varchar(45) NOT NULL,
//        PRIMARY KEY (`employee_id`),
//        UNIQUE KEY `employee_user_id_UNIQUE` (`employee_id`),
//        KEY `employee_id_idx` (`employee_id`),
//        KEY `user_id_idx` (`user_id`)
//        )