package com.kh.gymhub.model.mapper;

import com.kh.gymhub.model.vo.PurchaseItem;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PurchaseItemMapper {
    int insertPurchaseItem(PurchaseItem purchaseItem);
}

