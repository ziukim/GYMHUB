package com.kh.gymhub.model.mapper;

import com.kh.gymhub.model.vo.PurchaseItem;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface PurchaseItemMapper {
    int insertPurchaseItem(PurchaseItem purchaseItem);
    
    /**
     * 구매 번호로 구매 아이템 조회
     * @param purchaseNo 구매 번호
     * @return 구매 아이템 정보
     */
    PurchaseItem selectPurchaseItemByPurchaseNo(@Param("purchaseNo") int purchaseNo);
}

