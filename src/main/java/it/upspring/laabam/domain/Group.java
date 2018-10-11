package it.upspring.laabam.domain;

/**
 * Created by sri on 8/10/15.
 */


public class Group {


    private int groupId;
    private String groupName;
    private String auctionDate;
    private boolean smsOption;
    private int groupStatusId;
    private int groupValue;
    private int auctionFrequency;
    private int companyId;
    private int branchId;
    private int memberCount;
    private String createdAt;
    private String updatedAt;


    public int getGroupId() {
        return groupId;
    }

    public void setGroupId(int groupId) {
        this.groupId = groupId;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public String getAuctionDate() {
        return auctionDate;
    }

    public void setAuctionDate(String auctionDate) {
        this.auctionDate = auctionDate;
    }

    public boolean isSmsOption() {
        return smsOption;
    }

    public void setSmsOption(boolean smsOption) {
        this.smsOption = smsOption;
    }

    public int getGroupStatusId() {
        return groupStatusId;
    }

    public void setGroupStatusId(int groupStatusId) {
        this.groupStatusId = groupStatusId;
    }

    public int getGroupValue(){
        return groupValue;
    }

    public void setGroupValue(int groupValue){
        this.groupValue=groupValue;
    }

    public int getAuctionFrequency() {
        return auctionFrequency;
    }

    public void setAuctionFrequency(int auctionFrequency) {
        this.auctionFrequency = auctionFrequency;
    }

    public int getCompanyId() {
        return companyId;
    }

    public void setCompanyId(int companyId) {
        this.companyId = companyId;
    }

    public int getBranchId() {
        return branchId;
    }

    public void setBranchId(int branchId) {
        this.branchId = branchId;
    }

    public int getMemberCount(){
        return memberCount;
    }
    public void setMemberCount(int memberCount){
        this.memberCount = memberCount;
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
        return "Group{" +
                "groupId=" + groupId +
                ", groupName='" + groupName + '\'' +
                ", auctionDate='" + auctionDate + '\'' +
                ", smsOptions=" + smsOption +
                ", groupStatusId='" + groupStatusId+ '\'' +
                ", groupVale=" + groupValue+
                ", auctionFrequency=" + auctionFrequency +
                ", companyId=" + companyId +
                ", branchId=" + branchId +
                ", memberCount=" + memberCount+
                ", createdAt=" + createdAt+
                ", updatedAt=" + updatedAt+
                '}';
    }
}
