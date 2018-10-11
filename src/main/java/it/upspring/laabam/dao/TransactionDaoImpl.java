package it.upspring.laabam.dao;

import it.upspring.laabam.domain.Group;
import it.upspring.laabam.domain.Transactions;
import it.upspring.laabam.vo.GroupCollectionStats;
import it.upspring.laabam.rowmapper.TransactionMapper;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.ObjectFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.expression.spel.ast.FloatLiteral;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import it.upspring.laabam.vo.TransactionUser;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.math.MathContext;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.List;

/**
 * Created by sri on 2/11/15.
 */
@Repository
public class TransactionDaoImpl implements TransactionDao {

    private static final Logger logger = LoggerFactory.getLogger(GroupDaoImpl.class);
    @Autowired(required = false)
    private NamedParameterJdbcTemplate jdbcTemplate;

    public void setJdbcTemplate(NamedParameterJdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public boolean collectPayment(Transactions transactions) {
        int result = 0;
        Date date = new Date();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");



        try {
            String collectpaymentSql = "INSERT INTO transactions(member_id, amount, transaction_type_id, " +
                    " transaction_status_id, transaction_mode_id, narration, current_outstanding, created_by_user)" +
                    " values(:memberId, :amount, :transactionTypeId, :transactionStatusId, :transactionModeId," +
                    " :narration, :currentOutstanding, :createdByUser)";


            double currentOutstanding = getMemberCurrentBalance(transactions.getMemberId());
            Map<String, Object> parameters = new HashMap<String, Object>();

            parameters.put("memberId", transactions.getMemberId());
            parameters.put("amount", transactions.getAmount());
            parameters.put("transactionTypeId",transactions.getTransactionTypeId());
            parameters.put("transactionStatusId",transactions.getTransactionStatusId());
            parameters.put("transactionModeId",transactions.getTransactionModeId());
            parameters.put("narration", transactions.getNarration());
            parameters.put("currentOutstanding", currentOutstanding);
            parameters.put("createdByUser",transactions.getCreatedByUser());

            result = jdbcTemplate.update(collectpaymentSql, parameters);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return (result > 0) ? true : false;
    }

    @Override
    public List<TransactionUser> getUserTransactions(int groupId) {
        List<TransactionUser> userTransaction=null;

        try{
            String userTransactionSql="select t.created_at as transaction_date,u1.full_name,u2.full_name reported_by,t.amount,pt.name as payment_type, pm.name as payment_mode,\n" +
                    "t.narration from users u1,users u2, transactions t, members m, transaction_modes pm, transaction_types pt \n" +
                    "where t.transaction_type_id=pt.id and t.transaction_mode_id=pm.id and \n" +
                    "t.member_id=m.id and m.group_id=:groupId and m.user_id=u1.id and t.created_by_user=u2.id order by t.created_at desc";
            Map<String, Object> parameters = new HashMap<String, Object>();
            parameters.put("groupId",groupId);
            userTransaction = jdbcTemplate.query(userTransactionSql, parameters, new RowMapper<TransactionUser>() {
                public TransactionUser mapRow(ResultSet rs, int rowNum) throws SQLException {
                    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                    TransactionUser transactionUser = new TransactionUser();
                    transactionUser.setTransactionDate(format.format(rs.getDate("transaction_date")));
                    transactionUser.setFullName(rs.getString("full_name"));
                    transactionUser.setAmount(rs.getFloat("amount"));
                    transactionUser.setPaymentType(rs.getString("payment_type"));
                    transactionUser.setNarration(rs.getString("narration"));
                    transactionUser.setPaymentMode(rs.getString("payment_mode"));
                    transactionUser.setCreatedByUserName(rs.getString("reported_by"));
                    return transactionUser;
                }

            });
        }catch (Exception e){
            e.printStackTrace();
        }

        return userTransaction;
    }



    @Override
    public List<TransactionUser> getTransactionsCreatedByUser(int entityId, String entityType) {
        List<TransactionUser> userTransaction=null;

        try{
            String userTransactionSql="select date(t.created_at) as transaction_date,sum(t.amount) amount,pm.name as payment_mode\n" +
                    " from transactions t,transaction_modes pm\n" +
                    " where t.transaction_mode_id=pm.id and t.transaction_type_id=4 and t.created_by_user = :createdByUser \n" +
                    " and date(t.created_at)>CURRENT_DATE-300 \n" +
                    " group by date(t.created_at),pm.name \n" +
                    " order by date(t.created_at) desc";
            Map<String, Object> parameters = new HashMap<String, Object>();
            parameters.put("createdByUser",entityId);
            userTransaction = jdbcTemplate.query(userTransactionSql, parameters, new RowMapper<TransactionUser>() {
                public TransactionUser mapRow(ResultSet rs, int rowNum) throws SQLException {
                    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                    TransactionUser transactionUser = new TransactionUser();
                    transactionUser.setTransactionDate(format.format(rs.getDate("transaction_date")));
                    transactionUser.setAmount(rs.getFloat("amount"));
                    transactionUser.setPaymentMode(rs.getString("payment_mode"));
                    return transactionUser;
                }

            });
        }catch (Exception e){
            e.printStackTrace();
        }

        return userTransaction;
    }

@Override
    public List<TransactionUser> getMemberTransactions(int memberId) {
        List<TransactionUser> memberTransactions=null;

        try{
            String memberTransactionSql="select t1.*,u.full_name from transactions t1,users u" +
                    " where t1.member_id=:memberId and t1.created_by_user = u.id order by t1.id DESC";
            Map<String, Object> parameters = new HashMap<String, Object>();
            parameters.put("memberId",memberId);
            memberTransactions = jdbcTemplate.query(memberTransactionSql, parameters, new RowMapper<TransactionUser>() {
                public TransactionUser mapRow(ResultSet rs, int rowNum) throws SQLException {
                    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    TransactionUser transactionUser = new TransactionUser();
                    transactionUser.setTransactionDate(format.format(rs.getTimestamp("created_at")));
                    transactionUser.setCreatedByUserName(rs.getString("full_name"));
                    transactionUser.setAmount(rs.getFloat("amount"));
                    transactionUser.setNarration(rs.getString("narration"));

                    return transactionUser;
                }

            });
        }catch (Exception e){
            e.printStackTrace();
        }
    System.out.println(memberTransactions);
        return memberTransactions;
    }


    @Override
    public List<TransactionUser> getPendingPayments(int branchId) {
        List<TransactionUser> memberTransactions=null;
        try{
            String pendingPaymentsSql="select m.id member_id,g.group_name,u.full_name," +
                    " TIMESTAMPDIFF(day,max(a.upcoming_auction_date),current_date) as num_days_to_next_auction," +
                    " sum(t.amount) pending_amount from users u,members m,auction a,transactions t,groups g " +
                    " where m.branch_id=:branchId and m.user_id=u.id and a.group_id=m.group_id and m.group_id=g.id " +
                    " and t.member_id=m.id and t.transaction_type_id in (1,2,3,4,8,9,10) " +
                    " group by u.full_name,m.id,g.id,g.group_name";
            Map<String, Object> parameters = new HashMap<String, Object>();
            parameters.put("branchId",branchId);
            memberTransactions = jdbcTemplate.query(pendingPaymentsSql, parameters, new RowMapper<TransactionUser>() {
                public TransactionUser mapRow(ResultSet rs, int rowNum) throws SQLException {
                    TransactionUser transactionUser = new TransactionUser();
                    transactionUser.setMemberId(rs.getInt("member_id"));
                    transactionUser.setGroupName(rs.getString("group_name"));
                    transactionUser.setFullName(rs.getString("full_name"));
                    transactionUser.setNumDaysToNextAuction(rs.getInt("num_days_to_next_auction"));
                    transactionUser.setAmount(rs.getInt("pending_amount"));
                    return transactionUser;
                }

            });
        }catch (Exception e){
            e.printStackTrace();
        }
        System.out.println(memberTransactions);
        return memberTransactions;
    }

    @Override
    public double getMemberCurrentBalance(int memberId) {

        double amount=0.0d;
        try{
            String currentBalanceSql="select sum(t.amount) from transactions t where t.member_id=:memberId " +
                    " and t.transaction_type_id in (1,2,3,4,8,9,10)";
            Map<String, Object> parameters = new HashMap<String, Object>();
            parameters.put("memberId",memberId);
            amount = jdbcTemplate.queryForObject(currentBalanceSql, parameters, Double.class);

            MathContext balanceAmountContext = new MathContext(2);
            BigDecimal balance = new BigDecimal(amount,balanceAmountContext);

            amount = balance.doubleValue();

        }catch (NullPointerException npe){
            return 0;
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return amount;
    }


    @Override
    public double getMemberAmountInvested(int memberId) {

        double amountInvested=0.0d;
        try{
            String currentBalanceSql="select ifnull(sum(case when transaction_type_id=4 then amount end),0)" +
                    " as amount_invested" +
                    " from transactions where member_id=:memberId";
            Map<String, Object> parameters = new HashMap<String, Object>();
            parameters.put("memberId",memberId);
            amountInvested = jdbcTemplate.queryForObject(currentBalanceSql, parameters, Double.class);

        }catch (NullPointerException npe){
            return 0;
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return amountInvested;
    }


    @Override
    public double getMemberDividendEarned(int memberId) {

        double dividendEarned=0.0d;
        try{
            String currentBalanceSql="select ifnull(sum(case when transaction_type_id=8 then amount end),0)" +
                    " as amount_invested" +
                    " from transactions where member_id=:memberId";
            Map<String, Object> parameters = new HashMap<String, Object>();
            parameters.put("memberId",memberId);
            dividendEarned = jdbcTemplate.queryForObject(currentBalanceSql, parameters, Double.class);

        }catch (NullPointerException npe){
            return 0;
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return dividendEarned;
    }

    @Override
    public int getGroupCurrentBalance(int groupId){
        int amount=0;
        try{
            String groupCurrentBalance="select sum(amount) from transactions where" +
                    " transaction_type_id in (1,2,3,4,8,9,10) and member_id in " +
                    " (select member_id from members where group_id=:groupId)";
            Map<String, Object> parameters = new HashMap<String, Object>();
            parameters.put("groupId",groupId);
            System.out.println(parameters);
            amount = jdbcTemplate.queryForObject(groupCurrentBalance,parameters,Integer.class);
        } catch (Exception e){
            e.printStackTrace();
        }
        return amount;
    }

    @Override
    public boolean copyTransactionsForSwitch(int outgoingMemberId,int incomingMemberId){
        int result = 0;
        try{
            String copyTransactionSql = "insert into transactions " +
                    " (member_id,amount,transaction_type_id,transaction_status_id, transaction_mode_id,narration,current_outstanding) " +
                    " SELECT :incomingMemberId as member_id,amount,transaction_type_id,transaction_status_id, transaction_mode_id," +
                    " concat('Switch - ',narration) as narration,current_outstanding from transactions " +
                    " where member_id=:outgoingMemberId and transaction_type_id not in (4)";
            Map<String, Object> parameters = new HashMap<String, Object>();
            parameters.put("outgoingMemberId",outgoingMemberId);
            parameters.put("incomingMemberId",incomingMemberId);
            result = jdbcTemplate.update(copyTransactionSql,parameters);
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return (result>0) ? true:false;
    }

    @Override
    public boolean deleteOldTransactions(int outgoingMemberId){
        int result = 0;
        try{
            String copyTransactionSql = "update transactions set transaction_status_id=5 " +
                    " where member_id=:outgoingMemberId" ;
            Map<String, Object> parameters = new HashMap<String, Object>();
            parameters.put("outgoingMemberId",outgoingMemberId);
            result = jdbcTemplate.update(copyTransactionSql,parameters);
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return (result>0) ? true:false;
    }

    @Override
    public GroupCollectionStats getGroupCollectionStatus(int groupId){
        String collectionStatusQuery = "select sum(case when payable_current>=0 then 1 else 0 end) as paid_members,count(*) as total_members,\n" +
                "sum(payable_on_auction_date) as outstanding_on_auction_date,\n" +
                "sum(payable_current) as outstanding_current,\n" +
                "sum(payable_current-payable_on_auction_date) as amount_collected from\n" +
                "(select auction_payable.member_id,auction_payable.payable_on_auction_date,current_payable.payable_current from\n" +
                "(select member_id,(amount+current_outstanding) payable_current from transactions t1 \n" +
                "where id = (select max(t2.id) from transactions t2 where t1.member_id=t2.member_id\n" +
                "and t2.member_id in (select id from members where group_id=:groupId))) current_payable\n" +
                "LEFT JOIN \n" +
                "(select member_id,(amount+current_outstanding) payable_on_auction_date from transactions t1  " +
                "where t1.transaction_type_id in (1,3) and id = (select max(t2.id) from transactions t2 where  " +
                "t1.member_id=t2.member_id and t2.transaction_type_id in (1,3) and t2.member_id in " +
                "(select id from members where group_id=:groupId))) auction_payable\n" +
                "on auction_payable.member_id=current_payable.member_id) as collection_stats";

        HashMap<String,Object> parameters = new HashMap<String, Object>();
        parameters.put("groupId",groupId);
        List<GroupCollectionStats> chartsData = null;
        chartsData = jdbcTemplate.query(collectionStatusQuery,
                parameters, new RowMapper<GroupCollectionStats>() {
                    @Override
                    public GroupCollectionStats mapRow(ResultSet rs, int rowNum) throws SQLException{
                        GroupCollectionStats groupCollectionStats = new GroupCollectionStats();
                        groupCollectionStats.setAmountCollected(rs.getFloat("amount_collected"));
                        groupCollectionStats.setOutstandingCurrent(rs.getFloat("outstanding_current"));
                        groupCollectionStats.setOutstandingOnAuctionDate(rs.getFloat("outstanding_on_auction_date"));
                        groupCollectionStats.setPaidMembers(rs.getInt("paid_members"));
                        groupCollectionStats.setTotalMembers(rs.getInt("total_members"));
                        groupCollectionStats.setCollectionProgress(-100*groupCollectionStats.getAmountCollected()/groupCollectionStats.getOutstandingOnAuctionDate());
                        groupCollectionStats.setMembersProgress(100*groupCollectionStats.getPaidMembers()/groupCollectionStats.getTotalMembers());
                        return groupCollectionStats;
                    }


        });
        return chartsData.get(0);
    }

    @Override
    public JSONArray getCollectionTrend(int groupId, int branchId){
        String collectionTrendQuery = "";
        HashMap<String,Object> parameters = new HashMap<String, Object>();
        if(groupId==0){
            collectionTrendQuery = "select unix_timestamp(collection_date)*1000 as collection_date, collection from" +
                    "(select date(date_add(date_add(created_at,interval 5 hour),interval 30 minute)) as collection_date,sum(amount) as collection from transactions \n" +
                    "where date_sub(current_date,interval 30 day) and transaction_type_id=4 \n" +
                    "and member_id in (select id from members where group_id in (select id from groups where branch_id=:branchId))\n" +
                    "group by date(date_add(date_add(created_at,interval 5 hour),interval 30 minute))) as trend";
            parameters.put("branchId",branchId);
        }
        else if(branchId==0){
            collectionTrendQuery = "select unix_timestamp(collection_date)*1000 as collection_date,collection from " +
                    "(select date(date_add(date_add(created_at,interval 5 hour),interval 30 minute)) as collection_date,sum(amount) as collection from transactions \n" +
                    "where date_sub(current_date,interval 30 day) and transaction_type_id=4 \n" +
                    "and member_id in (select id from members where group_id=:groupId)\n" +
                    "group by date(date_add(date_add(created_at,interval 5 hour),interval 30 minute))) as trend";
            parameters.put("groupId",groupId);
        }
        List<JSONArray> collectionTrend = jdbcTemplate.query(collectionTrendQuery, parameters, new RowMapper<JSONArray>() {
            @Override
            public JSONArray mapRow(ResultSet rs, int rowNum) throws SQLException{
                JSONArray trendCollection = new JSONArray();
                do{
                    JSONObject dateObject = new JSONObject();
                    try{
                        dateObject.put("x",rs.getDouble("collection_date"));
                        dateObject.put("y",rs.getFloat("collection"));
                    }
                    catch (Exception e){
                        e.printStackTrace();
                    }
                    trendCollection.put(dateObject);

                }while(rs.next());


                return trendCollection;
            }
        });

        JSONArray chartData = new JSONArray();
        JSONObject chartDetails = new JSONObject();
        try{
            chartDetails.put("key","Collection");
            if(collectionTrend.size()==0){
                chartDetails.put("values","");
            }
            else{
                chartDetails.put("values",collectionTrend.get(0));
            }

        }
        catch(Exception e){
            e.printStackTrace();
        }
        chartData.put(chartDetails);

        return chartData;

    }
}
