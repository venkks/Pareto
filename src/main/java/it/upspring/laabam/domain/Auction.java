package it.upspring.laabam.domain;

/**
 * Created by sri on 2/11/15.
 */
public class Auction {
    private int auctionId;
    private String auctionDate;
    private int groupId;
    private int memberId;
    private float amount;
    private float serviceTax;
    private float dividend;
    private  boolean deleted;
    private String upcomingAuctionDate;

    public int getAuctionId() {
        return auctionId;
    }

    public void setAuctionId(int auctionId) {
        this.auctionId = auctionId;
    }

    public String getAuctionDate() {
        return auctionDate;
    }

    public void setAuctionDate(String auctionDate) {
        this.auctionDate = auctionDate;
    }

    public int getGroupId() {
        return groupId;
    }

    public void setGroupId(int groupId) {
        this.groupId = groupId;
    }

    public int getMemberId() {
        return memberId;
    }

    public void setMemberId(int memberId) {
        this.memberId = memberId;
    }

    public float getAmount() {
        return amount;
    }

    public void setAmount(float amount) {
        this.amount = amount;
    }

    public float getServiceTax() {
        return serviceTax;
    }

    public void setServiceTax(float serviceTax) {
        this.serviceTax = serviceTax;
    }

    public float getDividend() {
        return dividend;
    }

    public void setDividend(float dividend) {
        this.dividend = dividend;
    }

    public boolean isDeleted() {
        return deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }

    public String getUpcomingAuctionDate() {return upcomingAuctionDate;}

    public void setUpcomingAuctionDate(String upcomingAuctionDate) {
        this.upcomingAuctionDate = upcomingAuctionDate;
    }

    @Override
    public String toString() {
        return "Auction{" +
                "auctionId=" + auctionId +
                ", auctionDate='" + auctionDate + '\'' +
                ", groupId=" + groupId +
                ", memberId=" + memberId +
                ", amount=" + amount +
                ", serviceTax=" + serviceTax +
                ", dividend=" + dividend +
                ", deleted=" + deleted +
                ", upcomingAuctionDate='" + upcomingAuctionDate+ '\'' +
                '}';
    }
}
