package it.upspring.laabam.domain;

/**
 * Created by sri on 24/10/15.
 */
public class Member {

    private int memberId;

    private int userId;

    private int groupId;

    private int createdBy;

    private String createdAt;

    private String updatedAt;

    private boolean deleted;

    public int getMemberId() {
        return memberId;
    }

    public void setMemberId(int memberId) {
        this.memberId = memberId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getGroupId() {
        return groupId;
    }

    public void setGroupId(int groupId) {
        this.groupId = groupId;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    public String getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(String updatedAt) {
        this.updatedAt= updatedAt;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt= createdAt;
    }

    public boolean isDeleted() {
        return deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }

    @Override
    public String toString() {
        return "Member{" +
                "memberId=" + memberId +
                ", userId=" + userId +
                ", groupId=" + groupId +
                ", createdBy=" + createdBy +
                ", created_at='" + createdAt+ '\'' +
                ", updated_at='" + updatedAt+ '\'' +
                ", deleted=" + deleted +
                '}';
    }
}
