package it.upspring.laabam.dao;

import it.upspring.laabam.domain.AuctionDetails;

import java.util.List;

/**
 * Created by sourabhrohilla on 3/21/16.
 */
public interface AuctionDetailsDao {
    public boolean addBidReport(List<AuctionDetails> auctionDetailsList);
}
