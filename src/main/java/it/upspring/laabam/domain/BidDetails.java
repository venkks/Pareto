package it.upspring.laabam.domain;

/**
 * Created by sri on 26/10/15.
 */
public class BidDetails {


    private int groupId;
    private int bidCycle;
    private int memberId;
    private int biddingAmount;
    private boolean deleted;
    private String createdAt;
    private String updatedAt;


    public int getGroupId() {
        return groupId;
    }

    public void setGroupId(int groupId) {
        this.groupId = groupId;
    }

    public int getBidCycle() {
        return bidCycle;
    }

    public void setBidCycle(int bidCycle) {
        this.bidCycle = bidCycle;
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
        this.createdAt = createdAt;
    }

    public String getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(String updatedAt) {
        this.updatedAt = updatedAt;
    }

    @Override
    public String toString() {
        return "BidDetails{" +
                "groupId=" + groupId +
                ", bidCycle=" + bidCycle +
                ", memberId=" + memberId +
                ", biddingAmount=" + biddingAmount +
                ", deleted=" + deleted +
                ", createdAt='" + createdAt + '\'' +
                ", updatedAt='" + updatedAt + '\'' +
                '}';
    }
}
