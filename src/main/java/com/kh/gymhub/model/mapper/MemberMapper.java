package com.kh.gymhub.model.mapper;

import com.kh.gymhub.model.vo.Member;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface MemberMapper {
    Member getMemberById(@Param("memberId") String memberId);
    int getMemberCountById(@Param("memberId") String memberId);
    int addMember(Member member);
}

