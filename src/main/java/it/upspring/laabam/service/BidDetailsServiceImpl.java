package it.upspring.laabam.service;

import it.upspring.laabam.dao.AuctionDaoImpl;
import it.upspring.laabam.dao.BidDetailsDaoImpl;
import it.upspring.laabam.domain.Auction;
import it.upspring.laabam.domain.BidDetails;
import it.upspring.laabam.domain.Group;
import it.upspring.laabam.vo.AuctionHistory;
import it.upspring.laabam.vo.TransactionUser;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by sri on 17/11/15.
 */
@Service
public class BidDetailsServiceImpl implements BidDetailsService{

    @Autowired(required = true)
    private BidDetailsDaoImpl bidDetailsDao;


    @Override
    public boolean addNewBid(BidDetails bidDetails) {
        return bidDetailsDao.addNewBid(bidDetails);
    }

    @Override
    public TransactionUser getCurrentBid(int groupId, int bidCycle){
        return bidDetailsDao.getCurrentBid(groupId,bidCycle);
    }
}
