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
public class Membership {
    private int membershipNo;
    private int purchaseNo;
    private int memberNo;
    private int gymNo;
    private Date startDate;
    private Date endDate;
    private String membershipStatus;
    private Date membershipCreateat;
    private Date membershipUpdate;
}

