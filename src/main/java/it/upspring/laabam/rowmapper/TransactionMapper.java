package it.upspring.laabam.rowmapper;

import it.upspring.laabam.domain.Transactions;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by sri on 2/11/15.
 */
public class TransactionMapper implements RowMapper<Transactions> {

    @Override
    public Transactions mapRow(ResultSet rs, int rowNum) throws SQLException {

        Transactions transactions = new Transactions();

        transactions.setTransactionId(rs.getInt("id"));
        transactions.setMemberId(rs.getInt("member_id"));
        transactions.setAmount(rs.getInt("amount"));
        transactions.setTransactionTypeId(rs.getInt("transaction_type_id"));
        transactions.setTransactionStatusId(rs.getInt("transaction_status_id"));
        transactions.setTransactionModeId(rs.getInt("transaction_mode_id"));
        transactions.setNarration(rs.getString("narration"));
        transactions.setCurrentOutstanding(rs.getInt("current_outstanding"));
        transactions.setCreatedByUser(rs.getInt("created_by_user"));
        transactions.setCreatedAt(rs.getString("created_at"));
        transactions.setUpdatedAt(rs.getString("updated_at"));

        return transactions;
    }
}
