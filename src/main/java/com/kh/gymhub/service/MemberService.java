package com.kh.gymhub.service;

import com.kh.gymhub.model.vo.Gym;
import com.kh.gymhub.model.vo.Member;

public interface MemberService {
    Member getMemberById(String memberId);
    int getMemberCountById(String memberId);
    int addMember(Member member);
    int addGymOwner(Member member, Gym gym);
    int updateMemberInfo(Member member);
    int updatePassword(int memberNo, String newPassword);
    int updateProfileImage(int memberNo, String photoPath);
    Member login(String memberId, String memberPwd);
    Member getMemberByIdForGymRegistration(String memberId);
    int withdrawMember(int memberNo, String password);

}