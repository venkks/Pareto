package it.upspring.laabam.service;

import it.upspring.laabam.domain.Auction;
import it.upspring.laabam.vo.AuctionHistory;

import java.util.List;

/**
 * Created by sri on 17/11/15.
 */
public interface AuctionService {
    boolean addNewAuction(Auction auction);
    int getNewAuction(Auction auction);
    String calculateAuctionDetails(int kasarBalance,int groupId, float serviceTax,
                                   float commissionPercentage);
    List<AuctionHistory> getAuctionHistory(int memberId);
}
