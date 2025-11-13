package com.kh.gymhub.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 재고 물품 VO
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Stock {
    private int stockId;           // 재고 물품 ID(PK)
    private String stockName;      // 물품명
    private int stockCount;        // 재고 수량
    private int stockPrice;        // 물품 가격
    private int gymNo;             // 헬스장 번호(FK) - JOIN용

    // 추가 필드 (목표재고수량 - 계산용)
    private int targetStockCount;  // 목표재고수량 (STOCK_MANAGE에서 가져옴)
}