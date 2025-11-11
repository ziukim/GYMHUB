package com.kh.gymhub.service;

import com.kh.gymhub.model.vo.Gym;
import com.kh.gymhub.model.vo.Member;
import org.springframework.web.multipart.MultipartFile;

public interface MemberService {
    Member getMemberById(String memberId);
    int getMemberCountById(String memberId);
    int addMember(Member member);
    int addGymOwner(Member member, Gym gym);
    int updateMemberInfo(Member member);
    int updatePassword(int memberNo, String newPassword);
    int updateProfilePhoto(int memberNo, MultipartFile file);
    Member login(String memberId, String memberPwd);

}