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
public class Purchase {
    private int purchaseNo;
    private int memberNo;
    private int gymNo;
    private Date purchaseDate;
    private int purchaseCost;
    private String purchaseStatus;
}

