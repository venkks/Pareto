package it.upspring.laabam.dao;

import it.upspring.laabam.domain.Auction;
import it.upspring.laabam.domain.BidDetails;
import it.upspring.laabam.rowmapper.TransactionMapper;
import it.upspring.laabam.vo.AuctionHistory;
import it.upspring.laabam.vo.TransactionUser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by sri on 17/11/15.
 */
@Repository
public class BidDetailsDaoImpl implements BidDetailsDao {

    private static final Logger logger = LoggerFactory.getLogger(BidDetailsDaoImpl.class);
    @Autowired(required = false)
    private NamedParameterJdbcTemplate jdbcTemplate;

    public void setJdbcTemplate(NamedParameterJdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public boolean addNewBid(BidDetails bidDetails) {
        int result = 0;
        try {
            final String insertAuctionSql = "INSERT INTO bid_details(group_id,bid_cycle,member_id,bidding_amount,deleted)" +
                    " VALUES( :groupId, :bidCycle, :memberId, :biddingAmount, :deleted)";

            final Map<String, Object> parameters = new HashMap<String, Object>();
            parameters.put("groupId", bidDetails.getGroupId());
            parameters.put("bidCycle", bidDetails.getBidCycle());
            parameters.put("memberId", bidDetails.getMemberId());
            parameters.put("biddingAmount", bidDetails.getBiddingAmount());
            parameters.put("deleted", false);

            result = jdbcTemplate.update(insertAuctionSql, parameters);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return (result > 0) ? true : false;
    }


    @Override
    public TransactionUser getCurrentBid(int groupId, int bidCycle) {
        List<TransactionUser> result = null;
        try {
            final String getCurrentBidSql = "select bd.member_id,u.full_name,bidding_amount as bidding_amount from bid_details bd,members m,users u where \n" +
                    "bd.group_id=:groupId and bd.bid_cycle=:bidCycle and bd.member_id=m.id and m.user_id=u.id and bd.bidding_amount=(select min(bidding_amount)\n" +
                    "from bid_details where bd.group_id=:groupId and bd.bid_cycle=:bidCycle);";

            final Map<String, Object> parameters = new HashMap<String, Object>();
            parameters.put("groupId", groupId);
            parameters.put("bidCycle", bidCycle);

            result = jdbcTemplate.query(getCurrentBidSql, parameters, new RowMapper<TransactionUser>() {
                @Override
                public TransactionUser mapRow(ResultSet rs,int i) throws SQLException {
                    TransactionUser transactionUser = new TransactionUser();
                    transactionUser.setFullName(rs.getString("full_name"));
                    transactionUser.setCurrentBid(rs.getInt("bidding_amount"));
                    transactionUser.setMemberId(rs.getInt("member_id"));
                    return transactionUser;
                }
            });

        }
        catch (Exception e) {
            e.printStackTrace();
        }
        if(result.size()==0){
            return null;
        }
        return result.get(0);
    }
}