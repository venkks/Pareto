package it.upspring.laabam.domain;

/**
 * Created by sri on 2/11/15.
 */
public class Transactions {

    private int transactionId;
    private int groupId;
    private int memberId;
    private double amount;
    private int transactionTypeId;
    private int transactionStatusId;
    private int transactionModeId;
    private String narration;
    private double currentOutstanding;
    private int createdByUser;
    private String createdAt;
    private String updatedAt;


    public int getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(int transactionId) {
        this.transactionId = transactionId;
    }

    public int getGroupId() { return this.groupId; }

    public void setGroupId(int groupId) { this.groupId = groupId; }

    public int getMemberId() {
        return memberId;
    }

    public void setMemberId(int memberId) {
        this.memberId = memberId;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public int getTransactionTypeId(){
        return transactionTypeId;
    }

    public void setTransactionTypeId(int transactionTypeId){
        this.transactionTypeId=transactionTypeId;
    }

    public int getTransactionModeId(){
        return transactionModeId;
    }

    public void setTransactionModeId(int transactionModeId){
        this.transactionModeId=transactionModeId;
    }

    public int getTransactionStatusId(){
        return transactionStatusId;
    }

    public void setTransactionStatusId(int transactionStatusId){
        this.transactionStatusId=transactionStatusId;
    }

    public String getNarration() {
        return narration;
    }

    public void setNarration(String narration) {
        this.narration = narration;
    }

    public int getCreatedByUser() {
        return createdByUser;
    }

    public void setCreatedByUser(int createdByUser) {
        this.createdByUser= createdByUser;
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

    public double getCurrentOutstanding() {
        return currentOutstanding;
    }

    public void setCurrentOutstanding(double currentOutstanding) {
        this.currentOutstanding= currentOutstanding;
    }

    @Override
    public String toString() {
        return "Transactions{" +
                "transactionId=" + transactionId +
                ", memberId=" + memberId +
                ", amount=" + amount +
                ", transactionTypeId=" + transactionTypeId+
                ", transactionStatusId=" + transactionStatusId+
                ", transactionModeId=" + transactionModeId+
                ", narration='" + narration + '\'' +
                ", current_outstanding=" + currentOutstanding+
                ", created_at='" + createdAt+ '\'' +
                ", updated_at='" + updatedAt+ '\'' +
                '}';
    }
}
