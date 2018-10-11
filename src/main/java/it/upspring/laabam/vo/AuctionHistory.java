package it.upspring.laabam.vo;

/**
 * Created by sri on 27/10/15.
 */
public class AuctionHistory {

    private int auctionNumber;
    private String auctionWinner;
    private int auctionWinnerMemberId;
    private String auctionWinningAmount;
    private int dividend;
    private int cyclePayment;

    public int getAuctionNumber() {
        return auctionNumber;
    }

    public void setAuctionNumber(int auctionNumber) {
        this.auctionNumber = auctionNumber;
    }

    public String getAuctionWinner() {
        return auctionWinner;
    }

    public void setAuctionWinner(String auctionWinner) {
        this.auctionWinner = auctionWinner;
    }

    public int getDividend() {
        return dividend;
    }

    public void setDividend(int dividend) {
        this.dividend = dividend;
    }

    public int getCyclePayment() {
        return cyclePayment;
    }

    public void setCyclePayment(int cyclePayment) {
        this.cyclePayment = cyclePayment;
    }

    public String getAuctionWinningAmount() {
        return auctionWinningAmount;
    }

    public void setAuctionWinningAmount(String auctionWinningAmount) {
        this.auctionWinningAmount = auctionWinningAmount;
    }

    public int getAuctionWinnerMemberId() {
        return auctionWinnerMemberId;
    }

    public void setAuctionWinnerMemberId(int auctionWinnerMemberId) {
        this.auctionWinnerMemberId = auctionWinnerMemberId;
    }

    @Override
    public String toString() {
        return "AuctionHistory{" +
                "auctionNumber=" + auctionNumber +
                ", auctionWinner='" + auctionWinner + '\'' +
                ", dividend=" + dividend +
                ", cyclePayment=" + cyclePayment +
                '}';
    }
}
