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
public class PtPass {
    private int ptPassNo;
    private int purchaseNo;
    private int memberNo;
    private int gymNo;
    private Date ptStart;
    private Date ptEnd;
    private int ptUsedCount;
    private int ptTotalCount;
}

