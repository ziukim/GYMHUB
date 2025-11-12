package com.kh.gymhub.model.mapper;

import com.kh.gymhub.model.vo.Member;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface MemberMapper {
    Member getMemberById(@Param("memberId") String memberId);
    int getMemberCountById(@Param("memberId") String memberId);
    int addMember(Member member);
    int updateMemberInfo(Member member);
    int updatePassword(@Param("memberNo") int memberNo, @Param("memberPwd") String memberPwd);
    Member getMemberForLogin(@Param("memberId") String memberId);
    Member getMemberByIdForGymRegistration(@Param("memberId") String memberId);
    int updateMemberGymNo(@Param("memberNo") int memberNo, @Param("gymNo") Integer gymNo);
    
    // 트레이너 등록용 조회 (memberType=2, gymNo=null)
    Member getTrainerByIdForRegistration(@Param("memberId") String memberId);
    
    // 특정 헬스장의 트레이너 목록 조회 (memberType=2, gymNo=해당 헬스장)
    java.util.List<Member> selectTrainersByGymNo(@Param("gymNo") int gymNo);
}

