package com.kh.gymhub.service;

import com.kh.gymhub.model.mapper.MemberMapper;
import com.kh.gymhub.model.mapper.MembershipMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class MembershipServiceImpl implements MembershipService {

    private final MembershipMapper membershipMapper;
    private final MemberMapper memberMapper;

    @Autowired
    public MembershipServiceImpl(MembershipMapper membershipMapper, MemberMapper memberMapper) {
        this.membershipMapper = membershipMapper;
        this.memberMapper = memberMapper;
    }

    @Override
    @Transactional
    public void updateExpiredMembershipsAndClearGymNo() {
        // 1. 만료된 회원권 상태를 '만료'로 업데이트
        membershipMapper.updateExpiredMemberships();
        
        // 2. 만료된 회원권만 가지고 있고 활성 회원권이 없는 회원들의 GYM_NO를 NULL로 변경
        List<Integer> memberNos = membershipMapper.selectMemberNosWithExpiredMemberships();
        for (Integer memberNo : memberNos) {
            memberMapper.updateMemberGymNo(memberNo, null);
        }
    }

    @Override
    @Transactional
    public int expireMembershipByMemberNo(int memberNo, int gymNo) {
        return membershipMapper.expireMembershipByMemberNo(memberNo, gymNo);
    }

    /**
     * 매일 자정에 만료된 회원권의 상태를 업데이트하고,
     * 활성 회원권이 없는 회원의 GYM_NO를 NULL로 변경합니다.
     * CRON 표현식: 초 분 시 일 월 요일
     * "0 0 0 * * ?" = 매일 0시 0분 0초
     */
    @Scheduled(cron = "0 0 0 * * ?")
    public void scheduledMembershipUpdate() {
        try {
            this.updateExpiredMembershipsAndClearGymNo();
        } catch (Exception e) {
            e.printStackTrace();
            // 로그 처리 필요시 추가
        }
    }
}

