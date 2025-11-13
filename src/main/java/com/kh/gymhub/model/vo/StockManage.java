package com.kh.gymhub.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 재고 관리 VO (입출고 내역)
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class StockManage {
    private int stockManageNo;         // 재고관리 번호(PK)
    private int stockId;               // 재고 물품 ID(FK)
    private int gymNo;                 // 헬스장 번호(FK)
    private String stockManageType;    // 관리 유형(입고/출고)
    private Date stockManageDate;      // 입출고일
    private int stockManageCount;      // 입출고 수량 (입고/출고 시 입력한 수량)

    // JOIN용 필드
    private String stockName;          // 물품명
    private int stockCount;            // 현재 재고 수량
    private int stockPrice;            // 물품 가격
}