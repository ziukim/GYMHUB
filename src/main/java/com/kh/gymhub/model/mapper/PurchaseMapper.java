package com.kh.gymhub.model.mapper;

import com.kh.gymhub.model.vo.Purchase;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface PurchaseMapper {
    int insertPurchase(Purchase purchase);
    Purchase selectPurchaseByNo(@Param("purchaseNo") int purchaseNo);
    
    // 회원 삭제 시 구매 상태를 환불로 변경
    int refundPurchasesByMemberNo(@Param("memberNo") int memberNo, @Param("gymNo") int gymNo);
    
    // 회원번호와 헬스장번호로 구매 목록 조회
    java.util.List<Purchase> selectPurchasesByMemberNoAndGymNo(@Param("memberNo") int memberNo, @Param("gymNo") int gymNo);
}

