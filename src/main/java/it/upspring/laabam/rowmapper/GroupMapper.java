package it.upspring.laabam.rowmapper;


import it.upspring.laabam.domain.Group;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by sri on 26/10/15.
 */
public class GroupMapper implements RowMapper<Group>{

    @Override
    public Group mapRow(ResultSet rs, int i) throws SQLException {
        Group group = new Group();

        group.setGroupId(rs.getInt("id"));
        group.setGroupName(rs.getString("group_name"));
        group.setAuctionDate(rs.getString("auction_date"));
        group.setSmsOption(rs.getBoolean("sms_option"));
        group.setGroupStatusId(rs.getInt("group_status_id"));
        group.setGroupValue(rs.getInt("group_value"));
        group.setAuctionFrequency(rs.getInt("auction_frequency"));
        group.setBranchId(rs.getInt("branch_id"));
        group.setCompanyId(rs.getInt("company_id"));
        group.setMemberCount(rs.getInt("member_count"));

        return group;
    }
}
