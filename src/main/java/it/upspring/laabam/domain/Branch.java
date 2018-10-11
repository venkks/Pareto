package it.upspring.laabam.domain;

/**
 * Created by sri on 26/10/15.
 */
public class Branch {

    private int branchId;
    private int companyId;
    private String branchName;
    private String street;
    private String address;
    private String contact;
    private boolean deleted;
    private String createdAt;
    private String updatedAt;


    public int getBranchId() {
        return branchId;
    }

    public void setBranchId(int branchId) {
        this.branchId = branchId;
    }

    public int getCompanyId() {
        return companyId;
    }

    public void setCompanyId(int companyId) {
        this.companyId = companyId;
    }

    public String getBranchName() {
        return branchName;
    }

    public void setBranchName(String branchName) {
        this.branchName = branchName;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact= contact;
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

    @Override
    public String toString() {
        return "Branch{" +
                "branchId=" + branchId +
                ", companyId=" + companyId +
                ", branchName='" + branchName + '\'' +
                ", street='" + street + '\'' +
                ", address='" + address + '\'' +
                ", contact='" + contact + '\'' +
                ", deleted=" + deleted +
                ", createdAt=" + createdAt+
                ", updatedAt=" + updatedAt+
                '}';
    }
}
