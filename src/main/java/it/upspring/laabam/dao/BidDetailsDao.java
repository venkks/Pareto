package it.upspring.laabam.dao;

import it.upspring.laabam.domain.Auction;
import it.upspring.laabam.domain.BidDetails;
import it.upspring.laabam.vo.AuctionHistory;
import it.upspring.laabam.vo.TransactionUser;

import java.util.List;

/**
 * Created by sri on 17/11/15.
 */
public interface BidDetailsDao {
    boolean addNewBid(BidDetails bidDetails);
    TransactionUser getCurrentBid(int groupId, int bidCycle);
}
