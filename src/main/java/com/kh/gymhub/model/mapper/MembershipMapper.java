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
}

