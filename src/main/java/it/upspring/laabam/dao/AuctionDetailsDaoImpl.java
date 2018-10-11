package it.upspring.laabam.dao;

import it.upspring.laabam.domain.AuctionDetails;
import it.upspring.laabam.service.AuctionDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by sourabhrohilla on 3/21/16.
 */
@Repository
public class AuctionDetailsDaoImpl implements AuctionDetailsDao {

    @Autowired(required = false)
    private NamedParameterJdbcTemplate jdbcTemplate;

    public void setJdbcTemplate(NamedParameterJdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public boolean addBidReport(List<AuctionDetails> auctionDetailsList){
        int result = 0;
        for (int var = 0; var<auctionDetailsList.size(); var++){
            try {
                AuctionDetails auctionDetails = auctionDetailsList.get(var);
                String insertAuctionBidSql = "INSERT INTO auction_details(auction_id,member_id,bidding_amount,narration, deleted)" +
                        " VALUES(:auctionId, :memberId, :biddingAmount,:narration,:deleted)";

                Map<String, Object> parameters = new HashMap<String, Object>();
                parameters.put("auctionId", auctionDetails.getAuctionId());
                parameters.put("memberId", auctionDetails.getMemberId());
                parameters.put("biddingAmount", auctionDetails.getBiddingAmount());
                parameters.put("narration", "");
                parameters.put("deleted", false);

                result = jdbcTemplate.update(insertAuctionBidSql, parameters);

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return (result > 0) ? true : false;
    }

}
