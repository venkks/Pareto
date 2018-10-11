//TODO : Discrepancy in table columns and object attributes. e.g. email_id not present in table.
// TODO: Remove 'deleted' columns, use status.
package it.upspring.laabam.domain;

/**
 * Created by sri on 22/10/15.
 */
public class User {

    private int userId;
    private String title;
    private String fullName;
    private String emailId;
    private String password;
    private String contact;
    private  boolean deleted;
    private int roleId;
    private String street;
    private String place;
    private String city;
    private String state;
    private String zipCode;
    private String dob;
    private String country;
    private String aadharNo;
    private String createdAt;
    private String updatedAt;
    private String userName;

//    Adding extra variables to facilitate user and member creation from single form.
    private int branchId;
    private String designation;
    private int memberId;

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmailId() {
        return emailId;
    }

    public void setEmailId(String emailId) {
        this.emailId = emailId;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getPlace() {
        return place;
    }

    public void setPlace(String place) {
        this.place = place;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact= contact;
    }

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public boolean isDeleted() {
        return deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }

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

    public String getAadharNo() {
        return aadharNo;
    }

    public void setAadharNo(String aadharNo) {
        this.aadharNo = aadharNo;
    }

    public int getBranchId() {
        return branchId;
    }

    public void setBranchId(int branchId) {
        this.branchId= branchId;
    }

    public String getDesignation() {return designation;}

    public void setDesignation(String designation) {
        this.designation= designation;
    }

    public int getMemberId() {return memberId;}

    public void setMemberId(int memberId)  {this.memberId = memberId;}

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", title='" + title + '\'' +
                ", fullName='" + fullName + '\'' +
                ", userName='" + userName + '\'' +
                ", emailId='" + emailId + '\'' +
                ", street='" + street + '\'' +
                ", place='" + place + '\'' +
                ", city='" + city + '\'' +
                ", dob='" + dob + '\'' +
                ", contact='" + contact+ '\'' +
                ", zipCode='" + zipCode + '\'' +
                ", state='" + state + '\'' +
                ", country='" + country + '\'' +
                ", password='" + password + '\'' +
                ", roleId=" + roleId +
                ", deleted=" + deleted +
                ", createdAt='" + createdAt+ '\'' +
                ", updatedAt='" + updatedAt+ '\'' +
                ", aadharNo='" + aadharNo + '\'' +
                '}';
    }


}

