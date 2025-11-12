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
    int updateProfileImage(@Param("memberNo") int memberNo, @Param("photoPath") String photoPath);
    Member getMemberForLogin(@Param("memberId") String memberId);
    Member getMemberByIdForGymRegistration(@Param("memberId") String memberId);
}

