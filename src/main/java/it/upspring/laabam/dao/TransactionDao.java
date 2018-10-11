package it.upspring.laabam.dao;

import it.upspring.laabam.domain.Transactions;
import it.upspring.laabam.vo.GroupCollectionStats;
import it.upspring.laabam.vo.TransactionUser;
import org.codehaus.jettison.json.JSONArray;

import java.util.HashMap;
import java.util.List;

/**
 * Created by sri on 2/11/15.
 */
public interface TransactionDao {

    boolean collectPayment(Transactions transactions);
    List<TransactionUser> getUserTransactions(int groupId);
    List<TransactionUser> getMemberTransactions(int memberId);
    double getMemberCurrentBalance(int memberId);
    double getMemberAmountInvested(int memberId);
    double getMemberDividendEarned(int memberId);
    int getGroupCurrentBalance(int groupId);
    GroupCollectionStats getGroupCollectionStatus(int groupId);
    JSONArray getCollectionTrend(int groupId, int branchId);
    List<TransactionUser> getTransactionsCreatedByUser(int entityId, String entityType);
    boolean copyTransactionsForSwitch(int outgoingMemberId,int incomingMemberId);
    boolean deleteOldTransactions(int outgoingMemberId);
    List<TransactionUser> getPendingPayments(int branchId);

}
