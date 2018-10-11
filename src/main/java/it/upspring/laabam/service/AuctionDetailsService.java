package it.upspring.laabam.service;

import it.upspring.laabam.domain.AuctionDetails;

import java.util.List;

/**
 * Created by sourabhrohilla on 3/21/16.
 */
public interface AuctionDetailsService {
    boolean addBidReport(List<AuctionDetails> auctionDetailsList);
}
