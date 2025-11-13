package com.kh.gymhub.service;

import com.kh.gymhub.model.mapper.*;
import com.kh.gymhub.model.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Service
public class PurchaseServiceImpl implements PurchaseService {

    private final PurchaseMapper purchaseMapper;
    private final PurchaseItemMapper purchaseItemMapper;
    private final MembershipMapper membershipMapper;
    private final PtPassMapper ptPassMapper;
    private final LockerMapper lockerMapper;
    private final MemberMapper memberMapper;
    private final SalesMapper salesMapper;

    @Autowired
    public PurchaseServiceImpl(PurchaseMapper purchaseMapper,
                              PurchaseItemMapper purchaseItemMapper,
                              MembershipMapper membershipMapper,
                              PtPassMapper ptPassMapper,
                              LockerMapper lockerMapper,
                              MemberMapper memberMapper,
                              SalesMapper salesMapper) {
        this.purchaseMapper = purchaseMapper;
        this.purchaseItemMapper = purchaseItemMapper;
        this.membershipMapper = membershipMapper;
        this.ptPassMapper = ptPassMapper;
        this.lockerMapper = lockerMapper;
        this.memberMapper = memberMapper;
        this.salesMapper = salesMapper;
    }

    @Override
    @Transactional
    public int registerMemberPurchase(Member member, int gymNo, List<Product> selectedProducts,
                                     Date startDate, Date endDate, String lockerRealNum) {
        try {
            // 1. 총 가격 계산
            int totalCost = 0;
            for (Product product : selectedProducts) {
                totalCost += product.getProductPrice();
            }

            // 2. PURCHASE 테이블에 INSERT
            Purchase purchase = Purchase.builder()
                    .memberNo(member.getMemberNo())
                    .gymNo(gymNo)
                    .purchaseCost(totalCost)
                    .purchaseStatus("결제")
                    .build();
            
            int purchaseResult = purchaseMapper.insertPurchase(purchase);
            if (purchaseResult <= 0) {
                return 0;
            }

            // 3. PURCHASE_ITEM 테이블에 INSERT
            int membershipPeriod = 0;
            Integer lockerPeriod = null;
            Integer ptCount = null;

            for (Product product : selectedProducts) {
                if ("회원권".equals(product.getProductType())) {
                    membershipPeriod = product.getDurationMonths();
                } else if ("락커".equals(product.getProductType())) {
                    lockerPeriod = product.getDurationMonths();
                } else if ("PT".equals(product.getProductType())) {
                    ptCount = product.getDurationMonths();
                }
            }

            PurchaseItem purchaseItem = PurchaseItem.builder()
                    .purchaseNo(purchase.getPurchaseNo())
                    .membershipPeriod(membershipPeriod)
                    .lockerPeriod(lockerPeriod)
                    .ptCount(ptCount)
                    .membershipStartDate(startDate)
                    .membershipEndDate(endDate)
                    .build();

            int purchaseItemResult = purchaseItemMapper.insertPurchaseItem(purchaseItem);
            if (purchaseItemResult <= 0) {
                return 0;
            }

            // 4. MEMBERSHIP 테이블에 INSERT (회원권이 있는 경우)
            if (membershipPeriod > 0) {
                Membership membership = Membership.builder()
                        .purchaseNo(purchase.getPurchaseNo())
                        .memberNo(member.getMemberNo())
                        .gymNo(gymNo)
                        .startDate(startDate)
                        .endDate(endDate)
                        .membershipStatus("정상")
                        .build();

                int membershipResult = membershipMapper.insertMembership(membership);
                if (membershipResult <= 0) {
                    return 0;
                }
            }

            // 5. LOCKER_PASS 테이블에 INSERT (락커권이 있고 락커 번호가 있는 경우)
            if (lockerPeriod != null && lockerPeriod > 0 && lockerRealNum != null && !lockerRealNum.trim().isEmpty()) {
                LockerPass lockerInfo = lockerMapper.selectLockerByRealNum(lockerRealNum, gymNo);
                if (lockerInfo != null) {
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(startDate);
                    cal.add(Calendar.DAY_OF_MONTH, lockerPeriod);
                    Date lockerEndDate = cal.getTime();

                    LockerPass lockerPass = LockerPass.builder()
                            .purchaseNo(purchase.getPurchaseNo())
                            .lockerNo(lockerInfo.getLockerNo())
                            .memberNo(member.getMemberNo())
                            .lockerPassStart(startDate)
                            .lockerEnd(lockerEndDate)
                            .lockerPassStatus("정상")
                            .build();

                    int lockerResult = lockerMapper.insertLockerPass(lockerPass);
                    if (lockerResult <= 0) {
                        return 0;
                    }
                    
                    // 락커 상태를 "사용중"으로 업데이트
                    int updateStatusResult = lockerMapper.updateLockerStatus(lockerInfo.getLockerNo(), "사용중");
                    if (updateStatusResult <= 0) {
                        return 0;
                    }
                }
            }

            // 6. PT_PASS 테이블에 INSERT (PT권이 있는 경우)
            if (ptCount != null && ptCount > 0) {
                Calendar cal = Calendar.getInstance();
                cal.setTime(startDate);
                cal.add(Calendar.MONTH, 6);
                Date ptEndDate = cal.getTime();

                PtPass ptPass = PtPass.builder()
                        .purchaseNo(purchase.getPurchaseNo())
                        .memberNo(member.getMemberNo())
                        .gymNo(gymNo)
                        .ptStart(startDate)
                        .ptEnd(ptEndDate)
                        .ptUsedCount(0)
                        .ptTotalCount(ptCount)
                        .build();

                int ptResult = ptPassMapper.insertPtPass(ptPass);
                if (ptResult <= 0) {
                    return 0;
                }
            }

            // 7. 회원의 GYM_NO 업데이트 (등록 완료 후 헬스장과 연결)
            int updateGymNoResult = memberMapper.updateMemberGymNo(member.getMemberNo(), gymNo);
            if (updateGymNoResult <= 0) {
                return 0;
            }

            // 8. SALES 테이블에 INSERT (매출 정보 등록)
            Sales sales = Sales.builder()
                    .purchaseNo(purchase.getPurchaseNo())
                    .stockId(null)
                    .gymNo(gymNo)
                    .salesType("이용권")
                    .build();

            int salesResult = salesMapper.insertSales(sales);
            if (salesResult <= 0) {
                return 0;
            }

            return purchase.getPurchaseNo();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
}

