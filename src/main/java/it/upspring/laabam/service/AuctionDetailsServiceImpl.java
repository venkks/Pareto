package it.upspring.laabam.service;

import it.upspring.laabam.dao.AuctionDetailsDaoImpl;
import it.upspring.laabam.domain.AuctionDetails;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by sourabhrohilla on 3/21/16.
 */
@Service
public class AuctionDetailsServiceImpl implements AuctionDetailsService{

    @Autowired(required=true)
    private AuctionDetailsDaoImpl auctionDetailsDao;

    @Override
    public boolean addBidReport(List<AuctionDetails> auctionDetailsList){
        return auctionDetailsDao.addBidReport(auctionDetailsList);
    }
}
