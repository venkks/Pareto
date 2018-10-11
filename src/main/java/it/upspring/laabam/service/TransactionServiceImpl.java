package it.upspring.laabam.service;

import it.upspring.laabam.dao.TransactionDaoImpl;
import it.upspring.laabam.domain.Transactions;
import it.upspring.laabam.vo.GroupCollectionStats;
import it.upspring.laabam.vo.TransactionUser;
import org.codehaus.jettison.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

/**
 * Created by sri on 2/11/15.
 */
@Service
public class TransactionServiceImpl implements  TransactionService {

    @Autowired(required = true)
    private TransactionDaoImpl transactionDao;

    @Override
    public boolean collectPayment(Transactions transactions) {
        return transactionDao.collectPayment(transactions);
    }

    @Override
    public List<TransactionUser> getUserTransactions(int groupId) {
        return transactionDao.getUserTransactions(groupId);
    }
    @Override
    public List<TransactionUser> getMemberTransactions(int memberId){
        return transactionDao.getMemberTransactions(memberId);
    }

    @Override
    public double getMemberCurrentBalance(int memberId){
        return transactionDao.getMemberCurrentBalance(memberId);
    }

    @Override
    public double getMemberAmountInvested(int memberId){
        return transactionDao.getMemberAmountInvested(memberId);
    }

    @Override
    public double getMemberDividendEarned(int memberId){
        return transactionDao.getMemberDividendEarned(memberId);
    }

    @Override
    public int getGroupCurrentBalance(int groupId){
        return transactionDao.getGroupCurrentBalance(groupId);
    }

    @Override
    public GroupCollectionStats getGroupCollectionStatus(int groupId){
        return transactionDao.getGroupCollectionStatus(groupId);
    }

    @Override
    public JSONArray getCollectionTrend(int groupId, int branchId){
        return transactionDao.getCollectionTrend(groupId,branchId);
    }

    @Override
    public List<TransactionUser> getTransactionsCreatedByUser(int entityId, String entityType){
        return transactionDao.getTransactionsCreatedByUser(entityId,entityType);
    }

    @Override
    public boolean copyTransactionsForSwitch(int outgoingMemberId,int incomingMemberId){
        return transactionDao.copyTransactionsForSwitch(outgoingMemberId,incomingMemberId);
    }

    @Override
    public boolean deleteOldTransactions(int outgoingMemberId){
        return transactionDao.deleteOldTransactions(outgoingMemberId);
    }


    @Override
    public List<TransactionUser> getPendingPayments(int branchId){
        return transactionDao.getPendingPayments(branchId);
    }

}
