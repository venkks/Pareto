package it.upspring.laabam.service;

import it.upspring.laabam.domain.BidDetails;
import it.upspring.laabam.vo.TransactionUser;

/**
 * Created by sri on 17/11/15.
 */
public interface BidDetailsService {
    boolean addNewBid(BidDetails bidDetails);
    TransactionUser getCurrentBid(int groupId, int bidCycle);
}
