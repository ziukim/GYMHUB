package com.kh.gymhub.model.mapper;

import com.kh.gymhub.model.vo.Purchase;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface PurchaseMapper {
    int insertPurchase(Purchase purchase);
    Purchase selectPurchaseByNo(@Param("purchaseNo") int purchaseNo);
}

