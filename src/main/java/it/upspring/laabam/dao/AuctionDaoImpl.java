package it.upspring.laabam.dao;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.Statement;
import com.sun.glass.ui.EventLoop;
import it.upspring.laabam.domain.Auction;
import it.upspring.laabam.domain.Group;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import it.upspring.laabam.vo.AuctionHistory;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by sri on 17/11/15.
 */
@Repository
public class AuctionDaoImpl implements AuctionDao {

    private static final Logger logger = LoggerFactory.getLogger(AuctionDaoImpl.class);
    @Autowired(required = false)
    private NamedParameterJdbcTemplate jdbcTemplate;

    public void setJdbcTemplate(NamedParameterJdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public boolean addNewAuction(Auction auction) {
        int result = 0;
        try {
            final String insertAuctionSql = "INSERT INTO auction(auction_date,group_id,member_id,amount,dividend, deleted, service_tax, upcoming_auction_date)" +
                    " VALUES( :auctionDate, :groupId, :memberId, :amount, :dividend, :deleted, :serviceTax, :upcomingAuctionDate)";

            final Map<String, Object> parameters = new HashMap<String, Object>();
            parameters.put("auctionDate", auction.getAuctionDate());
            parameters.put("groupId", auction.getGroupId());
            parameters.put("memberId", auction.getMemberId());
            parameters.put("amount", auction.getAmount());
            parameters.put("dividend", auction.getDividend());
            parameters.put("deleted", false);
            parameters.put("serviceTax", auction.getServiceTax());
            parameters.put("upcomingAuctionDate", auction.getUpcomingAuctionDate());


            result = jdbcTemplate.update(insertAuctionSql, parameters);


//            KeyHolder keyHolder = new GeneratedKeyHolder();
//            jdbcTemplate.update(
//                    new PreparedStatementCreator() {
//                        public PreparedStatement createPreparedStatement(Connection connection) throws SQLException {
//                            PreparedStatement ps =
//                                    connection.prepareStatement(insertAuctionSql, parameters, Statement.RETURN_GENERATED_KEYS);
//                            return ps;
//                        }
//                    },
//                    keyHolder);

//     keyHolder.getKey() now contains the generated key

        } catch (Exception e) {
            e.printStackTrace();
        }
        return (result > 0) ? true : false;
    }





    @Override
    public int getNewAuction(Auction auction) {
        int result = 0;
        List<Auction> auctionList = null;
        try {
            final String insertAuctionSql = "select * from auction where " +
                    " auction_date=:auctionDate and group_id = :groupId and member_id = :memberId";

            final Map<String, Object> parameters = new HashMap<String, Object>();
            parameters.put("auctionDate", auction.getAuctionDate());
            parameters.put("groupId", auction.getGroupId());
            parameters.put("memberId", auction.getMemberId());

            auctionList = jdbcTemplate.query(insertAuctionSql, parameters, new RowMapper<Auction>() {
                @Override
                public Auction mapRow(ResultSet rs, int rowNum) throws SQLException {
                    Auction auction = new Auction();
                    auction.setAuctionId(rs.getInt("id"));
                    auction.setMemberId(rs.getInt("member_id"));
                    auction.setGroupId(rs.getInt("group_id"));
                    return auction;
                }
            });

        } catch (Exception e) {
            e.printStackTrace();
        }
        return auctionList.get(0).getAuctionId();
    }


    @Override
    public List<AuctionHistory> getAuctionHistory(int memberId){
        String auctionHistorySql = "select tbl1.*,(select g.group_value/g.member_count from groups g,members m \n" +
                "                where m.id=:memberId and m.group_id=g.id)-ifnull(tbl2.dividend,0) as payment from\n" +
                "                (select u.full_name as auction_winner,a.dividend,a.amount auction_winning_amount," +
                "                (@row_number1:=@row_number1 + 1) as rownum1,m2.id as member_id from \n" +
                "                members m1,members m2,groups g,users u,auction a,(select @row_number1:=0) as index1 where\n" +
                "                a.group_id = g.id and m1.group_id=g.id and m2.id=a.member_id and m2.user_id = u.id and m1.id=:memberId) \n" +
                "                 as tbl1 left join\n" +
                "                (select u.full_name as auction_winner,a.dividend,(@row_number2:=@row_number2 + 1) as rownum2 from \n" +
                "                members m1,members m2,groups g,users u,auction a,(select @row_number2:=0) as index1 where\n" +
                "                a.group_id = g.id and m1.group_id=g.id and m2.id=a.member_id and m2.user_id = u.id and m1.id=:memberId) \n" +
                "                as tbl2 \n" +
                "                on tbl1.rownum1=tbl2.rownum2+1 order by rownum1 desc;";

        List<AuctionHistory> auctionHistory = null;
        Map<String,Object> parameters = new HashMap<String, Object>();
        parameters.put("memberId",memberId);
        auctionHistory = jdbcTemplate.query(auctionHistorySql, parameters, new RowMapper<AuctionHistory>() {
            public AuctionHistory mapRow(ResultSet rs, int rowNum) throws SQLException{
                AuctionHistory auctionHist = new AuctionHistory();
                auctionHist.setAuctionNumber(rs.getInt("rownum1"));
                auctionHist.setAuctionWinner(rs.getString("auction_winner"));
                auctionHist.setAuctionWinningAmount(rs.getString("auction_winning_amount"));
                auctionHist.setCyclePayment(rs.getInt("payment"));
                auctionHist.setDividend(rs.getInt("dividend"));
                auctionHist.setAuctionWinnerMemberId(rs.getInt("member_id"));
                return auctionHist;
            }
        });

        return auctionHistory;

    }
}
