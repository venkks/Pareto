package it.upspring.laabam.service;

import it.upspring.laabam.dao.AuctionDaoImpl;
import it.upspring.laabam.domain.*;
import it.upspring.laabam.vo.AuctionHistory;
import it.upspring.laabam.vo.TransactionUser;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Iterator;
import java.util.List;

/**
 * Created by sri on 17/11/15.
 */
@Service
public class AuctionServiceImpl implements AuctionService {

    @Autowired(required = true)
    private AuctionDaoImpl auctionDao;
    @Autowired
    private GroupService groupService;
    @Autowired
    private TransactionService transactionService;
    @Autowired
    private UserService userService;
    @Autowired
    private MemberService memberService;


    @Override
    public boolean addNewAuction(Auction auction) {
        return auctionDao.addNewAuction(auction);
    }

    @Override
    public int getNewAuction(Auction auction) {
        return auctionDao.getNewAuction(auction);
    }

    @Override
    public List<AuctionHistory> getAuctionHistory(int memberId){ return auctionDao.getAuctionHistory(memberId); }

    @Override
    public String calculateAuctionDetails(int kasarBalance, int groupId, float serviceTax, float commissionPercentage) {

        Group groupDetail;
        JSONObject jsonObject = new JSONObject();
        groupDetail = groupService.getGroupByGroupId(groupId);


        if (groupDetail != null) {
            int chitValue = groupDetail.getGroupValue();
            int noOfMembers = groupDetail.getMemberCount();

            try {
                int biddingAmount = chitValue - kasarBalance;
                float commission = (chitValue * commissionPercentage)/100;
                float totalAuctionDividend = kasarBalance - commission;
                float dividend = totalAuctionDividend / noOfMembers;
                float nextPayment = (chitValue / noOfMembers) - dividend;

                //Need to replace it by get tax function which specifies whether to calculate tax at all.
                float taxAmount = ((commission * serviceTax) / 100);

                float winnersAmount = biddingAmount - taxAmount;

                int finalAmount = (int) winnersAmount;

                jsonObject.put("dividend", dividend);
                jsonObject.put("commission", commission);
                jsonObject.put("payment", nextPayment);
                jsonObject.put("finalAmount", finalAmount);
                jsonObject.put("taxAmount", taxAmount);
            } catch (Exception e) {
                e.printStackTrace();
            }

        }
        return jsonObject.toString();
    }
}
