package com.kh.gymhub.model.mapper;

import com.kh.gymhub.model.vo.MemberWithMembership;
import com.kh.gymhub.model.vo.Membership;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface MembershipMapper {
    int insertMembership(Membership membership);
    List<MemberWithMembership> selectMembersWithMembershipByGymNo(@Param("gymNo") int gymNo);
    
    // 활성 회원 수 조회 (만료되지 않은 회원권)
    Integer selectActiveMemberCountByGymNo(@Param("gymNo") int gymNo);
    
    // 신규 회원 수 조회 (이번 달 등록)
    Integer selectNewMemberCountByGymNoAndMonth(@Param("gymNo") int gymNo, @Param("year") int year, @Param("month") int month);
    
    // 만료 예정 회원 수 조회 (7일 이내 만료)
    Integer selectExpiringMemberCountByGymNo(@Param("gymNo") int gymNo);
    
    // 특정 월 말일 기준 활성 회원 수 조회
    Integer selectActiveMemberCountByGymNoAndMonthEnd(@Param("gymNo") int gymNo, @Param("year") int year, @Param("month") int month);
    
    // 특정 월에 만료된 회원 수 조회
    Integer selectExpiredMemberCountByGymNoAndMonth(@Param("gymNo") int gymNo, @Param("year") int year, @Param("month") int month);
    
    // 회원의 활성 회원권 GYM_NO 조회 (가장 최근 활성 회원권)
    Integer selectActiveGymNoByMemberNo(@Param("memberNo") int memberNo);
    
    // 회원번호로 회원권 조회
    Membership selectMembershipByMemberNo(@Param("memberNo") int memberNo, @Param("gymNo") int gymNo);
    
    // 회원권 만료일 연장
    int updateMembershipEndDate(@Param("membershipNo") int membershipNo, @Param("newEndDate") java.util.Date newEndDate);
    
    // 회원권 시작일과 만료일 업데이트
    int updateMembershipDates(@Param("membershipNo") int membershipNo, @Param("newStartDate") java.util.Date newStartDate, @Param("newEndDate") java.util.Date newEndDate);
    
    // 만료된 회원권 상태 업데이트 (END_DATE가 SYSDATE보다 이전인 회원권)
    int updateExpiredMemberships();
    
    // 특정 회원의 회원권 만료 처리 (회원 삭제 시 사용)
    int expireMembershipByMemberNo(@Param("memberNo") int memberNo, @Param("gymNo") int gymNo);
    
    // 만료된 회원권을 가진 회원들의 GYM_NO를 NULL로 변경할 회원번호 목록 조회
    java.util.List<Integer> selectMemberNosWithExpiredMemberships();
}

