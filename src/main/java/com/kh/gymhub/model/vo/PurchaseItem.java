package com.kh.gymhub.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PurchaseItem {
    private int purchaseItemNo;
    private int membershipPeriod;
    private Integer lockerPeriod;
    private Integer ptCount;
    private Date membershipStartDate;
    private Date membershipEndDate;
    private int purchaseNo;
}

