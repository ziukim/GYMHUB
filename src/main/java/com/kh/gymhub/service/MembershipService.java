package com.kh.gymhub.service;

public interface MembershipService {
    // 만료된 회원권 상태 업데이트 및 회원의 GYM_NO를 NULL로 변경
    void updateExpiredMembershipsAndClearGymNo();
    
    // 특정 회원의 회원권 만료 처리
    int expireMembershipByMemberNo(int memberNo, int gymNo);
}

