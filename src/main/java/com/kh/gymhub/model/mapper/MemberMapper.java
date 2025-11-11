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
    int updateMember(Member member);
    int updatePassword(@Param("memberId") String memberId, @Param("newPwd") String newPwd);
}


