package it.upspring.laabam.domain;

/**
 * Created by sri on 2/11/15.
 */
public class AuctionDetails {

    private int auctionDetailId;
    private int auctionId;
    private int memberId;
    private int biddingAmount;
    private String naaration;
    private boolean deleted;
    private String createdAt;
    private String updatedAt;

    public int getAuctionDetailId() {
        return auctionDetailId;
    }

    public void setAuctionDetailId(int auctionDetailId) {
        this.auctionDetailId = auctionDetailId;
    }

    public int getAuctionId() {
        return auctionId;
    }

    public void setAuctionId(int auctionId) {
        this.auctionId = auctionId;
    }

    public int getMemberId() {
        return memberId;
    }

    public void setMemberId(int memberId) {
        this.memberId = memberId;
    }

    public int getBiddingAmount() {
        return biddingAmount;
    }

    public void setBiddingAmount(int biddingAmount) {
        this.biddingAmount = biddingAmount;
    }

    public String getNaaration() {
        return naaration;
    }

    public void setNaaration(String naaration) {
        this.naaration = naaration;
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
        return "AuctionDetails{" +
                "auctionDetailId=" + auctionDetailId +
                ", auctionId=" + auctionId +
                ", memberId=" + memberId +
                ", biddingAmount=" + biddingAmount +
                ", naaration='" + naaration + '\'' +
                ", deleted=" + deleted +
                ", createdAt=" + createdAt+
                ", updatedAt=" + updatedAt+
                '}';
    }
}
