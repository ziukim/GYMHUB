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
public class Sales {
    private int salesNo;
    private int purchaseNo;
    private Integer stockId;
    private int gymNo;
    private String salesType;
    private Date salesDate;
}

