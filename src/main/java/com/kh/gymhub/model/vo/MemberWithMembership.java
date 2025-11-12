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
public class MemberWithMembership {
    // Member 정보
    private int memberNo;
    private String memberId;
    private String memberName;
    private String memberPhone;
    private String memberEmail;
    private String memberAddress;
    
    // Membership 정보
    private int membershipNo;
    private Date startDate;
    private Date endDate;
    private String membershipStatus;
    
    // Locker 정보
    private String lockerRealNum;
    
    // 구매한 상품 정보 (문자열로 합쳐서 표시)
    private String productNames;
}

