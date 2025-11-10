package com.kh.gymhub.service;

import com.kh.gymhub.model.vo.Member;

public interface MemberService {
    Member getMemberById(String memberId);
    int getMemberCountById(String memberId);
    int addMember(Member member);
    Member login(String memberId, String memberPwd);
}