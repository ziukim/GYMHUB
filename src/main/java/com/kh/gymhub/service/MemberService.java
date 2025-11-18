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
    
    /**
     * 헬스장에서 회원을 강제로 삭제 (환불 처리 포함)
     * @param memberNo 삭제할 회원 번호
     * @param gymNo 헬스장 번호
     * @param gymOwnerPassword 헬스장 운영자 비밀번호
     * @return 성공 여부 (1: 성공, 0: 실패, -1: 비밀번호 불일치, -2: 권한 없음)
     */
    int forceDeleteMemberByGym(int memberNo, int gymNo, String gymOwnerPassword);

}